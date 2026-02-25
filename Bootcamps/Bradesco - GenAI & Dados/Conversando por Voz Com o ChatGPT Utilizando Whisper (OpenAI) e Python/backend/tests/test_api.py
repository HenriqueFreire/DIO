from fastapi.testclient import TestClient
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from app.database import Base, get_db
from app.main import app
import pytest

SQLALCHEMY_DATABASE_URL = "sqlite:///./test.db"

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

def test_read_root():
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"message": "Welcome to LingoLocal API"}

def test_create_message():
    response = client.post(
        "/api/v1/messages/",
        json={"sender_type": "user", "content": "Hello, AI!"},
    )
    assert response.status_code == 200
    data = response.json()
    assert data["content"] == "Hello, AI!"
    assert data["sender_type"] == "user"
    assert "id" in data

def test_read_messages():
    client.post(
        "/api/v1/messages/",
        json={"sender_type": "user", "content": "Message 1"},
    )
    client.post(
        "/api/v1/messages/",
        json={"sender_type": "ai", "content": "Response 1"},
    )
    
    response = client.get("/api/v1/messages/")
    assert response.status_code == 200
    data = response.json()
    assert len(data) == 2
    assert data[0]["content"] == "Message 1"
    assert data[1]["content"] == "Response 1"
