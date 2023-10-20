from flask import Flask, request
app = Flask(__name__)

@app.route('/dexcom_auth')
def dexcom_auth():
    code = request.args.get('code')
    return f"Authorization code: {code}"

if __name__ == '__main__':
    app.run(port=8080)
