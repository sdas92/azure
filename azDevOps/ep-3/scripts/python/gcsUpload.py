# Upload a file to GCS bucket
# pip install --upgrade google-cloud-storage

from google.cloud import storage
import os
import sys

print(sys.argv[0])
print(sys.argv[1])

# Set this for google cloud authentication
os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = sys.argv[1] # Key file path will be sent from argument no 2

# Set the bucket context
storage_client = storage.Client()
bucket = storage_client.get_bucket(sys.argv[2]) # Bucket name will be sent from argument no 2

# The uplod path/file_name
blob = bucket.blob('code/dev_code.zip')

# Finally upload the file from local machine
blob.upload_from_filename('./data.zip')
