import cv2
import os
import numpy as np
from PIL import Image

# Caminho para o banco de dados de imagens de face
path = 'data'

recognizer = cv2.face.LBPHFaceRecognizer_create()

# Obtém o caminho para o classificador Haar Cascade a partir da variável de ambiente
cascades_path = os.environ.get('OPENCV_CASCADES_PATH')
if cascades_path is None:
    print("Erro: A variável de ambiente OPENCV_CASCADES_PATH não está definida.")
    print("Execute este script dentro de um 'nix-shell' configurado corretamente.")
    exit()

detector_path = os.path.join(cascades_path, 'haarcascade_frontalface_default.xml')
if not os.path.exists(detector_path):
    print(f"Erro: Não foi possível encontrar o classificador Haar em {detector_path}")
    exit()
    
detector = cv2.CascadeClassifier(detector_path)

# Função para obter as imagens e os dados de rótulo
def get_images_and_labels(path):
    image_paths = []
    for root, dirs, files in os.walk(path):
        for file in files:
            if file.endswith(('.png', '.jpg', '.jpeg')):
                image_paths.append(os.path.join(root, file))
    
    face_samples = []
    ids = []

    for image_path in image_paths:
        # Abre a imagem usando Pillow e converte para tons de cinza
        pil_image = Image.open(image_path).convert('L')
        img_numpy = np.array(pil_image, 'uint8')

        # Obtém o ID do nome do diretório
        # Exemplo: data/person_1/image.jpg -> person_1 -> 1
        id_str = os.path.basename(os.path.dirname(image_path))
        try:
            id = int(id_str.split('_')[1])
        except (ValueError, IndexError):
            print(f"Aviso: Ignorando o diretório '{id_str}'. O nome deve ser no formato 'person_X'.")
            continue

        faces = detector.detectMultiScale(img_numpy)

        for (x, y, w, h) in faces:
            face_samples.append(img_numpy[y:y+h, x:x+w])
            ids.append(id)

    return face_samples, ids

print("\n[INFO] Treinando o modelo com as faces... Por favor, aguarde.")
faces, ids = get_images_and_labels(path)

if not faces:
    print("\n[ERRO] Nenhuma face encontrada para treinar. Verifique o diretório 'data'.")
    print("Certifique-se de que há imagens nas subpastas 'person_1', 'person_2', etc.")
    exit()

recognizer.train(faces, np.array(ids))

# Garante que o diretório de saída exista
if not os.path.exists('output'):
    os.makedirs('output')
    
model_path = 'output/trainer.yml'
recognizer.write(model_path)

# Imprime o número de faces treinadas e finaliza o programa
print(f"\n[INFO] {len(np.unique(ids))} pessoa(s) treinada(s) com sucesso.")
print(f"O modelo foi salvo em '{model_path}'")
