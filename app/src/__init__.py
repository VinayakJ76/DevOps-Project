from flask import Flask
from pymongo import MongoClient
from prometheus_flask_exporter import PrometheusMetrics
import logging
from logging.handlers import RotatingFileHandler
from .config import Config


def create_app():
    app = Flask(__name__, static_url_path='/static', static_folder='static')
    app.config.from_object(Config)

    # MongoDB connection
    client = MongoClient(app.config["MONGO_URI"])
    app.db = client.get_database()

    # Task collection
    app.tasks_collection = app.db.tasks

    # Prometheus metrics exporter
    metrics = PrometheusMetrics(app)
    metrics.info("app_info", "Application info", version="2.0.0")

    # Logging
    file_handler = RotatingFileHandler(
        "task-tracker.log", maxBytes=10240, backupCount=10
    )
    file_handler.setLevel(logging.INFO)

    formatter = logging.Formatter(
        "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
    )
    file_handler.setFormatter(formatter)

    app.logger.addHandler(file_handler)
    app.logger.setLevel(logging.INFO)

    # Register routes
    from .routes import main_bp
    app.register_blueprint(main_bp)

    return app