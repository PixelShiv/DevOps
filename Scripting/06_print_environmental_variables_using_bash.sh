#!/bin/bash

read -p "Enter an environmental variable :" var

echo "Environment:${!var}"
