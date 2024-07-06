cp mongo.repo /etc/yum.repos.d/mongo.repo
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE---Exiting\e[0m"
  exit
fi

#Install MongoDB
dnf install mongodb-org -y
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE---Exiting\e[0m"
  exit
fi

#sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf

sed -i '/^bindIp/ s/127.0.0.1/0.0.0.0/' /etc/mongod.conf
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE---Exiting\e[0m"
  exit
fi

#Start & Enable MongoDB Service
systemctl enable mongod
systemctl start mongod
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE---Exiting\e[0m"
  exit
fi

#Restart the service to make the changes effected.
systemctl restart mongod
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE---Exiting\e[0m"
  exit
fi

