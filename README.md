We are going to learn Bash

#List of Shell Topics

#.sh suffix to file
#create commands execute it from script with script execution permission
#comments (a line starts with # is comment)
#execute frontend.sh with sudo as it has packages installation(sudo bash frontend.sh)
#copy nginx.conf file to /etc/nginx.conf location

#Sed
previously we had used vi, now i wanted to do in automated way
a-delete a line
b-add a new line
c-change a line
d- word search and replace

sed is available in 2 ways,
a-edit the file
sed -i 'ACTION' file

b-display the changes on screen
    sed 'ACTION' file

#criteria can be picked in 2 ways
1-line no based
2-string search based

#a-delete a line
#1-line no based
sed '1 d' file

#2-string search based
sed '/root/ d' file

Both the above examples will just display the output however if i want to edit the file 
sed -i '1 d' file
sed -i '/root/ d' file

1-printing
2-variables
3-conditions
4-functions
5-loops
