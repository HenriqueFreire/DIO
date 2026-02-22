import openai
import os
from dotenv import load_dotenv

load_dotenv() # Load environment variables from .env file

def generate_podcast_script(prompt: str) -> str:
    """
    Generates a podcast script using the ChatGPT API.

    Args:
        prompt: The prompt to send to the API for script generation.

    Returns:
        The generated podcast script as a string.
    """
    api_key = os.getenv("OPENAI_API_KEY")
    if not api_key:
        raise ValueError("OPENAI_API_KEY environment variable not set.")

    client = openai.OpenAI(api_key=api_key)

    try:
        response = client.chat.completions.create(
            model="gpt-3.5-turbo", # You can choose other models like "gpt-4"
            messages=[
                {"role": "system", "content": "You are a helpful podcast script writer. Generate engaging and informative podcast scripts."},
                {"role": "user", "content": prompt}
            ],
            max_tokens=1000,
            temperature=0.7,
        )
        return response.choices[0].message.content
    except openai.APIError as e:
        print(f"OpenAI API Error: {e}")
        return ""
    except Exception as e:
        print(f"An unexpected error occurred: {e}")
        return ""

if __name__ == "__main__":
    # Example usage
    sample_prompt = "Crie um roteiro de podcast sobre os benefícios da inteligência artificial na educação."
    print("Generating podcast script...")
    script = generate_podcast_script(sample_prompt)
    if script:
        print("\n--- Generated Podcast Script ---")
        print(script)
    else:
        print("Failed to generate script.")
