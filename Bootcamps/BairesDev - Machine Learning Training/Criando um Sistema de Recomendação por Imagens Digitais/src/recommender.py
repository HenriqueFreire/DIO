from sklearn.metrics.pairwise import cosine_similarity

class Recommender:
    def __init__(self, features_dict):
        self.features_dict = features_dict
        self.image_paths = list(features_dict.keys())
        self.feature_list = list(features_dict.values())

    def get_recommendations(self, query_image_path, top_k=5):
        """
        Encontra as top_k imagens mais similares à imagem de consulta.
        """
        if query_image_path not in self.features_dict:
            # A imagem de consulta pode não ter sido parte do conjunto de treinamento,
            # então sua feature não estaria no dicionário. 
            # O script principal deve lidar com a extração da feature da imagem de consulta antes de chamar este método.
            raise ValueError("Imagem de consulta não encontrada no dicionário de features.")

        query_feature = self.features_dict[query_image_path]

        # Calcula a similaridade de cosseno entre a consulta e todas as outras imagens
        similarities = cosine_similarity([query_feature], self.feature_list)[0]

        # Combina imagens com seus scores de similaridade
        scores = list(zip(self.image_paths, similarities))

        # Ordena por similaridade (decrescente)
        sorted_scores = sorted(scores, key=lambda x: x[1], reverse=True)

        # Retorna as top_k+1 recomendações (ignorando a própria imagem de consulta)
        # Filtra para não recomendar a mesma imagem
        final_recommendations = []
        for path, score in sorted_scores:
            if path != query_image_path:
                final_recommendations.append((path, score))
            if len(final_recommendations) == top_k:
                break
        
        return final_recommendations