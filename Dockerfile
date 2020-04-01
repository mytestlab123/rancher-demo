FROM golang:1.12-alpine as app
RUN apk add -U build-base git
COPY app /go/src/app
WORKDIR /go/src/app
ENV GO111MODULE=on
RUN go build -mod=vendor -a -v -tags 'netgo' -ldflags '-w -extldflags -static' -o docker-demo .

FROM alpine:latest
RUN apk add -U --no-cache curl
COPY app/static /static
COPY --from=app /go/src/app/docker-demo /bin/docker-demo
COPY app/templates /templates
ENV TITLE myriodemo
ENV SHOW_VERSION v0.0.3
ENV COW_COLOR blue
EXPOSE 8080
ENTRYPOINT ["/bin/docker-demo"]
