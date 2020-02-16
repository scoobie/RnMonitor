#!/bin/bash

Docker()
{
docker container run --rm andrespp/pdi
docker container run --rm -v $(pwd):/jobs andrespp/pdi runt sample/dummy.ktr
docker container run --rm -v $(pwd):/jobs andrespp/pdi runj  sample/dummy.kjb
}

Checking()
{
checkpost=$(ps -eaf | grep postgres | grep -v grep | wc -l)
checkdoc=$(ps -eaf | grep docker | grep andrespp | grep -v grep | wc -l)
if [[ $checkpost -ge 1 ]];then
        echo "Postgres is running"
        if [[ $checkdoc -ge 1 ]];then
                echo "Docker is running Already.Not doing Anything"
                exit 1
        else
                echo "Docker is not running"
                Docker
        fi
else
        echo "Postgres is not running. Not going to start ETL process"
        exit 1
fi
}


Check()
{
Checking
Docker
}

prog_name=${0##*/}

usage=$(printf "\nPLease use the Script as:\n"; printf "\n sh $prog_name \n\n")

if [[ $# -ge 1 ]];then
     echo "${prog_name} : You have Entered incorrect Arguments "
     echo "${prog_name} : $usage "
     echo "${prog_name} : Exiting Program"
     exit
  else
     Check
fi
