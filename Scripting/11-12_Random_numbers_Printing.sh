#!/bin/bash

read -p "Enter a value for min : " min
read -p "Emter value for max : " max

echo "Printing numbers in between the given range : $(($min + RANDOM % ($max - $min + 1)))"
# RANDOM = 0 to 32676
