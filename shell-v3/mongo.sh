source common.sh
component=mongo

PRINT copying mongo repo file
cp mongo.repo /etc/yum.repos.d/${component}.repo &>>$LOG_FILE


if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE---Check log /tmp/roboshop.log\e[0m"
  exit 1
fi

PRINT Installing Mongodb
#Install MongoDB
dnf install mongodb-org -y &>>$LOG_FILE
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE---Check log /tmp/roboshop.log\e[0m"
  exit 1
fi

#sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf

PRINT Updating mong config
sed -i '/^bindIp/ s/127.0.0.1/0.0.0.0/' /etc/mongod.conf
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE---Check log /tmp/roboshop.log\e[0m"
  exit 1
fi

PRINT Starting MOngdb service
#Start & Enable MongoDB Service
systemctl enable mongod
systemctl start mongod
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE---Check log /tmp/roboshop.log\e[0m"
  exit 1
fi

#Restart the service to make the changes effected.
systemctl restart mongod &>>$LOG_FILE
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE---Check log /tmp/roboshop.log\e[0m"
  exit 1
fi

