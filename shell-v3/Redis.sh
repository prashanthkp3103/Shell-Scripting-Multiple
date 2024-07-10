source common.sh
component=redis
LOG_FILE=/tmp/roboshop.log

PRINT Disbaling Redis old version and enabling 7

#Redis is used for in-memory data storage(Caching) and allows users to access the data of database over API.
#Install redis, By default redis *** is available, We would like to enable 7 version and install list.

dnf module disable redis -y &>>$LOG_FILE
dnf module enable redis:7 -y &>>$LOG_FILE
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE---exit 1ing\e[0m"
  exit 1
fi

PRINT installing Redis
#Install Redis
dnf install redis -y &>>$LOG_FILE

if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE---exit 1ing\e[0m"
  exit 1
fi

PRINT Replace config
sed -i '/^bind/ s/127.0.0.1/0.0.0.0/' /etc/${component}/redis.conf &>>$LOG_FILE
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE---exit 1ing\e[0m"
  exit 1
fi
sed -i '/protected-mode/ user.service protected-mode no' /etc/${component}/redis.conf &>>$LOG_FILE
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE---exit 1ing\e[0m"
  exit 1
fi



#Usually Redis opens the port only to localhost(127.0.0.1), meaning this service can be accessed by the application that is hosted on this server only. However, we need to access this service to be accessed by another server, So we need to change the config accordingly.
 #
 #Update listen address from 127.0.0.1 to 0.0.0.0 in /etc/redis/redis.conf
 #
 #Update protected-mode from yes to no in /etc/redis/redis.conf

PRINT Starting Redis
 #Start & Enable Redis Service
 systemctl enable redis &>>$LOG_FILE
 systemctl restart redis &>>$LOG_FILE
 if [ $? -eq 0 ]; then
   echo -e "\e[32mSUCCESS\e[0m"
 else
   echo -e "\e[31mFAILURE---exit 1ing\e[0m"
   exit 1
 fi
