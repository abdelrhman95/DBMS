#! /usr/bin/bash

CreatTable() {

    #Validate table name 
        
        #check if users inputs more than one table at a time
    if [ $# -ne 1 ]; then
        echo "Please Enter One table name."
        return 1
        #check if the table exists
    elif [ -f "$1" ]; then 
        echo "Error: Table $1 already exists"
        return 1
    elif [[ ! $1 =~ ^[a-zA-Z]+$ ]]; then 
        echo "Error: Table name can only contain letters"
        return 1
    fi


    #Get Number of columns 
    while :; 
    do 
        read -p "Enter Number Of Columns: " num_columns
        if [[ $num_columns =~ ^[0-9]+$  ]] && [[ $num_columns -gt 0 ]]; then 
            break
        else 
            echo "Error: Please enter a number greater than 0."
        fi 
    done


    # Initialize Variables 
    pk_set=false
    metaData="Field:type:PK"

    #loop through cols details 
    for (( i =1; i<=$num_columns; i++ )); do 

        #Get column name 
        while :; 
        do 
            read -p "Enter Name For Column $1: " col_name
            if [[ $col_name =~ ^[a-zA-Z]+$ ]] && [[ ! $prev_name == $col_name ]]; then
                break
            else 
                echo "Error: Column name must be unique and only contain letters."
            fi 
        done

        #Get Columns type 
        while :;
        do 
            echo "Select column Type: "
            select type in "Integer" "String"; do
                case $type in 
                    "Integer" ) 
                        col_type="Integer"
                        break;;
                    "String" )
                        col_type="String"
                        break;;
                    * ) 
                        echo "Invalid Selection"
                esac
            done
            break
        done

        #Set Primary key 
        if ! $pk_set; then
            while :;
            do 
                echo "Make this columns primary key? (Y/N)"
                read choice 
                case $choice in 
                [Yy]* ) 
                    pk="Yes"
                    pk_set=true
                    break;;
                [Nn]* ) 
                    pk="No"
                    pk_set=false
                    break;;
                * ) 
                    echo "Invalid Choice"
                    break;;
                esac
            done 
        else 
            pk="No"
        fi


        #ADD to MetaData
        metaData+="\n$col_name:$col_type:$pk"

        #Update Previuos name variable 
        prev_name=$col_name

    done

    #Validate Primary ky set 
    if ! $pk_set; then 
        echo "Error: Must select a primary key columns."
        return 1
    fi 


    #Create tabel and meta data file 
    touch "$1" "$1.meta"
    echo -e "$metaData" > "$1.meta"

    echo "Table $1 Created Successfully."




    
}

