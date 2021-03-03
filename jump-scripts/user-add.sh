#!/bin/bash
## GLOBAL
USER=$1  ## Name of the user
SHELL=/bin/bash  ## Type shell

## VARS FOR MAIL
SUBJECT="Instance Jump - SSH Access"  ## Mail subject
MAILTO=$2  ## Mail receiver
TEMPLATE="/path/to/template.html" ## Template mail

## MAIN
# Check if the user exists
if [[ `grep -R $USER /etc/passwd` == $USER ]];then

    echo "ERROR. The user exists. Please, choose another name."
    exit 0

else

    # Add user in the instance
    useradd -m -s $SHELL $USER

    # Check if .ssh folder exists
    if [[ ! -d "/home/$USER/.ssh" ]];then

        su $USER -c "mkdir /home/$USER/.ssh"

    fi

    # Generate key pair SSH and authorized it
    su $USER -c "ssh-keygen -t rsa -b 2048 -m PEM -f /home/$USER/jump-$USER"
    su $USER -c "cat /home/$USER/jump-$USER.pub > /home/$USER/.ssh/authorized_keys"

    # Change permissions for security
    su $USER -c "chmod 600 /home/$USER/jump-$USER.pub /home/$USER/.ssh/authorized_keys"

    # Change name .pem key pair and send mail
    su $USER -c "mv /home/$USER/jump-$USER /home/$USER/jump-$USER.pem"
    cat $TEMPLATE | mutt -e "set content_type=text/html" -a "/home/$USER/jump-$USER.pem" -s "$SUBJECT" -- $MAILTO

fi