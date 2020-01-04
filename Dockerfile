FROM golang:1.13.5-alpine AS build

WORKDIR /go/src/sample-go-server

# プロジェクト全体をコピーし、構築
# プロジェクトのディレクトリ内にあるファイルが更新すると、このレイヤは再構築
COPY ./app /go/src/sample-go-server
# `CGO_ENABLED=0` is required. see: https://qiita.com/katoken-0215/items/f3a502fe0c2044709012
RUN CGO_ENABLED=0 go build -o /bin/sample-go-server

FROM build AS dev
ENTRYPOINT ["ash"]

# 最終的に2つのイメージ・レイヤになる
FROM scratch
COPY --from=build /bin/sample-go-server /bin/sample-go-server
EXPOSE 8080
ENTRYPOINT ["/bin/sample-go-server"]

# see: https://qiita.com/nitt_san/items/6cba1e422dcdd6098f06
#FROM golang:1.13.5-alpine
#
#WORKDIR /go/src/sample-go-server
#
#COPY ./app /go/src/sample-go-server
#
#EXPOSE 8080
#
#CMD ["go", "run", "main.go"]