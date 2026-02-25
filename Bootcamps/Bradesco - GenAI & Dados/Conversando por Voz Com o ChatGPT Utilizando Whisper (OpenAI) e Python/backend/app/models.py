from datetime import datetime
from sqlalchemy import Column, Integer, String, DateTime, Enum
import enum
from .database import Base

class SenderType(str, enum.Enum):
    USER = "user"
    AI = "ai"

class Message(Base):
    __tablename__ = "messages"

    id = Column(Integer, primary_key=True, index=True)
    sender_type = Column(String, index=True) # "user" or "ai"
    content = Column(String)
    narrated_content = Column(String, nullable=True) # Path to audio file
    corrected_content = Column(String, nullable=True) # Correction in Portuguese
    created_at = Column(DateTime, default=datetime.utcnow)
