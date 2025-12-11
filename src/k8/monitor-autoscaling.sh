#!/bin/bash
# monitor-autoscaling.sh
echo "Starting autoscaling monitoring..."

# Monitor HPA Status
echo "=== Monitoring HPA Status ==="
kubectl get hpa --all-namespaces

echo ""
echo "=== Current Pod Resource Usage ==="
kubectl top pods --all-namespaces

echo ""
echo "=== Node Resource Usage ==="
kubectl top nodes

echo ""
echo "=== Recent Scaling Events ==="
kubectl get events --field-selector reason=SuccessfulRescale -A --sort-by='.lastTimestamp' | tail -10

echo ""
echo "=== Detailed HPA Information ==="
kubectl describe hpa webmvc-hpa -n eshop-frontend
kubectl describe hpa catalog-api-hpa -n eshop-apis

echo ""
echo "=== VPA Recommendations ==="
kubectl get vpa --all-namespaces
kubectl describe vpa catalog-api-vpa -n eshop-apis || echo "VPA not available"

echo ""
echo "Monitoring complete. Use 'kubectl get hpa --all-namespaces -w' to watch real-time scaling."