useradd demo
useradd demo &>/dev/null
echo $?


if conditions
------------
1-simple if
if [ expression ]; then
  commands
fi

2-if-else
if [ expression ]; then
  commands
else
  commands
fi

3-else if

if [ expression ]; then
  commands
elif [ expression2 ];
then
  commands
else
  commands
fi


if condition expressions : validates the expression
-----------------------
Number expressions
-eq -ne -lt
-le -gt -ge
[ 1 -eq 2 ]
[ 2 -eq 2 ]
[ 3 -eq 5 ]

string expressions
==,!=,-Z
[ abc == abc ]
[ xyz != abc ]
[ -z "$var" ]

File expressions
-e
[ -e /opt/file ]

if [ $? -eq 0 ];then
  echo SUCCESS
else
  echo FAILURE
fi

colours with echo
===============
#RED 31
#GREEN 32
#YELLOW 33
#BLUE 34
#MAGENTA 35
#CYAN 36
#syntax: echo -e "\e[COLmMESSSAGE\e[0,"
#-e to enable \e
#\e to enable color
#[COLm - which color to enable,replace COL with 31-36
#[0m - 0 to reset the color

#ex:
echo -e "\e[31mHello world in Red\e[0m"
echo -e "\e[32mHello world in GREENe[0m"
echo -e "\e[33mHello world in YELLOW\e[0m"
echo -e "\e[34mHello world in BLUE\e[0m"
echo -e "\e[35mHello world in MAGENTA\e[0m"
echo -e "\e[36mHello world in CYAN\e[0m"



if it is failure it should not continue -meaning stop the script if any failure
================================================================================
dnf install mongodb-org -y

 if [ $? -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILURE---Exiting\e[0m"
    exit
fi

echo $?
#it will show 0
exit status by default is 0
hence we have to explictly set


Here "exit" command does the exit if failure


 if [ $? -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILURE---Exiting\e[0m"
    exit
fi

#checking user exist or no based on that creating

id roboshop &>>$LOG_FILE

if [ $? -ne 0 ]; then
 useradd roboshop &>>$LOG_FILE
fi