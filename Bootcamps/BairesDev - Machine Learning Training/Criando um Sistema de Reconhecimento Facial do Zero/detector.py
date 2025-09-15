import cv2
import os

# Lê o caminho para os classificadores da variável de ambiente definida no shell.nix
cascades_path = os.environ.get('OPENCV_CASCADES_PATH')

if cascades_path is None:
    print("Erro: A variável de ambiente 'OPENCV_CASCADES_PATH' não foi definida.")
    print("Execute este script dentro de um 'nix-shell' para configurar o ambiente corretamente.")
    exit()

# Constrói o caminho completo para o arquivo XML
cascade_file = os.path.join(cascades_path, 'haarcascade_frontalface_default.xml')

# Carrega o classificador Haar Cascade
face_cascade = cv2.CascadeClassifier(cascade_file)

# Verifica se o classificador foi carregado corretamente
if face_cascade.empty():
    print(f"Erro: Não foi possível carregar o classificador Haar Cascade do caminho: {cascade_file}")
    exit()

def run_webcam_detector():
    """
    Inicia a webcam, detecta faces em tempo real e exibe o vídeo.
    """
    cap = cv2.VideoCapture(0)
    if not cap.isOpened():
        print("Erro: Não foi possível abrir a webcam.")
        return

    print("Webcam iniciada. Pressione 'q' para sair.")

    while True:
        ret, frame = cap.read()
        if not ret:
            break

        gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
        faces = face_cascade.detectMultiScale(
            gray,
            scaleFactor=1.1,
            minNeighbors=5,
            minSize=(30, 30)
        )

        for (x, y, w, h) in faces:
            cv2.rectangle(frame, (x, y), (x+w, y+h), (255, 0, 0), 2)

        # Exibe o frame resultante em uma janela
        cv2.imshow('Detector de Faces', frame)

        # Define a tecla 'q' para parar a execução
        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

    cap.release()
    cv2.destroyAllWindows()
    print("Webcam desligada.")

if __name__ == '__main__':
    run_webcam_detector()