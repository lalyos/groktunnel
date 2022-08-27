FROM golang:1.19-alpine AS build
COPY go.mod go.sum /app/
WORKDIR /app
RUN go mod download
COPY main.go /app
RUN go build .

FROM alpine:3.16
COPY --from=build /app/groktunnel /
EXPOSE 9999
CMD [ "/groktunnel" ]