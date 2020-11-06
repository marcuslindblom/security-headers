# Container image that runs your code
FROM python:3-alpine

RUN apk add --update coreutils jq

RUN pip3 install securityheaders

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
