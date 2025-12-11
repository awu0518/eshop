#!/bin/bash
echo "Monitoring Kubernetes Autoscaling Behavior"
echo "=========================================="

# Function to show timestamp
timestamp() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')]"
}

# Monitor HPA status
echo "$(timestamp) Starting HPA monitoring..."
echo "Press Ctrl+C to stop monitoring"
echo ""

while true; do
    echo "$(timestamp) HPA Status:"
    kubectl get hpa --all-namespaces -o wide
    echo ""
    
    echo "$(timestamp) Pod Resource Usage:"
    kubectl top pods --all-namespaces --sort-by=cpu
    echo ""
    
    echo "$(timestamp) Node Resource Usage:" 
    kubectl top nodes
    echo ""
    
    echo "$(timestamp) Recent Scaling Events:"
    kubectl get events --field-selector reason=SuccessfulRescale -A --sort-by='.lastTimestamp' | tail -10
    echo ""
    
    echo "=========================================="
    sleep 30
done