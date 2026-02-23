from flask import Flask, jsonify
from app.db import get_collection
from prometheus_client import Counter, generate_latest
from prometheus_client import CONTENT_TYPE_LATEST
from prometheus_client import start_http_server
from flask import Response

app = Flask(__name__)

REQUEST_COUNT = Counter(
    "flask_requests_total",
    "Total number of HTTP requests",
    ["method", "endpoint"]
)

@app.before_request
def before_request():
    REQUEST_COUNT.labels(method="GET", endpoint="/").inc()

@app.route("/metrics")
def metrics():
    return Response(generate_latest(), mimetype=CONTENT_TYPE_LATEST)
