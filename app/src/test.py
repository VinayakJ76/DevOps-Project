import unittest
import json
from src import create_app


class TaskTrackerTestCase(unittest.TestCase):

    def setUp(self):
        self.app = create_app()
        self.client = self.app.test_client()

    def test_root_endpoint(self):
        response = self.client.get("/")
        self.assertEqual(response.status_code, 200)

    def test_create_task(self):
        response = self.client.post(
            "/tasks",
            data=json.dumps({"title": "Test Task"}),
            content_type="application/json"
        )

        self.assertEqual(response.status_code, 201)

    def test_get_tasks(self):
        response = self.client.get("/tasks")
        self.assertEqual(response.status_code, 200)

    def test_ready_probe(self):
        response = self.client.get("/ready")
        self.assertEqual(response.status_code, 200)


if __name__ == "__main__":
    unittest.main()