source common.sh
component=catalogue
NODEJS





dnf install mongodb-mongosh -y

#Load Master Data of the List of products we want to sell and their quantity information also there in the same master data.
mongosh --host mongodb.dev.meppk.xyz </app/db/master-data.js

