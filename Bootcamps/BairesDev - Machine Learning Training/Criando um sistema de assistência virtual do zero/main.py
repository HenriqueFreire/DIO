from speech import speak, get_audio
from commands import search_youtube, search_wikipedia, get_joke, get_time, find_pharmacy

if __name__ == "__main__":
    speak("Olá! Como posso ajudar?")
    while True:
        text = get_audio()
        if text:
            if 'youtube' in text:
                search_youtube()
            elif 'pesquisar' in text:
                search_wikipedia()
            elif 'piada' in text:
                get_joke()
            elif 'que horas são' in text:
                get_time()
            elif 'farmácia' in text:
                find_pharmacy()
            elif 'sair' in text:
                speak("Até mais!")
                break