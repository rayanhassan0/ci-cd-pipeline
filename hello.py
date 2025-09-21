from flask import Flask, request, jsonify

# ===== دوال مطلوبة للاختبارات =====
def toyou(name):
    return f"hi {name}"

def add(a, b=None):
    # يدعم add(a, b) أو add(a) -> a + 1
    if b is None:
        return a + 1
    return a + b

def subtract(a, b=None):
    # يدعم subtract(a, b) أو subtract(a) -> a - 1
    if b is None:
        return a - 1
    return a - b

# ===== تطبيق Flask بسيط لمسار / و /predict =====
app = Flask(__name__)

@app.get("/")
def index():
    return "App is running"

@app.post("/predict")
def predict():
    payload = request.get_json(silent=True) or {}
    data = payload.get("data", [])
    total = sum(x for x in data if isinstance(x, (int, float)))
    return jsonify({"sum": total})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
