import os
from pymongo import MongoClient


def get_collection():
    uri = os.getenv("MONGO_URI", "mongodb://localhost:27017")
    client = MongoClient(uri)
    db = client["testdb"]
    return db["items"]
