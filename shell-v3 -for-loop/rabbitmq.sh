source common.sh
component=rabbimq
LOG_FILE=/tmp/roboshop.log

PRINT Coping the RabbitMQ Repo file
cp rabbitmq.repo /etc/yum.repos.d/rabbitmq.repo  &>>$LOG_FILE
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE---exit 1ing\e[0m"
  exit 1
fi

PRINT Installing Rabbitmq
dnf install rabbitmq-server -y  &>>$LOG_FILE
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE---exit 1ing\e[0m"
  exit 1
fi

PRINT Starting Rabbitmq
systemctl enable rabbitmq-server &>>$LOG_FILE
systemctl start rabbitmq-server  &>>$LOG_FILE
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE---exit 1ing\e[0m"
  exit 1
fi

#RabbitMQ comes with a default username / password as guest/guest.
#But this user cannot be used to connect.
#Hence we need to create one user for the application.

PRINT Setting Rabbitmq permissions
rabbitmqctl add_user roboshop roboshop123  &>>$LOG_FILE
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"  &>>$LOG_FILE
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE---exit 1ing\e[0m"
  exit 1
fi