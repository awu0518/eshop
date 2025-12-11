#!/bin/bash
# load-test-webmvc.sh
echo "Starting load test for WebMVC..."

# Get the external IP/URL of your ingress
WEBMVC_URL="http://docker.internal.localhost:5100"

# Install hey if not available
if ! command -v hey &> /dev/null; then
    echo "Installing hey load testing tool..."
    wget https://hey-release.s3.us-east-2.amazonaws.com/hey_linux_amd64
    chmod +x hey_linux_amd64
    sudo mv hey_linux_amd64 /usr/local/bin/hey
fi

# Start multiple concurrent load tests
echo "Running load test for 5 minutes with 50 concurrent connections..."
hey -z 5m -c 50 -q 10 $WEBMVC_URL &

echo "Running burst load test..."
hey -z 2m -c 100 -q 20 $WEBMVC_URL/catalog &

wait
echo "Load tests completed!"