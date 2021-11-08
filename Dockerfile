ARG GOVERSION=1.17
FROM golang:${GOVERSION} as builder
ARG GOARCH
ENV GOARCH=${GOARCH}
WORKDIR /go/src/k8s.io/kube-state-metrics/
COPY . /go/src/k8s.io/kube-state-metrics/

RUN make build-local

FROM golang:${GOVERSION}
COPY --from=builder /go/src/k8s.io/kube-state-metrics/kube-state-metrics /

ENTRYPOINT ["/kube-state-metrics", "--port=8080", "--telemetry-port=8081"]

EXPOSE 8080 8081
