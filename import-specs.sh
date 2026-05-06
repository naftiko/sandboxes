#!/bin/sh
# Run this manually or via the Worker after the container is up
# Usage: sh /deployments/import-specs.sh
for f in /specs/*.yml /specs/*.yaml /specs/*.json; do
  if [ -f "$f" ]; then
    echo "Importing: $f"
    curl -s -X POST "http://localhost:8080/api/artifact/upload?mainArtifact=true" \
      -F "file=@$f"
    echo ""
  fi
done
echo "All specs imported."
