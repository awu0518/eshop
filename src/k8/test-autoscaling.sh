#!/bin/bash
echo "Week 12 Homework - Kubernetes Autoscaling Test"
echo "=============================================="

echo "1. Checking HPA Status..."
kubectl get hpa --all-namespaces

echo ""
echo "2. Checking Current Pod Replicas..."
kubectl get deployments --all-namespaces | grep -E "(eshop-frontend|eshop-apis)" 

echo ""
echo "3. Attempting to get resource metrics..."
kubectl top pods --all-namespaces 2>/dev/null || echo "Metrics server not ready yet"

echo ""
echo "4. Checking metrics server status..."
kubectl get pods -n kube-system | grep metrics

echo ""
echo "5. HPA Detailed Information..."
echo "Catalog API HPA:"
kubectl describe hpa catalog-api-hpa -n eshop-apis

echo ""
echo "WebMVC HPA:"
kubectl describe hpa webmvc-hpa -n eshop-frontend

echo ""
echo "Test completed. Monitor with:"
echo "./monitor-hpa.sh"