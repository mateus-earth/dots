## https://www.digitalocean.com/community/tutorials/how-to-install-nginx-on-ubuntu-22-04
## https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-22-04


##
## Constants 
##

##-----------------------------------------------------------------------------
USERNAME="matt";
DOMAIN="mateus.earth";

##
## Script
##

## First usage we are logged as root, so just create the first user.
## After that just relog with the new user and run the script again.
if [ $UID -eq 0 ]; then
    useradd --create-home --shell "/bin/bash" --groups sudo "${USERNAME}"
    passwd  --delete    "${USERNAME}";
    chage   --lastday 0 "${USERNAME}";

    home_directory="$(eval echo ~${USERNAME})";
    mkdir --parents "${home_directory}/.ssh";
    
    cp /root/.ssh/authorized_keys "${home_directory}/.ssh";
    echo "${pub_key}" >> "${home_directory}/.ssh/authorized_keys";

    chmod 0700 "${home_directory}/.ssh";
    chmod 0600 "${home_directory}/.ssh/authorized_keys";
    chown --recursive "${USERNAME}":"${USERNAME}" "${home_directory}/.ssh";
    sed --in-place 's/^PermitRootLogin.*/PermitRootLogin prohibit-password/g' /etc/ssh/sshd_config;
    
    if sshd -t -q; then
        systemctl restart sshd
    fi

    ufw allow OpenSSH;  
    ufw --force enable;

## After first run of the script and reloging as the non root user,
## start to install the bare min that needed to run the server 
elif [ $USER == "$USERNAME" ]; then
   echo "INSTALLING:";

    sudo apt update  -y;
    sudo apt install -y nginx;

    sudo ufw status;
    systemctl status nginx;

    sudo systemctl enable  nginx;
    sudo systemctl restart nginx;

    sudo mkdir -p             /var/www/$DOMAIN/html;
    sudo chown -R $USER:$USER /var/www/$DOMAIN/html;
    sudo chmod -R 755         /var/www/$DOMAIN;

    TMP_PATH="$DOMAIN";
    SITES_AVAILABLE_PATH="/etc/nginx/sites-available/$DOMAIN";

    echo "server {"                                                     > $TMP_PATH;
    echo "        listen 80;"                                          >> $TMP_PATH;
    echo "        listen [::]:80;"                                     >> $TMP_PATH;
    echo ""                                                            >> $TMP_PATH;
    echo "        root /var/www/$DOMAIN/html;"                         >> $TMP_PATH;
    echo "        index index.html index.htm index.nginx-debian.html;" >> $TMP_PATH;
    echo ""                                                            >> $TMP_PATH;
    echo "        server_name $DOMAIN  www.$DOMAIN;"                   >> $TMP_PATH;
    echo ""                                                            >> $TMP_PATH;
    echo "        location / {"                                        >> $TMP_PATH;
    echo "                try_files \$uri \$uri/ =404;"                >> $TMP_PATH;
    echo "        }"                                                   >> $TMP_PATH;
    echo "}"                                                           >> $TMP_PATH;

    sudo mv $TMP_PATH $SITES_AVAILABLE_PATH;
    sudo ln -s /etc/nginx/sites-available/$DOMAIN /etc/nginx/sites-enabled/

    sudo ufw allow OpenSSH;
    sudo ufw allow "Nginx HTTPS";
    sudo ufw allow http;
    sudo ufw allow https;
      
    ip addr show eth0 | grep inet | awk '{ print $2; }' | sed 's/\/.*$//';
fi;