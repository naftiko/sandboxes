ARG BUILD_PLATFORM=linux/amd64

# --- Stage 1: grab the static Caddy binary from the official image ---
# The Microcks uber base image is minimal (no tar), so we copy the prebuilt
# binary instead of downloading + extracting it.
FROM --platform=${BUILD_PLATFORM} caddy:2.8.4 AS caddy

# --- Stage 2: Microcks + Caddy ---
FROM --platform=${BUILD_PLATFORM} quay.io/microcks/microcks-uber:latest

LABEL deploy.timestamp="20260403-v6"

# Microcks HTTP listens INTERNALLY on 8083 (9090 is reserved by Microcks' gRPC
# server, so it cannot be reused for the web server). Caddy is the only public
# listener (8080).
ENV JAVA_OPTIONS="-Dserver.address=0.0.0.0 -Dserver.port=8083"
ENV SERVER_ADDRESS=0.0.0.0

COPY specs/ /specs/
COPY import-specs.sh /import-specs.sh
COPY entrypoint.sh /entrypoint.sh
COPY Caddyfile /etc/caddy/Caddyfile

# Copy the static Caddy binary from the official image (no tar/curl needed).
COPY --from=caddy /usr/bin/caddy /usr/local/bin/caddy

USER root
RUN chmod +x /usr/local/bin/caddy /entrypoint.sh /import-specs.sh
USER 1001

# Public port served by Caddy (Cloud Run still targets 8080).
EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]
