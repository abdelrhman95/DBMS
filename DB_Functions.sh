#! /usr/bin/bash

source ./Table_menu.sh

Create_db() {
    
    db="DB/$1"

    if [ $# -ne 1 ]; then 
        echo "Invalid Input, User did't input anything!"
    
    else 

        #Check if the dir & database already exit
        if [[ $1 =~ ^[./] ]]; then 
            echo "Invalid Input, Directory Already exits"
        
        elif [[ $1 == *\\*  ]] ; then 
            echo -e "Error. Invalid Input, canncot contain backslash.\c"
            

        #elif [[ $1 =~ " " ]]; then 
       #echo "Invalid Input, cannot contain spaces"

        # Check if the length of the name is within limits (1-64 characters)
        #elif [[ ${#db} < 1 || ${#db} > 64 ]]; then 
        elif [[ ${#1} -lt 1 || ${#1} -gt 64 ]]; then
            echo "Invalid Input, Input length must be 1-64 charachter"

        #check if the data base already exits
        elif [ -d $db ]; then 
            echo " Database '$1' Already exits"  

        #check if the database name starts with or underscore(_)
        elif [[ $1 =~ ^[a-zA-Z_].* ]] ; then
            
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


List_db() {
    list=$(ls DB | wc -l)

    # Check if the DIR EMPTY ! 
    if [[ $list == 0 ]]; then 
        echo "Directory is Empty"
    else 
        ls DB 
    fi 
}

Connect_db() {
    database="DB/$1"


    #check dir exits 
    if [ -d $database ]; then 
        # if its true then connect to the database 
        cd $database
        echo "Connected to database $1."
        #call table_menu fun
        table_menu
    else 
        echo "Error: Database $1 does not exist."
        echo "Suggestion, Do you want creat database $1 "

        select choice in "YES" "NO"
        do 
            case $choice in
                "YES")
                    Create_db $1
                    break;;
                "NO")
                    break;;
                *)
                    echo "Error. Invalid choice"
            esac
        done
        
    fi
}

Drop_db() {

    db="DB/$1"
    #check on number of arg sent
    if [ $# -eq 1 ]; then 
        if [ -d $db ]; then 
            echo "Warning. Do you want to drop database $1."
        # procdeure added to make the user rethink again
        select choice in "YES" "NO"
        do  
            case $choice in 
                "YES")  
                rm -r $db
                echo "Database $1 Successfully dropped"
                break;;

                "NO")
                break;;

                *)
                echo "Invalid Choice"
            esac
        done
        
        else 
            echo "Error. Invalid Database"
        fi
    else
        echo "Delete one database at a time"
    fi

}