LOG_FILE=/tmp/roboshop.log
rm -rf $LOG_FILE

PRINT () {
  echo &>>$LOG_FILE
  ecgo &>>$LOG_FILE
  echo "##################### $* #######################" &>>$LOG_FILE
  echo $*

  }
#STAT () {
#   if [ $? -eq 0 ]; then
#      echo SUCCESS
#    else
#      echo FAILURE
#    fi
#
#}
#access function with variable $? will be special variable

#STAT $?
NODEJS() {
  #You can list modules by using dnf module list
  #PRINT is a function
  PRINT Disbale Nodejs default Version
  dnf module disable nodejs -y &>>$LOG_FILE
  if [ $? -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILURE---Check log /tmp/roboshop.log\e[0m"
    exit 1
  fi


  PRINT Enable Nodejs 20 Version
  dnf module enable nodejs:20 -y &>>$LOG_FILE
  if [ $? -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILURE---Check log /tmp/roboshop.log\e[0m"
    exit 1
  fi


  PRINT Installing Nodejs
  #Install NodeJS
  dnf install nodejs -y &>>$LOG_FILE
  if [ $? -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILURE---Check log /tmp/roboshop.log\e[0m"
    exit 1
  fi


  PRINT Copying ${component} service file
  #Setup SystemD Catalogue Service
  cp ${component}.service /etc/systemd/system/${component}.service &>>$LOG_FILE
  if [ $? -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILURE---Check log /tmp/roboshop.log\e[0m"
    exit 1
  fi


  PRINT Adding mongo repo file
  #mongo client install
  cp mongo.repo /etc/yum.repos.d/mongo.repo &>>$LOG_FILE
  if [ $? -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILURE---Check log /tmp/roboshop.log\e[0m"
    exit 1
  fi



  PRINT Adding Application Roboshop user
  #Add application User
  #useradd roboshop &>>$LOG_FILE

  #checking user exist or no based on that creating
  id roboshop &>>$LOG_FILE
  if [ $? -ne 0 ]; then
   useradd roboshop &>>$LOG_FILE
  fi

  if [ $? -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILURE---Check log /tmp/roboshop.log\e[0m"
    exit 1
  fi


  PRINT Cleaning the old content
  rm -rf /app &>>$LOG_FILE
  if [ $? -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILURE---Check log /tmp/roboshop.log\e[0m"
    exit 1
  fi


  PRINT Create App directory
  #Lets setup an app directory
  mkdir /app &>>$LOG_FILE
  if [ $? -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILURE---Check log /tmp/roboshop.log\e[0m"
    exit 1
  fi



  PRINT Download App code
  #Download the application code to created app directory
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}-v3.zip &>>$LOG_FILE
  if [ $? -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILURE---Check log /tmp/roboshop.log\e[0m"
    exit 1
  fi

  cd /app &>>$LOG_FILE
  if [ $? -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILURE---Check log /tmp/roboshop.log\e[0m"
    exit 1
  fi

  PRINT extract App code content
  unzip /tmp/${component}.zip &>>$LOG_FILE
  if [ $? -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILURE---Check log /tmp/roboshop.log\e[0m"
    exit 1
  fi


  #Lets download the dependencies
  cd /app
  PRINT Downloading App dependencies
  npm install &>>$LOG_FILE
   if [ $? -eq 0 ]; then
     echo -e "\e[32mSUCCESS\e[0m"
   else
     echo -e "\e[31mFAILURE---Check log /tmp/roboshop.log\e[0m"
     exit 1
   fi

  PRINT loading the service
  #Load the service
  systemctl daemon-reload &>>$LOG_FILE
  if [ $? -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILURE---Check log /tmp/roboshop.log\e[0m"
    exit 1
  fi


  PRINT Starting the ${component} service
  #Start the service
  systemctl enable ${component} &>>$LOG_FILE
  systemctl start ${component} &>>$LOG_FILE
  if [ $? -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILURE---Check log /tmp/roboshop.log\e[0m"
    exit 1
  fi

}