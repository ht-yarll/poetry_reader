from interfaces.pipeline import Pipeline

from google.cloud import storage
from google.cloud import bigquery

class GCPipelineStrategy(Pipeline):
    def run(self):
        # Implement the GCP pipeline logic here
        pass

    def upload_to_gcs(self, bucket_name, source_file_name, destination_blob_name):
        """Uploads a file to Google Cloud Storage."""
        storage_client = storage.Client()
        bucket = storage_client.bucket(bucket_name)
        blob = bucket.blob(destination_blob_name)

        blob.upload_from_filename(source_file_name)
        print(f"File {source_file_name} uploaded to {destination_blob_name}.")

    def batch_data_from_gcs_to_bq(self, dataset_id, table_id, source_uri):
        """Loads data from Google Cloud Storage to BigQuery."""
        client = bigquery.Client()
        dataset_ref = client.dataset(dataset_id)
        table_ref = dataset_ref.table(table_id)

        job_config = bigquery.LoadJobConfig(
            source_format=bigquery.SourceFormat.CSV,
            skip_leading_rows=1,
            autodetect=True,
        )

        load_job = client.load_table_from_uri(
            source_uri,
            table_ref,
            job_config=job_config
        )

        load_job.result()
        print(f"Loaded {load_job.output_rows} rows into {dataset_id}:{table_id}.")