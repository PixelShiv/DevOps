#!/bin/bash

read -p "Enter an environmental variable :" var

echo "Environmental variable For the given val : ${!var}"
