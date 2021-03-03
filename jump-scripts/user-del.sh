#!/bin/bash
## GLOBAL
USER=$1  ## Name of the user
SSH_PID=`ps aux | grep 'sshd: '$USER | grep -v 'root' | awk '{print $2}'`  ## PID process SSH

## MAIN
# Check if the user exists. If exists, delete it, if not, show error
if [[ `grep -R $USER /etc/passwd | awk -F : '{print $1}'` == $USER ]];then

    kill -9 $SSH_PID
    echo "Waiting to closing processes for the user" $USER
    sleep 10

    echo "Deleting user..."
    deluser --remove-home $USER

else

    echo "ERROR. The user doesn't exists."
    exit 0

fi
