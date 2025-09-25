import sys
import os

# make sure root folder is in path
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

import main
from fastapi.testclient import TestClient

client = TestClient(main.app)


def test_read_root():
    resp = client.get("/")
    assert resp.status_code == 200
    assert "message" in resp.json()
