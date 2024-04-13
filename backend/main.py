# This is a test for getting OpenAI to work then it will be transferred to dart for the mobile app

from fastapi import FastAPI
from openai import OpenAI
from dotenv import load_dotenv
from clean_string import clean_string
import uvicorn
import os

app = FastAPI()

load_dotenv()
client = OpenAI(
    api_key=os.getenv("OPENAI_API_KEY"),
)

with open("openai_prompts.txt", "r") as file:
    instructions = file.read()

def root():
    return {"message": "Hello World"}

def clean_string(string: str) -> str:
    return string.replace("\n", "").replace("  ", "")

@app.post("/get-completion/{prompt}")
def get_completion(prompt: str):
    completion = client.chat.completions.create(
      model="gpt-3.5-turbo",
      messages=[
        {"role": "system", "content": instructions},
        {"role": "user", "content": prompt}
      ]
    )    
    message: str = completion.choices[0].message.content
    return {"message": clean_string(message)}


if __name__ == "__main__":
    # load_dotenv()
    uvicorn.run("__main__:app", host="127.0.0.1", port=8000, reload=True)
