#!/bin/bash

#This script ask for a determined process (process name) and returns the PID of all process that its names match with the string (prpcess name) we specified.
#Then, you can kill the process by typing the PID.

#Clear the terminal
clear

#Start an infinite loop so that the script can ask for another process when the execution has ended.
while true
do
        #Print the instructions at the beginning
        echo ""
        echo -e "\e[41m\e[30m------------------------------- Kill the process -------------------------------\e[0m\e[0m"
        echo ""
        echo "Type the path or name of the process yo want to search. By default it shows all the process (not recommendable)."
        echo "Remember that you can use the *, ? or . to represent characters."

        #Saves in the variable process the process name that the user specify
        read -p "Process: " process

        #If the variable process is empty (user simply press enter)...
        if [[ $process = "" ]];
        then
        #... extract all the process and it saves to the variable linesnumber
                       linesnumber=`ps aux | wc -l`

                #...starts a loop that repeats as many times as processes (lines) have the variable linesnumber...
                for line in $(seq 1 $linesnumber);
                do
                        #...saves the user of the process
                        user=`ps aux | head -n $line | tail -n 1 |tr -s " " | cut -f1 -d" "`
                        #...saves the pid of the process
                        pid=`ps aux | head -n $line | tail -n 1 | tr -s " " | cut -f2 -d" "`
                        #...saves the time of the process
                        hour=`ps aux | head -n $line | tail -n 1 | tr -s " " | cut -f9 -d" "`
                        #...saves the name of the process
                        name=`ps aux | head -n $line | tail -n 1 | tr -s " " | cut -f11-15 -d" "`

                        #...print the process with all information of the process
                        echo -e $user "\e[32m"$pid"\e[0m" $hour "\e[36m"$name"\e[0m"
                done

        #If the condition doesn't match (user has entered a process name)...
        else
                #... extract all the process that match with the process name and it saves to the variable linesnumber
                linesnumber=`ps aux | grep $process | wc -l`

                #...starts a loop that repeats as many times as processes (lines) have the variable linesnumber...
                for line in $(seq 1 $linesnumber);
                do
                        #...saves the user of the process
                        user=`ps aux | grep $process | head -n $line | tail -n 1 |tr -s " " | cut -f1 -d" "`
                        #...saves the pid of the process
                        pid=`ps aux | grep $process | head -n $line | tail -n 1 | tr -s " " | cut -f2 -d" "`
                        #...saves the time of the process
                        hour=`ps aux | grep $process | head -n $line | tail -n 1 | tr -s " " | cut -f9 -d" "`
                        #...saves the name of the process
                        name=`ps aux | grep $process | head -n $line | tail -n 1 | tr -s " " | cut -f11-15 -d" "`

                        #...print the process with all information of the process
                        echo -e $user "\e[32m"$pid"\e[0m" $hour "\e[36m"$name"\e[0m"
                done
        fi

        #Print the next instructions
        echo ""
        echo "Which process (pid) you want to kill?"
        
        #Saves in the variable processid the PID name that the user specify
        read -p "PID: " processid

        #Saves the name of the process
        processname=`ps aux | grep $processid | tail -n 1 | tr -s " " | cut -f11-15 -d" "`

        #Kill the process with the PID we specified
        sudo kill $processid

        #Print the information of the killed process
        echo ""
        echo -e "Process \e[36m"$processname"\e[0m (\e[32m"$processid"\e[0m) killed!"
        echo ""
done
