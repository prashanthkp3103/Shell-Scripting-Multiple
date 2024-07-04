#User is a microservice that is responsible for User Logins and Registrations Service in RobotShop e-commerce portal.
#Install NodeJS, By default NodeJS 16 is available, We would like to enable 20 version and install list.
#You can list modules by using dnf module list
dnf module disable nodejs -y
dnf module enable nodejs:20 -y

#Install NodeJS
dnf install nodejs -y
#Add application User
#useradd roboshop

#Lets setup an app directory.
mkdir /app

#Download the application code to created app directory
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user-v3.zip
cd /app
unzip /tmp/user.zip

#Every application is developed by development team will have some common softwares that they use as libraries.
# This application also have the same way of defined dependencies in the application configuration.

#Lets download the dependencies.

cd /app
npm install

#Load the service
systemctl daemon-reload

#Start the service
systemctl enable user
systemctl start user