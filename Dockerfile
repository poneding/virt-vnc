FROM alpine

RUN apk add --no-cache kubectl
COPY static /static
COPY docker_entrypoint.sh /docker_entrypoint.sh

CMD ["/bin/sh", "-c", "/docker_entrypoint.sh"]
