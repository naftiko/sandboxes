#!/bin/sh
echo "=== MICROCKS CONTAINER STARTING ==="
echo "Hostname: $(hostname)"
echo "IP addresses:"
ip addr 2>/dev/null || ifconfig 2>/dev/null || echo "no ip tools"
echo "JAVA_OPTIONS: $JAVA_OPTIONS"
echo "SERVER_ADDRESS: $SERVER_ADDRESS"
echo "=== Launching Microcks (internal :8083) ==="

# Start JVM in background so we can auto-import specs once it's ready.
# Microcks HTTP listens on :8083 (9090 is its gRPC port); Caddy is the public
# listener on :8080.
/deployments/run-java.sh &
JVM_PID=$!

# Wait for Microcks to be ready (up to 120 seconds)
echo "=== Waiting for Microcks to start ==="
elapsed=0
while [ $elapsed -lt 120 ]; do
  if curl -s -o /dev/null -w '' http://localhost:8083/api/health 2>/dev/null; then
    echo "=== Microcks is ready (${elapsed}s) ==="
    break
  fi
  sleep 3
  elapsed=$((elapsed + 3))
done

# Import baked-in specs (talks directly to Microcks on :8083, never via Caddy)
if [ -f /import-specs.sh ]; then
  echo "=== Auto-importing specs from /specs/ ==="
  sh /import-specs.sh
  echo "=== Spec import complete ==="
fi

# Start Caddy in the FOREGROUND on :8080. It becomes the main process that keeps
# the container alive and proxies/authenticates public traffic to Microcks :8083.
echo "=== Starting Caddy reverse-proxy on :8080 ==="
if [ -z "$ADMIN_PASSWORD_HASH" ]; then
  echo "WARNING: ADMIN_PASSWORD_HASH is not set — admin endpoints will reject all logins."
fi
exec caddy run --config /etc/caddy/Caddyfile --adapter caddyfile
