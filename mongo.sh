cp mongo.repo /etc/yum.repos.d/mongo.repo

#Install MongoDB
dnf install mongodb-org -y

#Start & Enable MongoDB Service
systemctl enable mongod
systemctl start mongod

#Restart the service to make the changes effected.
systemctl restart mongod
