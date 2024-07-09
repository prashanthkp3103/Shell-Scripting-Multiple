source common.sh
component=catalogue
NODEJS




echo installing mongodb client
dnf install mongodb-mongosh -y &>>$LOG_FILE
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE---exit 1ing\e[0m"
  exit 1
fi


echo loading catalogue db master data
#Load Master Data of the List of products we want to sell and their quantity information also there in the same master data.
mongosh --host mongodb.dev.meppk.xyz </app/db/master-data.js &>>$LOG_FILE

if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE---exit 1ing\e[0m"
  exit 1
fi

