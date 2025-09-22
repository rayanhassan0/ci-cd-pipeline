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
    return "App is running"

@app.post("/predict")
def predict():
    payload = request.get_json(silent=True) or {}
    data = payload.get("data", [])
    total = sum(v for v in data if isinstance(v, (int, float)))
    return jsonify({"sum": total})
