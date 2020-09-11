FROM golang:alpine as builder
RUN apk add build-base
COPY . /code
WORKDIR /code

# Run unit tests
RUN cgo_enabled=0 go test

# Build app
RUN go build -o sample-app

FROM alpine

COPY --from=builder /code/sample-app /sample-app
CMD /sample-app
