FROM ghcr.io/sagernet/sing-box:latest
RUN set -e &&\
    apk add --no-cache bash libqrencode curl &&\
    mkdir /opt/singbox &&\
    mkdir /opt/singbox/config

WORKDIR /opt/singbox

COPY config.json config/config.json
COPY get-client-qr.sh .
COPY entrypoint.sh .