
from gtts import gTTS
import pygame
import os
import time
import speech_recognition as sr

def speak(text, lang='pt-br'):
    """
    Converte um texto em áudio e o reproduz.
    Remove o arquivo de áudio após a reprodução.
    """
    try:
        tts = gTTS(text=text, lang=lang, slow=False)
        
        audio_file = 'audio.mp3'
        tts.save(audio_file)
        
        print(f"Assistente: {text}")
        
        pygame.mixer.init()
        pygame.mixer.music.load(audio_file)
        pygame.mixer.music.play()
        
        while pygame.mixer.music.get_busy():
            time.sleep(1)
            
        pygame.mixer.quit()
        
        time.sleep(0.5)
        
        os.remove(audio_file)
        
    except Exception as e:
        print(f"Erro ao tentar falar: {e}")

def get_audio():
    """
    Captura o áudio do microfone e o converte em texto.
    """
    r = sr.Recognizer()
    with sr.Microphone() as source:
        print("Ouvindo...")
        r.pause_threshold = 1
        r.adjust_for_ambient_noise(source, duration=1)
        audio = r.listen(source)
        said = ""
        try:
            said = r.recognize_google(audio, language='pt-BR')
            print(f"Você disse: {said}")
        except sr.UnknownValueError:
            # speak("Desculpe, não entendi.")
            pass # Não fala nada se não entender
        except sr.RequestError:
            speak("Desculpe, o serviço não está disponível.")
    return said.lower()
