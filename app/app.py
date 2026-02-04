from flask import Flask, jsonify
from app.db import get_collection


app = Flask(__name__)


@app.route("/health", methods=["GET"])
def health():
    return jsonify({"status": "UP"})


@app.route("/items", methods=["GET"])
def get_items():
    col = get_collection()
    items = list(col.find({}, {"_id": 0}))
    return jsonify(items)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
