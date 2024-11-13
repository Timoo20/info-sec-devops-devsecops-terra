#!/bin/bash

# Checking if the container is healthy
if curl -f http://localhost:8002/; then
    echo "Health check passed!"
else
    echo "Health check failed!"
fi