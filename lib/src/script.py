import requests
import time

url = "https://cas-natal-api.onrender.com/CASNatal/glossaries"
i=0

while True:
    try:
        response = requests.get(url)
        print(f"\nREQUISIÇÃO N° {i+1}")
        print(f"Status Code: {response.status_code}")
        print(f"Response: {response.text}")
        i+=1
    except Exception as e:
        print(f"Erro ao acessar o endpoint: {e}")
    
    time.sleep(5)

# pip install requests
# python script.py