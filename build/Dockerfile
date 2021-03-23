FROM golang:1.16

ARG VERSION
ENV VERSION=$VERSION

WORKDIR /shredderserver

ADD go.mod .
RUN go mod download
ADD cmd/ cmd/
ADD internal/ internal/

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /shredderserver/bin/shredderserver ./cmd/server/server.go

CMD ["/shredderserver/bin/shredderserver"]