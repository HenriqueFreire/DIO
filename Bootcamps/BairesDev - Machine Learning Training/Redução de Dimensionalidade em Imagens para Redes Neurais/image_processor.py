import sys

def read_ppm_p3(filename):
    """Lê uma imagem no formato PPM P3 (texto)."""
    print(f"Reading file '{filename}'...")
    with open(filename, 'r') as f:
        lines = f.readlines()

    # Remove comentários e linhas em branco
    lines_without_comments = [line.strip() for line in lines if not line.strip().startswith('#') and line.strip()]

    # Verifica o "número mágico" P3
    if lines_without_comments[0] != 'P3':
        raise ValueError("File format is not PPM P3. Header must be 'P3'.")

    # Lê largura, altura e valor máximo da cor
    width, height = map(int, lines_without_comments[1].split())
    max_val = int(lines_without_comments[2])
    print(f"Image detected: {width}x{height}, max color value: {max_val}")

    # Lê os dados dos pixels
    pixel_data_str = ' '.join(lines_without_comments[3:]).split()
    pixel_data_int = [int(val) for val in pixel_data_str]

    pixels = []
    # Agrupa os valores em tuplas (R, G, B)
    for i in range(0, len(pixel_data_int), 3):
        pixels.append((pixel_data_int[i], pixel_data_int[i+1], pixel_data_int[i+2]))

    if len(pixels) != width * height:
        raise ValueError("The number of pixels does not match the image dimensions.")

    return width, height, max_val, pixels

def write_ppm_p3(filename, width, height, max_val, pixels):
    """Escreve uma imagem no formato PPM P3 (texto)."""
    print(f"Writing file '{filename}'...")
    with open(filename, 'w') as f:
        f.write('P3\n')
        f.write(f'{width} {height}\n')
        f.write(f'{max_val}\n')
        for r, g, b in pixels:
            f.write(f'{r} {g} {b} ')
    print("File saved successfully!")

def to_grayscale(pixels):
    """Converte uma lista de pixels RGB para escala de cinza."""
    gray_pixels = []
    for r, g, b in pixels:
        # Usa a média simples para calcular o valor de cinza
        gray_value = (r + g + b) // 3
        gray_pixels.append((gray_value, gray_value, gray_value))
    return gray_pixels

def to_binarized(pixels, threshold=127):
    """Converte uma lista de pixels RGB para preto e branco (binarizado)."""
    binarized_pixels = []
    # Primeiro, converte para cinza para ter uma base para o limiar
    gray_pixels = to_grayscale(pixels)
    for r, _, _ in gray_pixels: # Pega qualquer um dos valores, já que r=g=b
        if r < threshold:
            binarized_pixels.append((0, 0, 0)) # Preto
        else:
            binarized_pixels.append((255, 255, 255)) # Branco
    return binarized_pixels

def main():
    """Função principal para executar o processamento."""
    if len(sys.argv) != 2:
        print(f"Usage: python {sys.argv[0]} <path_to_image.ppm>")
        sys.exit(1)

    input_file = sys.argv[1]
    if not input_file.lower().endswith('.ppm'):
        print("Error: Input file must be a .ppm file")
        sys.exit(1)

    try:
        # Ler a imagem original
        width, height, max_val, original_pixels = read_ppm_p3(input_file)

        # --- Processamento para Escala de Cinza ---
        print("\nConverting to grayscale...")
        gray_pixels = to_grayscale(original_pixels)
        output_file_gray = input_file.replace('.ppm', '_gray.ppm')
        write_ppm_p3(output_file_gray, width, height, max_val, gray_pixels)

        # --- Processamento para Binarizado ---
        print("\nConverting to binarized...")
        # O limiar é a metade do valor máximo de cor
        threshold = max_val // 2
        print(f"Using binarization threshold: {threshold}")
        binarized_pixels = to_binarized(original_pixels, threshold)
        output_file_binarized = input_file.replace('.ppm', '_binarized.ppm')
        # O valor máximo para a imagem binarizada pode ser 255
        write_ppm_p3(output_file_binarized, width, height, 255, binarized_pixels)

        print("\nProcessing finished!")

    except FileNotFoundError:
        print(f"Error: File '{input_file}' not found.")
    except Exception as e:
        print(f"An unexpected error occurred: {e}")

if __name__ == '__main__':
    main()
