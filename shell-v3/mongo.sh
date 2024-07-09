LOG_FILE=/tmp/roboshop.log
rm -rf $LOG_FILE

cp mongo.repo /etc/yum.repos.d/mongo.repo &>>$LOG_FILE

if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE---Check log /tmp/roboshop.log\e[0m"
  exit 1
fi

#Install MongoDB
dnf install mongodb-org -y &>>$LOG_FILE
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE---Check log /tmp/roboshop.log\e[0m"
  exit 1
fi

#sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf

sed -i '/^bindIp/ s/127.0.0.1/0.0.0.0/' /etc/mongod.conf
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE---Check log /tmp/roboshop.log\e[0m"
  exit 1
fi

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

