from flask import Blueprint, request, jsonify, current_app as app
from .helpers import (
    get_all_tasks,
    create_task,
    update_task,
    delete_task,
    TaskNotFoundError
)

main_bp = Blueprint("main", __name__)


# Log incoming requests
@main_bp.before_app_request
def log_request_info():
    app.logger.info(
        f"Request: {request.method} {request.url} Headers: {request.headers}"
    )


# Log responses
@main_bp.after_app_request
def log_response_info(response):
    app.logger.info(f"Response: {response.status}")
    return response


# Root route
@main_bp.route("/")
def index():
    app.logger.info("Task Tracker API root accessed")
    return jsonify({"message": "Task Tracker API running"})


# Get all tasks
@main_bp.route("/tasks", methods=["GET"])
def get_tasks():

    tasks = get_all_tasks(app.tasks_collection)

    return jsonify(tasks), 200


# Create new task
@main_bp.route("/tasks", methods=["POST"])
def add_task():

    data = request.json

    if not data or "title" not in data:
        return jsonify({"error": "Task title required"}), 400

    task_id = create_task(app.tasks_collection, data["title"])

    return jsonify({"id": task_id}), 201


# Update task
@main_bp.route("/tasks/<task_id>", methods=["PUT"])
def modify_task(task_id):

    data = request.json

    if not data or "status" not in data:
        return jsonify({"error": "Task status required"}), 400

    try:
        update_task(app.tasks_collection, task_id, data["status"])
        return jsonify({"status": "updated"}), 200

    except TaskNotFoundError:
        return jsonify({"error": "Task not found"}), 404


# Delete task
@main_bp.route("/tasks/<task_id>", methods=["DELETE"])
def remove_task(task_id):

    try:
        delete_task(app.tasks_collection, task_id)
        return jsonify({"status": "deleted"}), 200

    except TaskNotFoundError:
        return jsonify({"error": "Task not found"}), 404


# Readiness probe (Kubernetes health check)
@main_bp.route("/ready", methods=["GET"])
def ready():
    app.logger.info("Readiness probe accessed")
    return jsonify({"message": "App is ready!"})