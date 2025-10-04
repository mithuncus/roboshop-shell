#!/bin/bash
# t3.medium or t3.small will work
ID=$(id -u) # for getting the ID ,root user means it will be zero other number like 2.4. then its not root user

R="\033[31m" # in shell script for Red color we use /e[31m
G="\033[32m" # in shell script for Green color we use /e[32m
Y="\033[33m" # in shell script for Yellow color we use /e[33m
N="\033[0m"  # in shell script for Normal color we use /e[0m

TIMESTAMP=$(date +%F-%H-%M-%S)
LOGFILE="/tmp/$0-$TIMESTAMP.log" #for executing in server we use this line $0 -->means previous run scriptname
#LOGFILE="/Users/kethanav/Desktop/DevOps_2025/shellscript/$0-$TIMESTAMP.log" #for executing in macbook

echo "script started executing at $TIMESTAMP" &>> $LOGFILE
# VALIDATE is a function, usually in function we write condition and insted of repeating code 
# we call function where it is required DRY principel DONT REPEAT Yourself
# VALIDATE function checkes prvious command ran success or failed.
# usually $1 is first argument we passed, $2 is second argument passed
#Like VALIDATE $? $package means we are using loops concept so
# @package is also a valirable in loops it will consider 1 argument we pass in loops

VALIDATE (){
  if [ $1 -ne 0 ]
  then
    echo -e "$2 ...$R failed $N "
    else
    echo -e "$2 ..$G success $N "
    fi

}

if [ $ID -ne 0 ]
then
echo -e "$R ERROR:: Please run this script with root user $N"
else
echo -e "${G} you are root user ${N}"
fi #fi is closing of if condition


dnf module disable nodejs -y &>> $LOGFILE
VALIDATE $? "disabling nodejs"

dnf module enable nodejs:20 -y &>> $LOGFILE
VALIDATE $? "enabling   nodejs"

dnf install nodejs -y &>> $LOGFILE
VALIDATE $? "installing    nodejs"

useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop &>> $LOGFILE
VALIDATE $? "adding user"