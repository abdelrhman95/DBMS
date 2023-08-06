#!usr/bin/bash

Create_db(){
    
    db="DB/$1"

    if [ $# -ne 1 ]; then 
        echo "Invalid Input, User did't creat one!"
    
    else 

        #Check if the dir & database already exit
        if [[ $1 =~ ^[./] ]]; then 
            echo "Invalid Input, Directory Already exits"

        elif [ -d $db ]; then 
            echo " Database '$1' Already exits"

        # Check on the first is A string !! 
        elif [[ $1 =~ [a-zA-Z]] ]; then
            # if true !! then create a data base
            mkdir -p $db
            echo "Database '$1' created!"

        else
            echo "Invalid Input"
        fi 
    fi


}