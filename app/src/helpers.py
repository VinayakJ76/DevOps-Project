from bson.objectid import ObjectId


class TaskNotFoundError(Exception):
    """Raised when a requested task cannot be found."""
    pass


def get_all_tasks(collection):
    """
    Fetch all tasks from MongoDB.
    """

    tasks = []

    for task in collection.find():
        tasks.append({
            "id": str(task["_id"]),
            "title": task.get("title"),
            "status": task.get("status", "pending")
        })

    return tasks


def create_task(collection, title):
    """
    Create a new task in MongoDB.
    """

    task = {
        "title": title,
        "status": "pending"
    }

    result = collection.insert_one(task)

    return str(result.inserted_id)


def update_task(collection, task_id, status):
    """
    Update the status of a task.
    """

    result = collection.update_one(
        {"_id": ObjectId(task_id)},
        {"$set": {"status": status}}
    )

    if result.matched_count == 0:
        raise TaskNotFoundError("Task not found")

    return True


def delete_task(collection, task_id):
    """
    Delete a task from MongoDB.
    """

    result = collection.delete_one({"_id": ObjectId(task_id)})

    if result.deleted_count == 0:
        raise TaskNotFoundError("Task not found")

    return True