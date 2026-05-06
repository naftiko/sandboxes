ARG BUILD_PLATFORM=linux/amd64
FROM --platform=${BUILD_PLATFORM} quay.io/microcks/microcks-uber:latest

LABEL deploy.timestamp="20260403-v6"

ENV JAVA_OPTIONS="-Dserver.address=0.0.0.0 -Dserver.port=8080"
ENV SERVER_ADDRESS=0.0.0.0

COPY specs/ /specs/
COPY import-specs.sh /import-specs.sh
COPY entrypoint.sh /entrypoint.sh

USER root
RUN chmod +x /entrypoint.sh /import-specs.sh
USER 1001

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]
