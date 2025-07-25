import yaml

def load_config():
    with open('src/config.yaml', 'r') as file:
        config = yaml.safe_load(file)
    return config
