source common.sh
component=redis
LOG_FILE=/tmp/roboshop.log

PRINT Installing MySQLserver
#Install MySQL Server
dnf install mysql-server -y &>>$LOG_FILE
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE---exit 1ing\e[0m"
  exit 1
fi

PRINT Starting MySQLserver
#Start MySQL Service
systemctl enable mysqld &>>$LOG_FILE
systemctl start mysqld &>>$LOG_FILE
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE---exit 1ing\e[0m"
  exit 1
fi

#Next, We need to change the default root password in order to start using the database service.
#Use password RoboShop@1 or any other as per your choice.

PRINT Setting MySQLserver new password
mysql_secure_installation --set-root-pass RoboShop@1 &>>$LOG_FILE
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE---exit 1ing\e[0m"
  exit 1
fi