import pyttsx3
import os
import uuid
import language_tool_python
import whisper

class AIHandler:
    def __init__(self):
        # TTS Engine
        self.tts_engine = pyttsx3.init()
        self.tts_engine.setProperty('rate', 150)
        
        # Audio storage
        self.output_dir = "backend/static/audio"
        os.makedirs(self.output_dir, exist_ok=True)
        
        # Language Tool for Portuguese corrections
        self.tool = language_tool_python.LanguageTool('pt-BR')
        
        # Whisper model for STT (tiny for speed/local resources)
        self.stt_model = whisper.load_model("tiny")

    def narrate(self, text: str) -> str:
        """
        Converts text to speech and returns the file path.
        """
        filename = f"{uuid.uuid4()}.mp3"
        filepath = os.path.join(self.output_dir, filename)
        
        try:
            self.tts_engine.save_to_file(text, filepath)
            self.tts_engine.runAndWait()
            return filepath
        except Exception as e:
            print(f"TTS Error: {e}")
            return None

    def correct_text(self, text: str) -> str:
        """
        Corrects grammar and spelling in Portuguese using LanguageTool.
        """
        matches = self.tool.check(text)
        corrected_text = language_tool_python.utils.correct(text, matches)
        
        if corrected_text != text:
            return f"Sugestão de correção: {corrected_text}"
        return None

    def transcribe_audio(self, audio_path: str) -> str:
        """
        Transcribes audio to text using Whisper.
        """
        try:
            result = self.stt_model.transcribe(audio_path)
            return result["text"].strip()
        except Exception as e:
            print(f"STT Error: {e}")
            return None

ai_handler = AIHandler()
