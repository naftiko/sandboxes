#!/bin/sh
# Run this manually or via the entrypoint after the container is up.
# Talks directly to Microcks on the INTERNAL port 8083 (never through Caddy).
for f in /specs/*.yml /specs/*.yaml /specs/*.json; do
  if [ -f "$f" ]; then
    echo "Importing: $f"
    curl -s -X POST "http://localhost:8083/api/artifact/upload?mainArtifact=true" \
      -F "file=@$f"
    echo ""
  fi
done
echo "All specs imported."
