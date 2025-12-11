#!/bin/bash
# Simple load test using curl for Kubernetes environments
echo "Starting simple API load tests using curl..."

# Test Catalog API health check
CATALOG_URL="catalog-api.eshop-apis.svc.cluster.local"
echo "Testing Catalog API health..."
for i in {1..100}; do
  curl -s http://$CATALOG_URL/hc > /dev/null &
done

# Test Basket API health check
BASKET_URL="basket-api.eshop-apis.svc.cluster.local"
echo "Testing Basket API health..."
for i in {1..100}; do
  curl -s http://$BASKET_URL/hc > /dev/null &
done

# Test WebMVC health check
WEBMVC_URL="webmvc.eshop-frontend.svc.cluster.local"
echo "Testing WebMVC health..."
for i in {1..100}; do
  curl -s http://$WEBMVC_URL/hc > /dev/null &
done

wait
echo "Simple load tests completed!"