import os
from flask import Flask, request
import google.generativeai as genai
from google.cloud import secretmanager

app = Flask(__name__)

def get_secret(secret_id):
    client = secretmanager.SecretManagerServiceClient()
    # Ensure PROJECT_ID is set in your environment
    project_id = os.environ.get('PROJECT_ID')
    name = f"projects/{project_id}/secrets/{secret_id}/versions/latest"
    response = client.access_secret_version(request={"name": name})
    return response.payload.data.decode("UTF-8")

@app.route("/generate", methods=["POST"])
def generate_worker():
    data = request.json
    prompt = data.get("prompt")
    
    genai.configure(api_key=get_secret("josie-engine-key"))
    model = genai.GenerativeModel('gemini-1.5-pro')
    
    response = model.generate_content(f"Output ONLY executable bash code for: {prompt}")
    return {"status": "ready", "action": response.text}

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int(os.environ.get("PORT", 8080)))
