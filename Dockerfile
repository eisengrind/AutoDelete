FROM golang:alpine AS build

ARG MODULE_PATH=github.com/eisengrind/AutoDelete

COPY . /go/src/${MODULE_PATH}/

WORKDIR /go/src/${MODULE_PATH}/

RUN go get -u -v

WORKDIR /go/src/${MODULE_PATH}/cmd/autodelete/

RUN go build -ldflags="-s -w" -v -o autodelete



FROM alpine:latest

ARG MODULE_PATH=github.com/eisengrind/AutoDelete

COPY --from=build /go/src/${MODULE_PATH}/cmd/autodelete/autodelete /opt/autodelete/autodelete

RUN mkdir -p /opt/autodelete/data/

EXPOSE 2202

WORKDIR /opt/autodelete/

ENTRYPOINT /opt/autodelete/autodelete
