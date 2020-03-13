#!/bin/bash

Docker()
{
docker container run --rm -v $(pwd):/jobs andrespp/pdi runj  jobs/dummy.kjb
}

Checking()
{
checkpost=$(ps -eaf | grep postgres | grep -v grep | wc -l)
checkdoc=$(ps -eaf | grep docker | grep pdi | grep -v grep | wc -l)
if [[ $checkpost -ge 1 ]];then
        echo "POSTGRES IS RUNNING"
        if [[ $checkdoc -ge 1 ]];then
                echo "PDI IS NOT RUNNING"
                exit 1
        else
                echo "PDI IS NOT RUNNING"
                Docker
        fi
else
        echo "PLEASE START POSTGRES, ETL WILL NOT RUN"
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
     echo "${prog_name} : YOU HAVE ENTERED INCORRECT ARGUMENTS "
     echo "${prog_name} : $usage "
     echo "${prog_name} : EXITING PROGRAM"
     exit
  else
     Check
fi
