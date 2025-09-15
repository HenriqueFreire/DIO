import cv2
import os
import numpy as np

# --- Caminhos ---
test_images_path = 'test_images'
output_dir = 'output'

# --- Carregar Modelos e Nomes ---
recognizer = cv2.face.LBPHFaceRecognizer_create()
recognizer.read(os.path.join(output_dir, 'trainer.yml')) # Garante que o caminho esteja correto

cascades_path = os.environ.get('OPENCV_CASCADES_PATH')
if cascades_path is None:
    print("Erro: A variável de ambiente OPENCV_CASCADES_PATH não está definida.")
    exit()
detector_path = os.path.join(cascades_path, 'haarcascade_frontalface_default.xml')
detector = cv2.CascadeClassifier(detector_path)

# Mapeamento de ID para Nome (ID 0 é reservado)
names = ['Desconhecido', 'Ana de Armas', 'Ramona Young'] 

# Garante que o diretório de saída exista
if not os.path.exists(output_dir):
    os.makedirs(output_dir)

# --- Processar todas as imagens em test_images ---
print(f"[INFO] Processando imagens em '{test_images_path}'...")
for filename in os.listdir(test_images_path):
    if filename.lower().endswith(('.png', '.jpg', '.jpeg')):
        image_path = os.path.join(test_images_path, filename)
        print(f"[INFO] Processando: {image_path}")

        image = cv2.imread(image_path)
        if image is None:
            print(f"Erro: Não foi possível carregar a imagem em '{image_path}'")
            continue # Pula para a próxima imagem

        gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
        faces = detector.detectMultiScale(gray, scaleFactor=1.2, minNeighbors=5, minSize=(30, 30))

        if len(faces) == 0:
            print(f"[INFO] Nenhum rosto encontrado em {filename}.")
        else:
            print(f"[INFO] Encontrados {len(faces)} rostos em {filename}.")

        for (x, y, w, h) in faces:
            id_predicted, confidence = recognizer.predict(gray[y:y+h, x:x+w])

            if confidence < 100:
                name = names[id_predicted]
                confidence_text = f" {round(100 - confidence)}%"
            else:
                name = "Desconhecido"
                confidence_text = ""

            cv2.rectangle(image, (x, y), (x+w, y+h), (0, 255, 0), 2)
            cv2.putText(image, name + confidence_text, (x+5, y-5), cv2.FONT_HERSHEY_SIMPLEX, 1, (255, 255, 255), 2)

        # --- Salvar o Resultado ---
        output_filename = "recognized_" + filename
        output_path = os.path.join(output_dir, output_filename)
        cv2.imwrite(output_path, image)
        print(f"[INFO] Imagem processada salva em: {output_path}")

print("[INFO] Processamento de todas as imagens de teste concluído.")