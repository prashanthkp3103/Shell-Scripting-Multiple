source common.sh
component=shipping
MAVEN

echo installing MYSQL client
dnf install mysql -y &>>$LOG_FILE
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE---exit 1ing\e[0m"
  exit 1
fi

for file in schema master-data app-user; do
  echo Loading  file is - $file.sql
  mysql -h mysql.dev.meppk.xyz -uroot -pRoboShop@1 < /app/db/$file.sql &>>$LOG_FILE
  if [ $? -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILURE---exit 1ing\e[0m"
    exit 1
  fi
done


#echo Loading masterdata.sql file
#mysql -h mysql.dev.meppk.xyz -uroot -pRoboShop@1 < /app/db/master-data.sql &>>$LOG_FILE
#if [ $? -eq 0 ]; then
#  echo -e "\e[32mSUCCESS\e[0m"
#else
#  echo -e "\e[31mFAILURE---exit 1ing\e[0m"
#  exit 1
#fi
#
#echo Loading appuser.sql file
#mysql -h mysql.dev.meppk.xyz -uroot -pRoboShop@1 < /app/db/app-user.sql &>>$LOG_FILE
#if [ $? -eq 0 ]; then
#  echo -e "\e[32mSUCCESS\e[0m"
#else
#  echo -e "\e[31mFAILURE---exit 1ing\e[0m"
#  exit 1
#fi

echo restarting ${component}
systemctl restart ${component} &>>$LOG_FILE
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE---exit 1ing\e[0m"
  exit 1
fi