NODEJS() {
  #You can list modules by using dnf module list
  dnf module disable nodejs -y
  dnf module enable nodejs:20 -y
  #Install NodeJS
  dnf install nodejs -y

  #Setup SystemD Catalogue Service
  cp ${component}.service /etc/systemd/system/${component}.service

  #mongo client install
  cp mongo.repo /etc/yum.repos.d/mongo.repo



  #Add application User
  useradd roboshop

  #Lets setup an app directory
  mkdir /app

  #Download the application code to created app directory
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}-v3.zip
  cd /app
  unzip /tmp/${component}.zip

  #Lets download the dependencies
  cd /app
  npm install

  #Load the service
  systemctl daemon-reload

  #Start the service
  systemctl enable ${component}
  systemctl start ${component}

}