#!/bin/bash

read -p "Enter value1 : " val1
read -p "Enter value2 : " val2

echo "the sum of given numbers is : $(($val1 + $val2))"
echo "the diff of given number is : $(($val1 - $val2))"
echo "the mull of given number is : $(($val1 * $val2))"
echo "the div of given number is : $(($val1 / $val2))"
echo "the rem of the given numbers are : $((val1 % $val2))"
