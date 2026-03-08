from flask import Flask, request, jsonify
import os
from pymongo import MongoClient
import helpers
from prometheus_flask_exporter import PrometheusMetrics
import logging
from logging.handlers import RotatingFileHandler

app = Flask(__name__, static_url_path='/static', static_folder='static')

# MongoDB connection
mongo_uri = os.getenv("MONGO_URI")
client = MongoClient(mongo_uri)
db = client.get_database()

tasks_collection = db.tasks

# Prometheus metrics
metrics = PrometheusMetrics(app)
metrics.info("app_info", "Application info", version="2.0.0")

# Logging setup
file_handler = RotatingFileHandler("task-tracker.log", maxBytes=10240, backupCount=10)
file_handler.setLevel(logging.INFO)

formatter = logging.Formatter(
    "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
)

file_handler.setFormatter(formatter)
app.logger.addHandler(file_handler)
app.logger.setLevel(logging.INFO)


# Log incoming requests
@app.before_request
def log_request_info():
    app.logger.info(
        f"Request: {request.method} {request.url} Headers: {request.headers}"
    )


# Log responses
@app.after_request
def log_response_info(response):
    app.logger.info(f"Response: {response.status}")
    return response


# Home route
@app.route("/")
def index():
    return jsonify({"message": "Task Tracker API running"})


# Get all tasks
@app.route("/tasks", methods=["GET"])
def get_tasks():
    tasks = helpers.get_all_tasks(tasks_collection)
    return jsonify(tasks)


# Create task
@app.route("/tasks", methods=["POST"])
def create_task():
    data = request.json

    if not data or "title" not in data:
        return jsonify({"error": "Task title required"}), 400

    task_id = helpers.create_task(tasks_collection, data["title"])

    return jsonify({"id": task_id}), 201


# Update task
@app.route("/tasks/<task_id>", methods=["PUT"])
def update_task(task_id):

    data = request.json

    if not data or "status" not in data:
        return jsonify({"error": "Task status required"}), 400

    try:
        helpers.update_task(tasks_collection, task_id, data["status"])
        return jsonify({"status": "updated"})
    except helpers.TaskNotFoundError:
        return jsonify({"error": "Task not found"}), 404


# Delete task
@app.route("/tasks/<task_id>", methods=["DELETE"])
def delete_task(task_id):

    try:
        helpers.delete_task(tasks_collection, task_id)
        return jsonify({"status": "deleted"})
    except helpers.TaskNotFoundError:
        return jsonify({"error": "Task not found"}), 404


# Readiness probe (important for Kubernetes)
@app.route("/ready", methods=["GET"])
def ready():
    app.logger.info("Readiness probe accessed")
    return jsonify({"message": "App is ready"})


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=False)