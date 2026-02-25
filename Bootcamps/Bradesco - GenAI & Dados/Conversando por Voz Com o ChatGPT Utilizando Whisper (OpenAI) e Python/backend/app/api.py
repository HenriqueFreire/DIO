from fastapi import APIRouter, Depends, HTTPException, File, UploadFile
from sqlalchemy.orm import Session
from typing import List
import os
import uuid
from . import crud, models, schemas
from .database import get_db
from .ai_handler import ai_handler

router = APIRouter()

@router.post("/messages/", response_model=schemas.Message)
def create_message(message: schemas.MessageCreate, db: Session = Depends(get_db)):
    # If the message is from the user, we might want to correct it.
    # If it's a response from AI, we might want to narrate it.
    # For now, let's apply both where it makes sense.
    
    if message.sender_type == "user":
        correction = ai_handler.correct_text(message.content)
        if correction:
            message.corrected_content = correction
    
    # Narrate if not already narrated
    if not message.narrated_content:
        audio_path = ai_handler.narrate(message.content)
        message.narrated_content = audio_path

    return crud.create_message(db=db, message=message)

@router.get("/messages/", response_model=List[schemas.Message])
def read_messages(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    messages = crud.get_messages(db, skip=skip, limit=limit)
    return messages

@router.post("/ai/narrate")
def narrate_text(text: str):
    audio_path = ai_handler.narrate(text)
    if not audio_path:
        raise HTTPException(status_code=500, detail="Failed to narrate text")
    return {"audio_path": audio_path}

@router.post("/ai/correct_text")
def correct_text(text: str):
    correction = ai_handler.correct_text(text)
    return {"original": text, "correction": correction}

@router.post("/ai/transcribe")
async def transcribe_audio(file: UploadFile = File(...)):
    # Save file temporarily to process with Whisper
    temp_dir = "backend/static/temp"
    os.makedirs(temp_dir, exist_ok=True)
    temp_path = os.path.join(temp_dir, f"{uuid.uuid4()}_{file.filename}")
    
    try:
        with open(temp_path, "wb") as buffer:
            content = await file.read()
            buffer.write(content)
        
        text = ai_handler.transcribe_audio(temp_path)
        
        if text is None:
            raise HTTPException(status_code=500, detail="Failed to transcribe audio")
        
        return {"text": text}
    finally:
        if os.path.exists(temp_path):
            os.remove(temp_path)

@router.post("/messages/audio", response_model=schemas.Message)
async def create_audio_message(file: UploadFile = File(...), db: Session = Depends(get_db)):
    # 1. Save audio file locally
    audio_dir = "backend/static/audio"
    os.makedirs(audio_dir, exist_ok=True)
    filename = f"{uuid.uuid4()}_{file.filename}"
    filepath = os.path.join(audio_dir, filename)
    
    try:
        with open(filepath, "wb") as buffer:
            content = await file.read()
            buffer.write(content)
        
        # 2. Transcribe
        text = ai_handler.transcribe_audio(filepath)
        if not text:
            raise HTTPException(status_code=500, detail="Transcription failed")
        
        # 3. Correct
        correction = ai_handler.correct_text(text)
        
        # 4. Narrate (optional for user message, but good for feedback loop if desired)
        # However, PLAN.md says narrated_content is the path to audio file. 
        # Here, the audio file is the input itself.
        
        message_data = schemas.MessageCreate(
            sender_type="user",
            content=text,
            narrated_content=filepath, # Using the uploaded file as the narrated content
            corrected_content=correction
        )
        
        return crud.create_message(db=db, message=message_data)
        
    except Exception as e:
        if os.path.exists(filepath):
            os.remove(filepath)
        raise HTTPException(status_code=500, detail=str(e))
