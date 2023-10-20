import requests

client_id = "clientID"  #swap out
client_secret = "clientSecret" #swap out
code = "AuthorizationCode" #swap out
redirect_uri = "http://127.0.0.1:8080/dexcom_auth"

url = "https://sandbox-api.dexcom.com/v2/oauth2/token"

data = {
    'client_id': client_id,
    'client_secret': client_secret,
    'code': code,
    'grant_type': 'authorization_code',
    'redirect_uri': redirect_uri,
}

response = requests.post(url, data=data)

print(response.json())
