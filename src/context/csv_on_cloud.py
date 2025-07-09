from strategies.gcp import GCPipelineStrategy

class ToGCloud(GCPipelineStrategy):
    def __init__(self, config):
        self.config = config

    def run(self):
        # Implement the logic to run the pipeline
        pass