FROM golang:1.18.4-alpine3.16 AS build

RUN apk update && \
    apk add git && \
    go install tailscale.com/cmd/gitops-pusher@gitops-1.30.0

FROM alpine:3.16

COPY --from=build /go/bin/gitops-pusher /usr/local/bin/gitops-pusher
COPY ./entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
