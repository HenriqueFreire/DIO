from azure.ai.ml import MLClient, command, Input
from azure.identity import DefaultAzureCredential
from azure.ai.ml.entities import Environment, BuildContext

# This script assumes you have logged in via 'az login' and defined the workspace in config.json or via env vars
try:
    credential = DefaultAzureCredential()
    ml_client = MLClient.from_config(credential=credential)
except Exception as ex:
    print("Could not load MLClient from config. Please ensure you have run 'az login'.")
    exit(1)

# Define the environment
env_docker_context = Environment(
    build=BuildContext(path="./docker"),
    name="corn-prediction-env",
    description="Environment for corn price prediction",
)

# Define the job
job = command(
    code="./src",
    command="python train.py --data-path ${{inputs.data}}",
    inputs={
        "data": Input(type="uri_file", path="https://azuremlexamples.blob.core.windows.net/datasets/iris.csv") # Placeholder data
    },
    environment=env_docker_context,
    compute="cpu-cluster",
    display_name="corn-price-prediction-job",
    description="Training job for corn price prediction"
)

# Submit the job
print("Submitting job to Azure ML...")
returned_job = ml_client.create_or_update(job)
print(f"Job submitted. Status: {returned_job.status}")
print(f"Tracking URL: {returned_job.services['Studio'].endpoint}")
