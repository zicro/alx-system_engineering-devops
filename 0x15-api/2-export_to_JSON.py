#!/usr/bin/python3
"""Exports to-do list information for
a given employee ID to JSON format.
"""
import json
import requests
import sys


def export_to_json(user_id):
    base_url = "https://jsonplaceholder.typicode.com/"
    user = requests.get(f"{base_url}users/{user_id}").json()
    todos = requests.get(f"{base_url}todos", params={"userId": user_id}).json()

    task_data = [
        {
            "task": todo["title"],
            "completed": todo["completed"],
            "username": user["username"],
        }
        for todo in todos
    ]

    with open(f"{user_id}.json", "w") as jsonfile:
        json.dump({user_id: task_data}, jsonfile)


if __name__ == "__main__":
    user_id = sys.argv[1]
    export_to_json(user_id)
