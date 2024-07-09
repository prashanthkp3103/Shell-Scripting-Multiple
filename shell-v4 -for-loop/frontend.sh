source common.sh
component=frontend

PRINT installing Nginx
#Install Nginx
dnf module disable nginx -y &>>$LOG_FILE
dnf module enable nginx:1.24 -y &>>$LOG_FILE
dnf install nginx -y &>>$LOG_FILE
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE---exit 1ing\e[0m"
  exit 1
fi



PRINT copying nginx config file
#Create Nginx Reverse Proxy Configuration to reach backend services.
cp nginx.conf /etc/nginx/nginx.conf &>>$LOG_FILE
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE---exit 1ing\e[0m"
  exit 1
fi

PRINT removing default nginx content
#Remove the default content that web server is serving.
rm -rf /usr/share/nginx/html/* &>>$LOG_FILE
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE---exit 1ing\e[0m"
  exit 1
fi

PRINT Download the App content
#Download the frontend content
curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}-v3.zip &>>$LOG_FILE

if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE---exit 1ing\e[0m"
  exit 1
fi

PRINT Extract the App content
#Extract the frontend content
cd /usr/share/nginx/html &>>$LOG_FILE
unzip /tmp/${component}.zip &>>$LOG_FILE
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE---exit 1ing\e[0m"
  exit 1
fi

PRINT Restart nginx to load the changes
#Restart Nginx Service to load the changes of the configuration.
systemctl restart nginx &>>$LOG_FILE
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE---exit 1ing\e[0m"
  exit 1
fi


