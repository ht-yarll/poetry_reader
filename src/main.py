from utils.load_config import load_config
from context.csv_on_cloud import ToGCloud

config = load_config()

pipeline = ToGCloud(config)
pipeline.run()