#!/bin/bash

# Constants
AZURITE_VERSION="3.23.0"  # You can specify a different version if needed
PORT=12000
BLOB_DIR="./azurite_blob"

# Function to check if Docker is installed
check_docker_installed() {
    if ! command -v docker &> /dev/null; then
        echo "Docker could not be found. Please install Docker to proceed."
        exit 1
    fi
}

# Function to run the Azurite container on port 12000
start_azurite() {
    echo "Starting Azurite Blob Storage Emulator on port $PORT..."

    # Create a directory for blob storage data if it doesn't exist
    mkdir -p $BLOB_DIR

    # Pull and run Azurite using Docker
    docker run -d -p $PORT:10000 -v $BLOB_DIR:/data mcr.microsoft.com/azure-storage/azurite:$AZURITE_VERSION azurite-blob --blobHost 0.0.0.0 --blobPort 10000
    
    # Wait a few seconds to allow Azurite to start
    sleep 5

    echo "Azurite is running on port $PORT."
}

# Function to check if Azurite is running
check_azurite_running() {
    if curl -s http://localhost:$PORT | grep "Blob Storage"; then
        echo "Azurite is running correctly on port $PORT."
    else
        echo "Failed to start Azurite."
        exit 1
    fi
}

# Function to simulate feeding the demon with blobs
feed_the_demon() {
    echo "Feeding the demon with innocent souls (Azure blobs)..."
    # Command to upload or interact with blobs can be added here
    # Example: using Azure CLI to upload files
    # az storage blob upload --account-name devstoreaccount1 --account-key Eby8vdM02xNOcqFE...
}

# Main script execution

# Step 1: Check if Docker is installed
check_docker_installed

# Step 2: Start Azurite
start_azurite

# Step 3: Check if Azurite is running
check_azurite_running

# Step 4: Simulate feeding the demon with Azure blobs
feed_the_demon
