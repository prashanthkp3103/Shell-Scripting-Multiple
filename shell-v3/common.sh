LOG_FILE=/tmp/roboshop.log
rm -rf $LOG_FILE

PRINT () {
  echo &>>$LOG_FILE
  ecgo &>>$LOG_FILE
  echo "##################### $* #######################" &>>$LOG_FILE
  echo $*

  }

NODEJS() {
  #You can list modules by using dnf module list
  #PRINT is a function
  PRINT Disbale Nodejs default Version
  dnf module disable nodejs -y &>>$LOG_FILE
  if [ $? -eq 0 ]; then
    echo SUCCESS
  else
    echo FAILURE
  fi


  PRINT Enable Nodejs 20 Version
  dnf module enable nodejs:20 -y &>>$LOG_FILE
  if [ $? -eq 0 ]; then
    echo SUCCESS
  else
    echo FAILURE
  fi


  PRINT Installing Nodejs
  #Install NodeJS
  dnf install nodejs -y &>>$LOG_FILE
  if [ $? -eq 0 ]; then
    echo SUCCESS
  else
    echo FAILURE
  fi


  PRINT Copying ${component} service file
  #Setup SystemD Catalogue Service
  cp ${component}.service /etc/systemd/system/${component}.service &>>$LOG_FILE
  if [ $? -eq 0 ]; then
    echo SUCCESS
  else
    echo FAILURE
  fi


  PRINT Adding mongo repo file
  #mongo client install
  cp mongo.repo /etc/yum.repos.d/mongo.repo &>>$LOG_FILE
  if [ $? -eq 0 ]; then
    echo SUCCESS
  else
    echo FAILURE
  fi



  PRINT Adding Application Roboshop user
  #Add application User
  useradd roboshop &>>$LOG_FILE
  if [ $? -eq 0 ]; then
    echo SUCCESS
  else
    echo FAILURE
  fi


  PRINT Cleaning the old content
  rm -rf /app &>>$LOG_FILE
  if [ $? -eq 0 ]; then
    echo SUCCESS
  else
    echo FAILURE
  fi


  PRINT Create App directory
  #Lets setup an app directory
  mkdir /app &>>$LOG_FILE
  if [ $? -eq 0 ]; then
    echo SUCCESS
  else
    echo FAILURE
  fi



  PRINT Download App code
  #Download the application code to created app directory
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}-v3.zip &>>$LOG_FILE
  if [ $? -eq 0 ]; then
    echo SUCCESS
  else
    echo FAILURE
  fi

  cd /app &>>$LOG_FILE
  if [ $? -eq 0 ]; then
    echo SUCCESS
  else
    echo FAILURE
  fi

  PRINT extract App code content
  unzip /tmp/${component}.zip &>>$LOG_FILE
  if [ $? -eq 0 ]; then
    echo SUCCESS
  else
    echo FAILURE
  fi


  #Lets download the dependencies
  cd /app
  PRINT Downloading App dependencies
  npm install &>>$LOG_FILE
  if [ $? -eq 0 ]; then
    echo SUCCESS
  else
    echo FAILURE
  fi


  PRINT loading the service
  #Load the service
  systemctl daemon-reload &>>$LOG_FILE
  if [ $? -eq 0 ]; then
    echo SUCCESS
  else
    echo FAILURE
  fi


  PRINT Starting the ${component} service
  #Start the service
  systemctl enable ${component} &>>$LOG_FILE
  systemctl start ${component} &>>$LOG_FILE
  if [ $? -eq 0 ]; then
    echo SUCCESS
  else
    echo FAILURE
  fi


}