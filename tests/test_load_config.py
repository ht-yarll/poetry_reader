import pytest
from utils.load_config import load_config

config = load_config()

def test_config_structure():
    assert isinstance(config, dict)