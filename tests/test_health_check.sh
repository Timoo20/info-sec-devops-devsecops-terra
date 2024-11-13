#!/bin/bash

# Testing the health check endpoint on port 8002
response=$(curl --write-out "%{http_code}" --silent --output /dev/null http://localhost:8002/)

# Checking if the response code is OK
if [ "$response" -eq 200 ]; then
    echo "Health check passed!"
else
    echo "Health check failed with response code: $response"
fi
