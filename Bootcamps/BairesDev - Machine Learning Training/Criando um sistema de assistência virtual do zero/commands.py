import webbrowser
import wikipedia
import random
from datetime import datetime
from speech import speak, get_audio

# Configura o Wikipedia para o português
wikipedia.set_lang("pt")

def search_youtube():
    speak("O que você quer pesquisar no Youtube?")
    keyword = get_audio()
    if keyword:
        url = f"https://www.youtube.com/results?search_query={keyword}"
        webbrowser.get().open(url)
        speak(f"Aqui está o que eu encontrei para {keyword} no youtube")

def search_wikipedia():
    speak("O que você quer pesquisar?")
    query = get_audio()
    if query:
        try:
            result = wikipedia.summary(query, sentences=3)
            speak("De acordo com a Wikipedia")
            print(result)
            speak(result)
        except wikipedia.exceptions.PageError:
            speak(f"Não encontrei nenhum resultado para {query} na Wikipedia.")
        except wikipedia.exceptions.DisambiguationError as e:
            speak(f"Existem múltiplos resultados para {query}. Por favor, seja mais específico. Resultados possíveis: {e.options[:3]}")

def get_joke():
    jokes = [
        "O que o pato disse para a pata? Vem quá!",
        "Por que o jacaré tirou o filho da escola? Porque ele já réptil de ano.",
        "Qual é a fórmula da água benta? H Deus O!",
        "O que o tomate foi fazer no banco? Foi tirar extrato.",
        "Por que a velhinha não usa relógio? Porque ela é uma senhora de idade."
    ]
    joke = random.choice(jokes)
    speak(joke)

def get_time():
    strTime = datetime.now().strftime("%H:%M")
    speak(f"São {strTime}")

def find_pharmacy():
    speak("Abrindo o mapa com as farmácias mais próximas.")
    url = "https://www.google.com/maps/search/farmácias"
    webbrowser.get().open(url)