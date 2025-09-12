from ultralytics import YOLO

def train_model():
    """
    Esta função treina um modelo YOLOv8.

    O desafio pede para treinar pelo menos duas novas classes. 
    A biblioteca `ultralytics` baixa automaticamente o dataset COCO se não o encontrar localmente.
    Você pode especificar um arquivo YAML para configurar o dataset, classes, etc.

    Para um teste rápido, a ultralytics usa o dataset COCO128.
    Para o desafio completo, você pode querer usar o dataset COCO completo e filtrar as classes.
    """

    # Carrega um modelo YOLOv8 pré-treinado no dataset COCO.
    # yolov8n.pt é o menor e mais rápido modelo.
    model = YOLO('yolov8n.pt')

    # Treina o modelo.
    # O parâmetro `data` aponta para o arquivo de configuração do dataset. 
    # `ultralytics` já vem com um arquivo para o COCO128.
    # Para o desafio, você criará um arquivo .yaml customizado para suas classes.

    print("\nIniciando o treinamento na CPU...")
    print("Isso pode levar alguns minutos, mesmo com o dataset de teste.")
    print(f"Parâmetros: epochs=3, imgsz=320\n")

    # Ajustado para CPU: imgsz=320 para um treinamento mais rápido.
    # Usando o nosso .yaml customizado e focando nas classes 2 (car) e 3 (motorcycle).
    results = model.train(data='desafio-coco.yaml', epochs=3, imgsz=320, classes=[2, 3], project='../data', name='training_results')

    print("\n---------------------------------")
    print("✅ Treinamento concluído com sucesso!")
    print(f"📈 Resultados e pesos do modelo foram salvos em: {results.save_dir}")
    print("---------------------------------")
    return results.save_dir

if __name__ == '__main__':
    train_model()
