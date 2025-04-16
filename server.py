from flask import Flask, jsonify
import json

app = Flask(__name__)

@app.route('/')
def serve_data():
    try:
        with open('scraped_data.json') as f:
            data = json.load(f)
        return jsonify(data)
    except FileNotFoundError:
        return jsonify({"error": "scraped_data.json not found"}), 404

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

