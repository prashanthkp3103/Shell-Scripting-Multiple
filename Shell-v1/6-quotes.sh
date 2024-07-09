#Shell support 2 quotes

#when to use quote?
#if our input to any command is having a spl character(a-z,0-9,not _)
*
space
$
#
echo *
echo "*"


#single quotes are literal quoting( strict  quoting)
a=10
echo 'a is $a'
single  quotes it is not considering $a as variable and not printing

#Double quote are literal quoting( less strict quoting)
a=10
echo "a is $a"

DOble quotes it is considering $a as variable and printing

#example
echo *
it will print all the .sh scripts that are available

echo \*
it will print *

echo '* * * *'
it will print * * * *

a=10
echo "it is $a$s"
it will print 10


echo "it is $a\$s"
it will print 10$