import json
import os
from flask import Flask, render_template, request, jsonify

app = Flask(__name__, template_folder='.')
DATA_FILE = "meta.json"

def load_data():
    if not os.path.exists(DATA_FILE):
        default_data = {"history": [], "subscriptions": []}
        with open(DATA_FILE, "w", encoding="utf-8") as f:
            json.dump(default_data, f, ensure_ascii=False, indent=4)
        return default_data
    with open(DATA_FILE, "r", encoding="utf-8") as f:
        try: return json.load(f)
        except: return {"history": [], "subscriptions": []}

def save_data(data):
    with open(DATA_FILE, "w", encoding="utf-8") as f:
        json.dump(data, f, ensure_ascii=False, indent=4)

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/api/data', methods=['GET'])
def get_meta_data():
    return jsonify(load_data())

@app.route('/api/history', methods=['POST'])
def add_history():
    req = request.json
    data = load_data()
    data["history"] = [h for h in data["history"] if h["id"] != req["id"]]
    data["history"].append(req)
    if len(data["history"]) > 20: data["history"].pop(0)
    save_data(data)
    return jsonify({"status": "success"})

@app.route('/api/subscribe', methods=['POST'])
def toggle_subscribe():
    req = request.json
    data = load_data()
    exists = [s for s in data["subscriptions"] if s["channelId"] == req["channelId"]]
    if exists:
        data["subscriptions"] = [s for s in data["subscriptions"] if s["channelId"] != req["channelId"]]
    else:
        data["subscriptions"].append(req)
    save_data(data)
    return jsonify({"status": "success"})

if __name__ == '__main__':
    app.run(host='127.0.0.1', port=8000, debug=True)