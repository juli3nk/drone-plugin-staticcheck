FROM docker.io/golang:alpine

RUN apk --update --no-cache add \
		ca-certificates \
		gcc \
		git \
		musl-dev

RUN go install honnef.co/go/tools/cmd/staticcheck@latest

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT [ "/usr/local/bin/docker-entrypoint.sh" ]
