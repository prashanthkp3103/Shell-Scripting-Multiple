#Cart is a microservice that is responsible for Cart Service in RobotShop e-commerce portal.
#Install NodeJS, By default NodeJS 16 is available, We would like to enable 20 version and install list

#Setup SystemD Cart Service
cp cart.service /etc/systemd/system/cart.service

#You can list modules by using dnf module list
dnf module disable nodejs -y
dnf module enable nodejs:20 -y

#Install NodeJS
dnf install nodejs -y

#Add application User
useradd roboshop

#INFO
 #User roboshop is a function / daemon user to run the application. Apart from that we dont use this user to login to server.
 #
 #Also, username roboshop has been picked because it more suits to our project name

 #Lets setup an app directory
mkdir /app

#Download the application code to created app directory
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart-v3.zip
cd /app
unzip /tmp/cart.zip

#Lets download the dependencies
cd /app
npm install

#Load the service
systemctl daemon-reload

#Start the service
systemctl enable cart
systemctl start cart




