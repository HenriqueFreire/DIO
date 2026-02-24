from fastapi.testclient import TestClient
from backend.main import app

client = TestClient(app)

def test_text_to_speech():
    response = client.post("/tts", json={"text": "Hello, world!"})
    assert response.status_code == 200
    assert response.headers["content-type"] == "audio/mpeg"
    assert response.content is not None
