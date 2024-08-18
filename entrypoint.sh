#!/bin/bash

#LOCKFILE for generate uuid and keys in first start
LOCKFILE=config/.lockfile
if [ ! -f $LOCKFILE ];then
    #generate uuid
    echo "Generate UUID..."
    sing-box generate uuid > config/uuid
    #generate Public & Private keys
    echo "Generate public & private keys..."
    sing-box generate reality-keypair > config/keys
    #Create files with Public & Private keys
    awk '/PublicKey/{print $2}' config/keys > config/public
    awk '/PrivateKey/{print $2}' config/keys > config/private
    UUID=$(cat config/uuid)
    PRIVATE=$(cat config/private)
    CONFIG_FILE="config/config.json"
    #set uuid in config.json
    sed -i "s/<uuid>/${UUID}/g; s/<private_key>/${PRIVATE}/g" "$CONFIG_FILE"
    #create lockfile
    touch $LOCKFILE
fi