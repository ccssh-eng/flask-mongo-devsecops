from flask import Flask, jsonify
from app.db import get_collection
from prometheus_client import Counter, generate_latest
from flask import Response

app = Flask(__name__)


REQUEST_COUNT = Counter(
    "flask_requests_total",
    "Total number of requests",
    ["method", "endpoint"]
)


@app.route("/health", methods=["GET"])
def health():
    REQUEST_COUNT.labels(method="GET", endpoint="/health").inc()
    return jsonify({"status": "UP"})


@app.route("/metrics")
def metrics():
    return Response(generate_latest(), mimetype="text/plain")


@app.route("/items", methods=["GET"])
def get_items():
    col = get_collection()
    items = list(col.find({}, {"_id": 0}))
    return jsonify(items)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
