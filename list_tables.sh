#!usr/bin/bash


List_Tables() {

    #Get List of tables, excluding meta files 
    tables=$(ls | grep -v ".meta")


    #Check if any tabels exist
    if [ -z "$tables" ]; then 
        echo "No tabels found"
        return 
    fi 

    #print header 
    echo "Tables: "

    #print each table on a new line 
    while read -r table; 
    do  
        echo "$table"

    done <<< "$tables"





}
