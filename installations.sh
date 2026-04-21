#!/bin/bash

USERID = $(id -u)

if [ $USERID -ne 0 ] 
then 
    echo "Error :: Please run with root user"
    exit 1
else
    echo "You are running with root access"
fi 

VALIDATE() {
    if [ $1 -eq 0 ] 
then 
    echo "Installing $2 is success..."
else 
    echo "Installing $2 is failed..."
    exit 1
fi
}

dnf list installed mysql 

if [ $? -ne 0 ] 
then 
    echo "Installing mysql..."
    dnf install mysql-server -y
    VALIDATE $? "mysql"
else 
    echo "mysql is already installed..."
fi

dnf list installed python3

if [ $? -ne 0 ] 
then 
    echo "Installing python3..."
    dnf install python3 -y
    VALIDATE $? "python3"
else 
    echo "python3 is already installed..."
fi

dnf list installed nginx

if [ $? -ne 0 ] 
then 
    echo "Installing nginx..."
    dnf install nginx -y
    VALIDATE $? "nginx"
else 
    echo "nginx is already installed..."
fi