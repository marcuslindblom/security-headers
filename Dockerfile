FROM alpine:3.12

RUN apk add --update coreutils jq bash curl

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]