import pickle
from keras.preprocessing import image
from keras.models import Model, load_model
from keras.applications.vgg16 import preprocess_input
import numpy as np
import os

class FeatureExtractor:
    def __init__(self, model_path):
        # Carrega o modelo treinado
        base_model = load_model(model_path)
        # Usa a camada de pooling como extrator de features
        self.model = Model(inputs=base_model.input, outputs=base_model.get_layer('feature_extraction_layer').output)


    def _preprocess_image(self, img_path):
        """Carrega e pré-processa uma imagem."""
        img = image.load_img(img_path, target_size=(224, 224))
        x = image.img_to_array(img)
        x = np.expand_dims(x, axis=0)
        x = preprocess_input(x)
        return x

    def extract_feature(self, img_path):
        """Extrai o vetor de features de uma única imagem."""
        x = self._preprocess_image(img_path)
        feature = self.model.predict(x)[0]
        return feature / np.linalg.norm(feature) # Normaliza o vetor

    def extract_features_from_dir(self, dir_path):
        """Extrai features de todas as imagens em um diretório."""
        features = {}
        for img_name in os.listdir(dir_path):
            img_path = os.path.join(dir_path, img_name)
            if os.path.isfile(img_path) and img_path.lower().endswith(('.png', '.jpg', '.jpeg')):
                try:
                    feature = self.extract_feature(img_path)
                    features[img_path] = feature
                except Exception as e:
                    print(f"Erro ao processar {img_path}: {e}")
        return features

    def extract_features_from_paths(self, path_list):
        """Extrai features de uma lista de caminhos de imagem."""
        features = {}
        for img_path in path_list:
            try:
                feature = self.extract_feature(img_path)
                features[img_path] = feature
            except Exception as e:
                print(f"Erro ao processar {img_path}: {e}")
        return features

    def save_features(self, features, filepath="features.pkl"):
        """Salva o dicionário de features em um arquivo."""
        with open(filepath, 'wb') as f:
            pickle.dump(features, f)

    def load_features(self, filepath="features.pkl"):
        """Carrega o dicionário de features de um arquivo."""
        with open(filepath, 'rb') as f:
            return pickle.load(f)
