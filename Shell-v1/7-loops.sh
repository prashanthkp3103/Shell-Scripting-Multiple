#when we want to execute the same task / commands again again then we go with loops
# types of loops

#while
if we have expression then we go with while

i-=10
while [ $i -gt 0 ]; do
  echo Hello - $i
  i=$(($i-1))
done

#for
if we have inputs we go with this

for i in apple banana orange ; do
  echo Fruit Name - $i
  sleep 1
done

o/p:
Fruit Name - apple
Fruit Name - banana
Fruit Name - orange

sleep is just for gap between each one,remove sleep and see