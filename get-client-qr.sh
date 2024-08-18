#!/bin/bash
EXT_IP=$(curl -s ifconfig.me)
UUID=$(cat config/uuid)
PUB_KEY=$(cat config/public)
SHORT_ID=$(cat config/short_id)
SNI=$(cat config/sni)

echo "vless://${UUID}@${EXT_IP}:443?security=reality&encryption=none&pbk=${PUB_KEY}&headerType=none&fp=chrome&type=tcp&flow=xtls-rprx-vision&sni=${SNI}&sid=${SHORT_ID}#MyVLESS" > config/client_qr.txt
qrencode -t ansiutf8 < config/client_qr.txt