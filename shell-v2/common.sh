LOG_FILE = /tmp/roboshop.log
rm -rf $LOG_FILE

PRINT () {
  echo &>>$LOG_FILE
  ecgo &>>$LOG_FILE
  echo "##################### $* #######################" &>>$LOG_FILE
  echo $*

  }

NODEJS() {
  #You can list modules by using dnf module list
  PRINT Disbale Nodejs default Version
  dnf module disable nodejs -y &>>$LOG_FILE

  PRINT Enable Nodejs 20 Version
  dnf module enable nodejs:20 -y &>>$LOG_FILE

  PRINT Installing Nodejs
  #Install NodeJS
  dnf install nodejs -y &>>$LOG_FILE


  PRINT Copying ${component} service file
  #Setup SystemD Catalogue Service
  cp ${component}.service /etc/systemd/system/${component}.service &>>$LOG_FILE

  PRINT Adding mongo repo file
  #mongo client install
  cp mongo.repo /etc/yum.repos.d/mongo.repo &>>$LOG_FILE


  PRINT Adding Application Roboshop user
  #Add application User
  useradd roboshop &>>$LOG_FILE

  PRINT Create App directory
  #Lets setup an app directory
  mkdir /app &>>$LOG_FILE

  PRINT Cleaning the old content
  rm -rf /app &>>$LOG_FILE

  PRINT Download App code
  #Download the application code to created app directory
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}-v3.zip &>>$LOG_FILE
  cd /app &>>$LOG_FILE
  PRINT extract App code content
  unzip /tmp/${component}.zip &>>$LOG_FILE

  #Lets download the dependencies
  cd /app
  PRINT Downloading App dependencies
  npm install &>>$LOG_FILE

  PRINT loading the service
  #Load the service
  systemctl daemon-reload &>>$LOG_FILE

  PRINT Starting the ${component} service
  #Start the service
  systemctl enable ${component} &>>$LOG_FILE
  systemctl start ${component} &>>$LOG_FILE

}