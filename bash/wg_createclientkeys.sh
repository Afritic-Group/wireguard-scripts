    #!/bin/bash
     
    export WG_SERVERNAME=$1
    export WG_PEERNAME=$2
     
    echo 
    echo "Servername:     $WG_SERVERNAME"
    echo "Peer/User name: $WG_PEERNAME"
     
    export KEYS_FOLDER="/etc/wireguard/keys"
     
    if [ -f "/etc/wireguard/$WG_SERVERNAME.conf" ]; then
     
            echo
            echo "creating key-pair:"
     
            # just to make sure this folder exists
            mkdir -p "$KEYS_FOLDER"
            export KEY_PATH="$KEYS_FOLDER/$WG_SERVERNAME-$WG_PEERNAME"
            wg genkey | (umask 0077 && tee $KEY_PATH.key) | wg pubkey > $KEY_PATH.pub
            echo "created  public-key at: $KEY_PATH.pub"
            echo "created private-key at: $KEY_PATH.key"
            echo
     
            echo "creating PSK:"
            (umask 0077 && wg genpsk > "$KEY_PATH.psk")
            echo "created PSK at: $KEY_PATH.psk"
     
            echo
    else
            echo "ERROR: Servername $WG_SERVERNAME does not exist!"
            echo "NO KEYS CREATED"
    fi

 
