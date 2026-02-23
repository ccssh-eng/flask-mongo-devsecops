from flask import Flask, jsonify, Response
from app.db import get_collection
from prometheus_client import Counter, generate_latest, CONTENT_TYPE_LATEST


app = Flask(__name__)


REQUEST_COUNT = Counter(
    "flask_requests_total",
    "Total number of HTTP requests",
    ["method", "endpoint"]
)


@app.before_request
def before_request():
    REQUEST_COUNT.labels(method="GET", endpoint="global").inc()


@app.route("/health", methods=["GET"])
def health():
    return jsonify({"status": "UP"})


@app.route("/items", methods=["GET"])
def get_items():
    col = get_collection()
    items = list(col.find({}, {"_id": 0}))
    return jsonify(items)


@app.route("/metrics")
def metrics():
    return Response(generate_latest(), mimetype=CONTENT_TYPE_LATEST)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
