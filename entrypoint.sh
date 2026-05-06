#!/bin/sh
echo "=== MICROCKS CONTAINER STARTING ==="
echo "Hostname: $(hostname)"
echo "IP addresses:"
ip addr 2>/dev/null || ifconfig 2>/dev/null || echo "no ip tools"
echo "JAVA_OPTIONS: $JAVA_OPTIONS"
echo "SERVER_ADDRESS: $SERVER_ADDRESS"
echo "=== Launching Microcks ==="

# Start JVM in background so we can auto-import specs once it's ready
/deployments/run-java.sh &
JVM_PID=$!

# Wait for Microcks to be ready (up to 120 seconds)
echo "=== Waiting for Microcks to start ==="
elapsed=0
while [ $elapsed -lt 120 ]; do
  if curl -s -o /dev/null -w '' http://localhost:8080/api/health 2>/dev/null; then
    echo "=== Microcks is ready (${elapsed}s) ==="
    break
  fi
  sleep 3
  elapsed=$((elapsed + 3))
done

# Import baked-in specs
if [ -f /import-specs.sh ]; then
  echo "=== Auto-importing specs from /specs/ ==="
  sh /import-specs.sh
  echo "=== Spec import complete ==="
fi

# Wait on JVM process so the container stays alive
wait $JVM_PID
