#Function is a name given to a set of commands.
#where u think repetitively needed then we use this
#syntax

#funtion abc() {

#commands
#}

#or

#abc() {
#commands
#}


#How to call a function
#simply call the function like a command
#abc

#Ex

SAMPLE() {
 echo SAMPLE FUNCTION
}

SAMPLE




#variables in functions
#1-Declare variable in function, main program can access it and vice-versa
DEMO() {
  echo First argument - $1
}
DEMO abc
