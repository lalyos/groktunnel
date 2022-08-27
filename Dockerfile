FROM golang:1.19-alpine AS build
COPY go.mod go.sum /app/
WORKDIR /app
RUN go mod download
COPY main.go /app
RUN go build .

FROM alpine:3.16
COPY --from=build /app/groktunnel /
ENV HOST=vcap.me
ENV BIND=0.0.0.0
ENV PORT=8888
EXPOSE 8888
CMD [ "/groktunnel" ]