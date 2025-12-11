#!/bin/bash
echo "Starting simple load test to trigger HPA scaling..."

# Create a simple load by running curl in loops
echo "Testing if services are accessible first..."
kubectl get svc -n eshop-frontend
kubectl get svc -n eshop-apis

echo ""
echo "Starting load test - Run these commands in separate terminals for screenshots:"
echo ""

echo "=== COMMAND 1: Monitor HPA in real-time (run this first) ==="
echo "kubectl get hpa --all-namespaces -w"
echo ""

echo "=== COMMAND 2: Monitor pod resources (run this second) ==="
echo "while true; do clear; date; kubectl top pods --all-namespaces; sleep 5; done"
echo ""

echo "=== COMMAND 3: Simple load test (run this third) ==="
echo "Run the following commands to generate load:"
echo "kubectl run load-test --image=busybox --rm -i --restart=Never -- sh"
echo ""
echo "Then inside the pod, run:"
echo "while true; do"
echo "  for i in \$(seq 1 100); do"
echo "    wget -q --timeout=2 -O- http://webmvc.eshop-frontend.svc.cluster.local/hc &"
echo "    wget -q --timeout=2 -O- http://catalog-api.eshop-apis.svc.cluster.local/hc &"
echo "    wget -q --timeout=2 -O- http://ordering-api.eshop-apis.svc.cluster.local/hc &"
echo "  done"
echo "  wait"
echo "  sleep 1"
echo "done"
echo ""

echo "=== SCREENSHOTS TO TAKE ==="
echo "1. kubectl get hpa --all-namespaces (before load test)"
echo "2. kubectl top pods --all-namespaces (during load test)" 
echo "3. kubectl get events --field-selector reason=SuccessfulRescale -A"
echo "4. kubectl describe hpa webmvc-hpa -n eshop-frontend"
echo "5. Load test results (output from the load test commands)"