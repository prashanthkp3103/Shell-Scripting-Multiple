#variable is a name given to string
#example
#x=100 y=abc

#in shell we dont have data types
#everything is string

#how to access / reference variable
#$VARNAME = $x $y

#Example
name = "Devops"
faculty = "Raghu"

echo welcome to $name training
echo $name Training - Faculty $faculty

#or
echo ${name} Training - Faculty ${faculty}


#when to use {}
#in case if u want to print combination of variables
apple =20
echo apple price - $appleDollars
echo apple price - ${apple}Dollars

#variable substitution
#1-command substitution
#you can declare a variable by executing a command and store the output in variable
#syntx - var=$(command)

#2-arthmetic substitution
#you can declare a variable by solving the given arthemetic expression
# synx - var =$((1+2-3/4))

#examples
date=$(date)
echo Today date is - $date

add=$((2+3+4))
echo 2+3+4 - $add

#you can access variables from cli
#approach 1- git pull;x=100 bash 03-variables.sh
#approach 1- git pull;x=100 y=200 bash 03-variables.sh
echo value of x from cli - $x
echo value of x from cli - $y

#approach 2 - bash 03-variables.sh 100 200 (special variables)
echo first argument - $1
echo first argument - $2
echo All argument - $*
echo argument count - $#

#approach 3 - export z=500; bash 03-variables.sh
#it means we are setting environment variable
echo environment variable z = $z


