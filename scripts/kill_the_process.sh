#!/bin/bash

#Este script pregunta por un proceso en concreto (nombre del proceso) y devuelve el PID de todos los procesos que contengan ls string definidad en su nombre.
#Luego te da la posibilidad de terminar el proceso por su PID.

while true
do
        echo ""
        echo -e "\e[41m\e[30m------------------------------- Kill the process -------------------------------\e[0m\e[0m"
        echo ""
        echo "Type the path or name of the process yo want to search. By default it shows all the process (not recommendable)."
        echo "Remember that you can use the *, ? or . to represent characters."
        read -p "Process: " process

        if [[ $process = "" ]];
        then
                linesnumber=`ps aux | wc -l`

                for line in $(seq 1 $linesnumber);
                do
                        user=`ps aux | head -n $line | tail -n 1 |tr -s " " | cut -f1 -d" "`
                        pid=`ps aux | head -n $line | tail -n 1 | tr -s " " | cut -f2 -d" "`
                        hour=`ps aux | head -n $line | tail -n 1 | tr -s " " | cut -f9 -d" "`
                        name=`ps aux | head -n $line | tail -n 1 | tr -s " " | cut -f11-15 -d" "`

                        echo -e $user "\e[32m"$pid"\e[0m" $hour "\e[36m"$name"\e[0m"
                done
        else
                linesnumber=`ps aux | grep $process | wc -l`

                for line in $(seq 1 $linesnumber);
                do
#                       echo "Numero de linea: " $line
                        user=`ps aux | grep $process | head -n $line | tail -n 1 |tr -s " " | cut -f1 -d" "`
                        pid=`ps aux | grep $process | head -n $line | tail -n 1 | tr -s " " | cut -f2 -d" "`
                        hour=`ps aux | grep $process | head -n $line | tail -n 1 | tr -s " " | cut -f9 -d" "`
                        name=`ps aux | grep $process | head -n $line | tail -n 1 | tr -s " " | cut -f11-15 -d" "`

                        echo -e $user "\e[32m"$pid"\e[0m" $hour "\e[36m"$name"\e[0m"
                done
        fi

        echo ""
        echo "Which process (pid) you want to kill?"
        read -p "PID: " processid

        processname=`ps aux | grep $processid | tail -n 1 | tr -s " " | cut -f11-15 -d" "`

        sudo kill $processid

        echo ""
        echo -e "Process \e[36m"$processname"\e[0m (\e[32m"$processid"\e[0m) killed!"
        echo ""
done
