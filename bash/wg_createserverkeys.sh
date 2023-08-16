#!/bin/bash
 
export KEYS_FOLDER="/etc/wireguard/keys"
# just to make sure this folder exists
mkdir "$KEYS_FOLDER"
export KEY_PATH="$KEYS_FOLDER/$1"
wg genkey | (umask 0077 && tee $KEY_PATH.key) | wg pubkey > $KEY_PATH.pub
