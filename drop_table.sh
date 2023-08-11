#!usr/bin/bash

Drop_table(){

    #Require one arg - the table name 
    if [ $# -ne 1 ]; then 
        echo "Error: Please provide one table name to drop."
        return 1
    fi

    local table_name="$1"

    #check if table exists 
    if [ ! -f "$table_name" ]; then 
        echo "Error: Table '$table_name' does not exist."
        return 1
    fi 



    #confirm if user wants to drop
    read -p "Are you sure you want to drop table "$table_name"? [y/n]" confirm
    if [[ ! $confirm =~ ^[Yy]$ ]]; then 
        echo "Table drop cancelled"
        return 0 
    fi 

    #Drop table and its metadata file 
    rm "$table_name" "$table_name.meta"

    #print success message  
    echo "Table "$table_name" dropped successfully"
}