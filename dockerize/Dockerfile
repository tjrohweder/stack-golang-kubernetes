#Builder
FROM golang:1.22.7-alpine3.20 AS builder

RUN apk add --no-cache git

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN go build -o dockerize ./webserver.go


#Application
FROM alpine:3.20

ARG USER=appuser
ARG GROUP=appgroup

WORKDIR /app

COPY --from=builder /app/dockerize /app/dockerize
COPY ./src src

RUN addgroup -S $GROUP && adduser -S $USER -G $GROUP &&\
    touch /log.txt && chown -R $USER:$GROUP /app/dockerize /app/src /log.txt &&\
    rm -rf /bin/sh

EXPOSE 8080

USER $USER

ENTRYPOINT ["/app/dockerize"]
