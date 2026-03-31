import os
import requests
from tqdm import tqdm

def download_model():
    # SmolLM-360M-Instruct-v0.2-Q4_K_M.gguf (around 225 MB)
    model_url = "https://huggingface.co/bartowski/SmolLM-360M-Instruct-v0.2-GGUF/resolve/main/SmolLM-360M-Instruct-v0.2-Q4_K_M.gguf"
    model_dir = "models"
    model_name = "smollm-360m.gguf"
    model_path = os.path.join(model_dir, model_name)

    if not os.path.exists(model_dir):
        os.makedirs(model_dir)

    if os.path.exists(model_path):
        print(f"Model already exists at {model_path}")
        return
    
    print(f"Downloading model to {model_path}...")
    response = requests.get(model_url, stream=True)
    total_size = int(response.headers.get('content-length', 0))
    
    with open(model_path, "wb") as f, tqdm(
        total=total_size,
        unit='B',
        unit_scale=True,
        desc=model_name,
    ) as pbar:
        for chunk in response.iter_content(chunk_size=8192):
            if chunk:
                f.write(chunk)
                pbar.update(len(chunk))
                
    print("\nDownload complete!")

if __name__ == "__main__":
    try:
        download_model()
    except ImportError:
        # Fallback if tqdm not installed
        print("Falling back to standard download (tqdm missing)...")
        import urllib.request
        os.makedirs("models", exist_ok=True)
        urllib.request.urlretrieve("https://huggingface.co/bartowski/SmolLM-360M-Instruct-v0.2-GGUF/resolve/main/SmolLM-360M-Instruct-v0.2-Q4_K_M.gguf", "models/smollm-360m.gguf")
        print("Download complete!")
