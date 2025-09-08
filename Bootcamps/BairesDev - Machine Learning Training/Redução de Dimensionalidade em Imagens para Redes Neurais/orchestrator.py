import sys
import os
import subprocess

# Tenta importar a biblioteca Pillow e fornece uma mensagem de erro amigável se não estiver instalada.
try:
    from PIL import Image
except ImportError:
    print("Error: The Pillow library is not installed.")
    print("Please install it by running: pip install Pillow")
    sys.exit(1)

# Reutilizamos a função de leitura de PPM para ler os resultados do outro script.
def read_ppm_p3(filename):
    with open(filename, 'r') as f:
        lines = f.readlines()
    lines_without_comments = [line.strip() for line in lines if not line.strip().startswith('#') and line.strip()]
    if lines_without_comments[0] != 'P3':
        raise ValueError("File format is not PPM P3.")
    width, height = map(int, lines_without_comments[1].split())
    pixel_data_str = ' '.join(lines_without_comments[3:]).split()
    pixel_data_int = [int(val) for val in pixel_data_str]
    pixels = []
    for i in range(0, len(pixel_data_int), 3):
        pixels.append((pixel_data_int[i], pixel_data_int[i+1], pixel_data_int[i+2]))
    return width, height, pixels

def convert_to_ppm(input_file, output_file):
    """Converte uma imagem padrão (PNG, JPG) para o formato PPM P3."""
    print(f"Converting '{input_file}' to PPM format...")
    try:
        with Image.open(input_file) as img:
            # Garante que a imagem está no modo RGB
            img_rgb = img.convert('RGB')
            width, height = img_rgb.size
            pixels = list(img_rgb.getdata())
            max_val = 255 # Valor padrão para cores RGB

            with open(output_file, 'w') as f:
                f.write('P3\n')
                f.write(f'{width} {height}\n')
                f.write(f'{max_val}\n')
                for r, g, b in pixels:
                    f.write(f'{r} {g} {b} ')
        print("Conversion to PPM complete.")
    except Exception as e:
        print(f"Error converting to PPM: {e}")
        sys.exit(1)

def convert_from_ppm(input_file, output_file):
    """Converte um arquivo PPM P3 de volta para um formato de imagem padrão."""
    print(f"Re-converting '{input_file}' to '{output_file}'...")
    try:
        width, height, pixels = read_ppm_p3(input_file)
        img = Image.new('RGB', (width, height))
        img.putdata(pixels)
        img.save(output_file)
        print(f"File '{output_file}' saved successfully.")
    except Exception as e:
        print(f"Error re-converting from PPM: {e}")
        sys.exit(1)

def main():
    if len(sys.argv) != 2:
        print(f"Usage: python {sys.argv[0]} <path_to_image>")
        print(f"Example: python {sys.argv[0]} my_photo.png")
        sys.exit(1)

    original_file = sys.argv[1]
    if not os.path.exists(original_file):
        print(f"Error: Input file '{original_file}' not found.")
        sys.exit(1)

    # Extrai apenas o nome do arquivo da entrada original
    input_filename = os.path.basename(original_file)
    base_name, ext = os.path.splitext(input_filename)

    # Define o diretório de saída e garante que ele exista
    output_dir = "images"
    os.makedirs(output_dir, exist_ok=True)

    # Define os nomes dos arquivos temporários (podem ficar na raiz para simplicidade)
    temp_ppm_file = f"{base_name}.ppm"
    gray_ppm_file = f"{base_name}_gray.ppm"
    binarized_ppm_file = f"{base_name}_binarized.ppm"

    # Define os nomes dos arquivos de saída finais dentro do diretório de imagens
    final_gray_file = os.path.join(output_dir, f"{base_name}_gray{ext}")
    final_binarized_file = os.path.join(output_dir, f"{base_name}_binarized{ext}")

    temporary_files = [temp_ppm_file, gray_ppm_file, binarized_ppm_file]

    try:
        # ETAPA 1: Converter a imagem original para PPM
        convert_to_ppm(original_file, temp_ppm_file)

        # ETAPA 2: Executar o script de processamento de imagem
        image_processor_script = 'image_processor.py'
        print(f"\nExecuting the image processing script ({image_processor_script})...")
        # Garante que o script processador exista
        if not os.path.exists(image_processor_script):
            print(f"Error: The script '{image_processor_script}' was not found in the same directory.")
            raise FileNotFoundError
            
        subprocess.run([sys.executable, image_processor_script, temp_ppm_file], check=True, capture_output=True, text=True)
        print("Processing finished.")

        # ETAPA 3: Re-converter os resultados para o formato original
        print("\nRe-converting processed images...")
        convert_from_ppm(gray_ppm_file, final_gray_file)
        convert_from_ppm(binarized_ppm_file, final_binarized_file)

        print(f"\nProcess finished! Check the files '{final_gray_file}' and '{final_binarized_file}'.")

    except subprocess.CalledProcessError as e:
        print(f"\nAn error occurred while running '{image_processor_script}':")
        print(e.stdout)
        print(e.stderr)
    except FileNotFoundError:
        # A mensagem de erro já foi impressa, apenas sai
        sys.exit(1)
    finally:
        # ETAPA 4: Limpar arquivos temporários
        print("\nCleaning up temporary files...")
        for f in temporary_files:
            if os.path.exists(f):
                os.remove(f)
                print(f"Temporary file '{f}' removed.")

if __name__ == "__main__":
    main()
