from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles
import os
from . import models, api
from .database import engine

models.Base.metadata.create_all(bind=engine)

app = FastAPI(title="LingoLocal API")

# Configure CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Mount static files
static_dir = "backend/static"
os.makedirs(static_dir, exist_ok=True)
app.mount("/static", StaticFiles(directory=static_dir), name="static")

app.include_router(api.router, prefix="/api/v1")

@app.get("/")
def read_root():
    return {"message": "Welcome to LingoLocal API"}
