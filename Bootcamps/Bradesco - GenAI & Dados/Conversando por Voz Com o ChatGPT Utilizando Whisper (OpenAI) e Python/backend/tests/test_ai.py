from fastapi.testclient import TestClient
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from app.database import Base, get_db
from app.main import app
import pytest
import os

SQLALCHEMY_DATABASE_URL = "sqlite:///./test_ai.db"

engine = create_engine(
    SQLALCHEMY_DATABASE_URL, connect_args={"check_same_thread": False}
)
TestingSessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

def override_get_db():
    try:
        db = TestingSessionLocal()
        yield db
    finally:
        db.close()

app.dependency_overrides[get_db] = override_get_db

client = TestClient(app)

@pytest.fixture(autouse=True)
def setup_db():
    Base.metadata.create_all(bind=engine)
    yield
    Base.metadata.drop_all(bind=engine)
    if os.path.exists("./test_ai.db"):
        os.remove("./test_ai.db")

def test_ai_narration_endpoint():
    # Note: text should be long enough or clear for TTS
    response = client.post("/api/v1/ai/narrate?text=Olá pessoal, tudo bem?")
    assert response.status_code == 200
    assert "audio_path" in response.json()

def test_ai_correction_endpoint():
    # "Nós vai" is a common error in Portuguese
    response = client.post("/api/v1/ai/correct_text?text=nós vai")
    assert response.status_code == 200
    data = response.json()
    # LanguageTool might suggest "nós vamos" or similar
    assert "Sugestão de correção:" in data["correction"]
    assert "vamos" in data["correction"].lower()

def test_message_with_ai_processing():
    response = client.post(
        "/api/v1/messages/",
        json={"sender_type": "user", "content": "nós vai"},
    )
    assert response.status_code == 200
    data = response.json()
    assert "Sugestão de correção:" in data["corrected_content"]
    assert data["narrated_content"] is not None
    assert os.path.exists(data["narrated_content"])

def test_transcribe_placeholder():
    # We can't easily test real audio without a file, 
    # but we can check the endpoint exists.
    # In a real scenario, we'd provide a small wav file.
    pass
