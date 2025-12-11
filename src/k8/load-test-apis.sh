#!/bin/bash
# load-test-apis.sh
echo "Starting API load tests..."

# Install hey if not available
if ! command -v hey &> /dev/null; then
    echo "Installing hey load testing tool..."
    wget https://hey-release.s3.us-east-2.amazonaws.com/hey_linux_amd64
    chmod +x hey_linux_amd64
    sudo mv hey_linux_amd64 /usr/local/bin/hey
fi

# Test Catalog API
CATALOG_URL="http://docker.internal.localhost:5101"
echo "Testing Catalog API..."
hey -z 3m -c 30 -q 15 $CATALOG_URL/api/v1/catalog/items &

# Test Basket API  
BASKET_URL="http://docker.internal.localhost:5103"
echo "Testing Basket API..."
hey -z 3m -c 20 -q 10 $BASKET_URL/api/v1/basket &

# Test Ordering API
ORDERING_URL="http://docker.internal.localhost:5102"
echo "Testing Ordering API..."
hey -z 3m -c 25 -q 12 $ORDERING_URL/api/v1/orders &

wait
echo "API load tests completed!"