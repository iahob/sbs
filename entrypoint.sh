#!/bin/bash

#LOCKFILE for generate uuid and keys in first start
LOCKFILE=config/.lockfile
if [ ! -f $LOCKFILE ];then
    sing-box version
    #generate uuid
    echo "Generate UUID..."
    sing-box generate uuid > config/uuid
    #generate short_id 
    sing-box generate rand 8 --hex > config/short_id
    #generate Public & Private keys
    echo "Generate public & private keys..."
    sing-box generate reality-keypair > config/keys
    #Create files with Public & Private keys
    awk '/PublicKey/{print $2}' config/keys > config/public
    awk '/PrivateKey/{print $2}' config/keys > config/private
    UUID=$(cat config/uuid)
    PRIVATE=$(cat config/private)
    SHORTID=$(cat config/short_id)
    CONFIG_FILE="config/config.json"
    #set uuid in config.json
    sed -i "s/<sni>/${SNI}/g; s/<short_id>/${SHORTID}/g; s/<uuid>/${UUID}/g; s/<private_key>/${PRIVATE}/g" "$CONFIG_FILE"
    #create lockfile
    touch $LOCKFILE
    sing-box -C /opt/singbox/config/ run
fi