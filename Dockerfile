FROM ghcr.io/sagernet/sing-box:latest

ENV SNI=icloud.cdn-apple.com
RUN set -e &&\
    apk add --no-cache bash libqrencode-tools curl &&\
    mkdir /opt/singbox &&\
    mkdir /opt/singbox/config

WORKDIR /opt/singbox

COPY config.json config/config.json
COPY get-client-qr.sh .
COPY entrypoint.sh .

EXPOSE 443
ENTRYPOINT [ "/bin/bash","./entrypoint.sh" ]