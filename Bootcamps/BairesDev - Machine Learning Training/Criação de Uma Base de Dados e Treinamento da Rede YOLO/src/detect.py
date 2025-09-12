from ultralytics import YOLO
from PIL import Image

def detect_objects(model_path='yolov8n.pt', image_path='path/to/your/image.jpg'):
    """
    Detecta objetos em uma imagem usando um modelo YOLO treinado.

    Args:
        model_path (str): Caminho para o modelo treinado (arquivo .pt).
        image_path (str): Caminho para a imagem que será analisada.
    """
    try:
        # Carrega o modelo treinado
        model = YOLO(model_path)

        # Executa a detecção na imagem
        results = model(image_path)

        # Mostra os resultados
        for r in results:
            im_array = r.plot()  # plota um array BGR com as detecções
            im = Image.fromarray(im_array[..., ::-1])  # converte para RGB 
            im.show()  # mostra a imagem
            im.save('results.jpg') # salva a imagem com as detecções

        print(f"Detecção concluída. Imagem com resultados salva como 'results.jpg'")

    except FileNotFoundError:
        print(f"Erro: O arquivo de imagem não foi encontrado em '{image_path}'")
        print("Por favor, atualize a variável 'image_path' com um caminho válido.")
    except Exception as e:
        print(f"Ocorreu um erro: {e}")

if __name__ == '__main__':
    # Exemplo de uso:
    # Substitua 'runs/detect/train/weights/best.pt' pelo caminho do seu modelo treinado
    # e forneça uma imagem para detecção.
    # Por enquanto, usaremos o modelo base yolov8n.pt e você deve alterar a imagem.
    detect_objects(model_path='yolov8n.pt', image_path='path/to/your/image.jpg')
