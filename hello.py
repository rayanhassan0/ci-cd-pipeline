from flask import Flask, request, jsonify

# ===== دوال مطلوبة للاختبارات (وسيط واحد لكل دالة) =====
def toyou(x):
    return f"hi {x}"

def add(x):
    return x + 1

def subtract(x):
    return x - 1

# ===== تطبيق Flask لمسار / و /predict =====
app = Flask(__name__)

@app.get("/")
def index():
    return "App is running"

@app.post("/predict")
def predict():
    payload = request.get_json(silent=True) or {}
    data = payload.get("data", [])
    total = sum(v for v in data if isinstance(v, (int, float)))
    return jsonify({"sum": total})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
