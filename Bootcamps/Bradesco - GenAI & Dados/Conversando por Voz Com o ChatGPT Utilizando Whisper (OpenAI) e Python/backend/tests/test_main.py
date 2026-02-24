from fastapi.testclient import TestClient
from backend.main import app
from unittest.mock import patch
import io

client = TestClient(app)

def test_text_to_speech():
    response = client.post("/tts", json={"text": "Hello, world!"})
    assert response.status_code == 200
    assert response.headers["content-type"] == "audio/mpeg"
    assert response.content is not None

@patch("speech_recognition.Recognizer.recognize_google")
def test_speech_to_text(mock_recognize_google):
    mock_recognize_google.return_value = "Hello from audio"
    
    # Create a dummy audio file
    audio_content = b"RIFF\x00\x00\x00\x00WAVEfmt \x10\x00\x00\x00\x01\x00\x01\x00\x44\xac\x00\x00\x88\xac\x00\x00\x02\x00\x10\x00data\x00\x00\x00\x00"
    
    response = client.post(
        "/stt", 
        files={"audio_file": ("test_audio.wav", io.BytesIO(audio_content), "audio/wav")}
    )
    
    mock_recognize_google.assert_called_once()
    assert response.status_code == 200
    assert response.json() == {"text": "Hello from audio"}

def test_chat_without_api_key():
    response = client.post("/chat", json={"text": "Hello, GPT!"})
    assert response.status_code == 500
    assert response.json()["detail"] == "OpenAI client not initialized. API key might be missing."
