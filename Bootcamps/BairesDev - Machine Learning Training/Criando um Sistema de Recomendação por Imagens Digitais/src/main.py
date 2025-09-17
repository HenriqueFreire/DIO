import os
import random
import glob
import subprocess
from feature_extractor import FeatureExtractor
from recommender import Recommender

SELECTED_CLASSES = ['laptop', 'watch', 'cellphone', 'cup']
MODEL_PATH = "fine_tuned_model.keras"
FEATURES_PATH = "features_fine_tuned.pkl"

def get_random_image(root_dir, class_list):
    """Pega um caminho de imagem aleatório de uma das classes selecionadas."""
    random_class = random.choice(class_list)
    class_dir = os.path.join(root_dir, random_class)
    all_images = glob.glob(os.path.join(class_dir, '*.png'))
    return random.choice(all_images)

def main():
    """
    Ponto de entrada principal para o sistema de recomendação.
    """
    base_dir = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
    data_dir = os.path.join(base_dir, 'data', '101_ObjectCategories')
    model_path_abs = os.path.join(base_dir, MODEL_PATH)
    features_path_abs = os.path.join(base_dir, FEATURES_PATH)

    # 1. Verificar e treinar o modelo se necessário
    if not os.path.exists(model_path_abs):
        print(f"Modelo {MODEL_PATH} não encontrado. Iniciando o treinamento...")
        train_script_path = os.path.join(base_dir, 'src', 'train.py')
        # Executa o script de treinamento diretamente
        subprocess.run(["python3", train_script_path], check=True, cwd=base_dir)
    else:
        print(f"Modelo {MODEL_PATH} encontrado.")

    # 2. Extrair features usando o modelo treinado
    extractor = FeatureExtractor(model_path=model_path_abs)
    if not os.path.exists(features_path_abs):
        print(f"Arquivo de features {FEATURES_PATH} não encontrado. Extraindo features...")
        image_paths_to_process = []
        for class_name in SELECTED_CLASSES:
            class_dir = os.path.join(data_dir, class_name)
            image_paths_to_process.extend(glob.glob(os.path.join(class_dir, '*.png')))
        
        features = extractor.extract_features_from_paths(image_paths_to_process)
        extractor.save_features(features, features_path_abs)
        print(f"Features salvas em: {features_path_abs}")
    else:
        print(f"Carregando features de: {features_path_abs}")
        features = extractor.load_features(features_path_abs)

    # 3. Escolher uma imagem de consulta aleatória
    query_image_path = get_random_image(data_dir, SELECTED_CLASSES)
    
    # 4. Obter recomendações
    print(f"\nBuscando recomendações para: {query_image_path}")
    recommender = Recommender(features)
    recommendations = recommender.get_recommendations(query_image_path, top_k=5)

    # 5. Exibir resultados
    print("\nImagens recomendadas:")
    if recommendations:
        for img_path, score in recommendations:
            print(f"- {img_path} (Similaridade: {score:.4f})")
    else:
        print("Nenhuma recomendação encontrada.")

if __name__ == '__main__':
    main()
