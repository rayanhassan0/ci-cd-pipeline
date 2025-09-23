from flask import Flask, request, jsonify

app = Flask(__name__)

def toyou(x):
    return f"hi {x}"

def add(x):
    return x + 1

def subtract(x):
    return x - 1

@app.get("/")
def index():
    # صفحة توضح أن النشر تم عبر CD
    return """
    <html>
      <body style="font-family: sans-serif;">
        <h3>Sklearn Prediction Home - Continuous Delivery</h3>
        <p>App is running via Azure Pipelines → Azure App Service.</p>
      </body>
    </html>
    """

@app.post("/predict")
def predict():
    payload = request.get_json(silent=True) or {}
    data = payload.get("data", [])
    total = sum(v for v in data if isinstance(v, (int, float)))
    return jsonify({"sum": total})
