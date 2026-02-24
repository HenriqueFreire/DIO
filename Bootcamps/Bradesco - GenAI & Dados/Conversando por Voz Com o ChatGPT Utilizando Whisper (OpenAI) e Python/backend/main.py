from fastapi import FastAPI, UploadFile, File, HTTPException
from pydantic import BaseModel
import speech_recognition as sr
import os
import io
from openai import OpenAI # Import OpenAI

app = FastAPI()

# Placeholder for API keys (consider using environment variables in production)
OPENAI_API_KEY = os.getenv("OPENAI_API_KEY")

# Initialize OpenAI client conditionally
client = None
if OPENAI_API_KEY:
    client = OpenAI(api_key=OPENAI_API_KEY)

class ChatResponse(BaseModel):
    text: str
    audio_url: str = None

@app.get("/")
async def read_root():
    return {"message": "Welcome to the Fullstack Conversation App Backend!"}

@app.post("/stt")
async def speech_to_text(audio_file: UploadFile = File(...)):
    """
    Converts speech from an audio file to text using SpeechRecognition (placeholder for Whisper).
    """
    try:
        recognizer = sr.Recognizer()
        audio_content = await audio_file.read()
        audio_data = sr.AudioData(audio_content, 
                                   sample_rate=44100, # Assuming common sample rate, adjust if needed
                                   sample_width=2)     # Assuming 16-bit audio, adjust if needed

        # Using Google Web Speech API as a placeholder, as local Whisper integration
        # with SpeechRecognition might require more setup or specific libraries (e.g., whisper-jax).
        # We will replace this with actual Whisper integration later.
        text = recognizer.recognize_google(audio_data, language="pt-BR") 
        
        return {"text": text}
    except sr.UnknownValueError:
        raise HTTPException(status_code=400, detail="Could not understand audio")
    except sr.RequestError as e:
        raise HTTPException(status_code=500, detail=f"Speech service error: {e}")
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"An error occurred: {e}")

@app.post("/chat")
async def chat_with_gpt(text: str):
    """
    Sends a text message to GPT-3.5-turbo and returns the AI's response.
    """
    if not client:
        raise HTTPException(status_code=500, detail="OpenAI client not initialized. API key might be missing.")
    
    try:
        response = client.chat.completions.create(
            model="gpt-3.5-turbo",
            messages=[{"role": "user", "content": text}],
            max_tokens=150
        )
        ai_response = response.choices[0].message.content
        return {"text": ai_response}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"GPT-3.5-turbo error: {e}")

from gtts import gTTS
from fastapi.responses import StreamingResponse

class TTSRequest(BaseModel):
    text: str
    lang: str = "pt"

@app.post("/tts")
async def text_to_speech(request: TTSRequest):
    """
    Converts text to speech using Google Text-to-Speech (gTTS).
    """
    try:
        tts = gTTS(text=request.text, lang=request.lang)
        mp3_fp = io.BytesIO()
        tts.write_to_fp(mp3_fp)
        mp3_fp.seek(0)
        return StreamingResponse(mp3_fp, media_type="audio/mpeg", headers={"Content-Disposition": "attachment; filename=audio.mp3"})
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"gTTS error: {e}")

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
