#!/bin/bash

# Here am checking the Nginx response
response=$(curl --write-out "%{http_code}" --silent --output /dev/null http://localhost:8002/)

# Check for 200 OK response code
if [ "$response" -eq 200 ]; then
    echo "Nginx server is responding correctly on port 8002."
else
    echo "Nginx server is not responding correctly. Response code: $response"
fi
