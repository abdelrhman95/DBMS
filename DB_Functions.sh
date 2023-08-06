#!usr/bin/bash

Create_db(){
    
    db="DB/$1"

    if [ $# -ne 1 ]; then 
        echo "Invalid Input, User did't input anything!"
    
    else 

        #Check if the dir & database already exit
        if [[ $1 =~ ^[./] ]]; then 
            echo "Invalid Input, Directory Already exits"

        # Check if the length of the name is within limits (1-64 characters)
        #elif [[ ${#db} < 1 || ${#db} > 64 ]]; then 
            #echo "Invalid Input, Input length must be 1-64 charachter"

        #check if the data base already exits
        elif [ -d $db ]; then 
            echo " Database '$1' Already exits"  

        #check if the database name starts with or underscore(_)
        elif [[ $1 =~ ^[a-zA-Z_].* ]]; then
            
            # Check if the name contains letter or (_) or numbers !! 
            if [[ $1 =~ [a-zA-Z0-9_]*$ ]]; then

                # if true !! then create a data base
                mkdir -p $db
                echo "Database '$1' created!"
            fi


        else
            echo "Invalid Input"
        fi 
    fi


}


List_db(){
    list=$(ls DB | wc -l)

    # Check if the DIR EMPTY ! 
    if [[ $list == 0 ]]; then 
        echo "Directory is Empty"
    else 
        ls DB 
    fi 
}