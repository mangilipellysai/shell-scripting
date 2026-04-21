#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then 
    echo "Error :: please run with root user"
    exit 1
else 
    echo "You are running with root access"
fi 

VALIDATION() {
    if [ $1 -eq 0 ]
    then 
        echo "you are going to install $2 ...."
    else 
        echo "$2 is already installed..."
        exit 1
    fi
}

dnf list installed mysql
if [ $? -ne 0]
then 
    echo "Installing mysql..."
    dnf install mysql -y
    VALIDATION $? "mysql"
else
    echo "mysql is already installed..."
fi 


dnf list installed python3
if [ $? -ne 0 ]
then 
    echo "Installing python3..."
    dnf install python3 -y
    VALIDATION $? "python3"
else 
    echo "python3 is already installed..."
fi



dnf list installed nginx
if [ $? -ne 0 ]
then 
    echo "Installing nginx..."
    dnf install nginx -y
    VALIDATION $? "nginx"
else 
    echo "nginx is already installed..."
fi