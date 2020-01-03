# see: https://qiita.com/nitt_san/items/6cba1e422dcdd6098f06
FROM golang:1.13.5-alpine

WORKDIR /go/src/sample-go-server

COPY ./app /go/src/sample-go-server

EXPOSE 8080

CMD ["go", "run", "main.go"]