import openai
import os
import requests
from dotenv import load_dotenv

load_dotenv() # Load environment variables from .env file

def generate_podcast_cover(description: str, output_path: str = "podcast_cover.png") -> str:
    """
    Generates a podcast cover image using the DALL-E API.

    Args:
        description: A text description of the desired podcast cover.
        output_path: The path where the generated image will be saved.

    Returns:
        The path to the saved image file, or an empty string if generation fails.
    """
    api_key = os.getenv("OPENAI_API_KEY")
    if not api_key:
        raise ValueError("OPENAI_API_KEY environment variable not set.")

    client = openai.OpenAI(api_key=api_key)

    try:
        print(f"Generating image for description: '{description}' using DALL-E...")
        response = client.images.generate(
            model="dall-e-2",  # Or "dall-e-3" if you have access and prefer it
            prompt=description,
            size="512x512",  # DALL-E 2 supports 256x256, 512x512, or 1024x1024
            quality="standard", # Only for DALL-E 3
            n=1,  # Number of images to generate
        )

        image_url = response.data[0].url
        print(f"Image generated. Downloading from: {image_url}")

        # Download the image
        image_data = requests.get(image_url).content
        with open(output_path, "wb") as f:
            f.write(image_data)
        print(f"Image saved to: {output_path}")
        return output_path

    except openai.APIError as e:
        print(f"OpenAI API Error: {e}")
        return ""
    except Exception as e:
        print(f"An unexpected error occurred: {e}")
        return ""

if __name__ == "__main__":
    # Example usage
    sample_description = "A modern and minimalist podcast cover for an AI and education podcast. Featuring a stylized brain icon intertwined with circuit board patterns, on a gradient background of blue and green, with subtle futuristic elements."
    print("Generating podcast cover...")
    generated_image_path = generate_podcast_cover(sample_description, "ai_education_podcast_cover.png")
    if generated_image_path:
        print(f"Podcast cover generated and saved to: {generated_image_path}")
    else:
        print("Failed to generate podcast cover.")
