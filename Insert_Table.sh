#!usr/bin/bash

Insert_Table(){

    table_name=$1

    # Validate Table name
    if [ $# -ne 1 ]; then 
        echo  "Error: Please provide one table name"
        return 1
    elif [ ! -f "$table_name" ]; then 
        echo "Error: Table "$table_name" does not exist"
        return 1 
    fi 

    #Get metadata 
    columns=$(awk 'END{print NR}' "$table_name.meta") ## its equal to wc -l
    fields=($(awk -F: '{print $1}' "$table_name.meta"))
    types=($(awk -F: '{print $2}' "$table_name.meta"))
    pks=($(awk -F: '{print $3}' "$table_name.meta"))


    # Get PK column name from meta data file 
    #pk_col=$(awk -F: '($3 == "Yes") {print $1}; exit' "$table_name.meta")


    #loop through cols
    for (( i=0; i<columns; i++ ));
    do 
        #get input 
        read -p "Enter value for ${fields[$i]} (${types[$i]}): " value
        
        #Validate Input data type
        if [[ ${types[$i]} == "Integer" ]]; then
            if ! [[ $value =~ ^[0-9]+$ ]]; then
                echo "Error: Invalid integer value."
                continue
            fi

        elif ! [[ $value =~ ^[a-zA-Z]+$ ]]; then
            echo "Error: Invalid string value."
            continue  
        fi

        
            # Check if current column is PK 
       # if [[ "${fields[$i]}" == "$pk_col" ]]; then
            # Validate PK not empty
            #if [ -z "$value" ]; then
             #   echo "Primary key cannot be empty."
              #  return 1
            #fi
        #fi


        # Validate PK if unique
        local pk_index=$(awk -F: '{ if ($3 == "Yes") print NR; exit }' "$table_name.meta")
        if [[ ${pks[$i]} == "Yes" ]]; then
            if awk -F: -v val=$value '($pk_index == val)' "$table_name" | read; then
                echo "Primary key value must be unique."
                continue
             fi
         fi


        # Append value
        row+="${value}:"


    done

    # Remove trailing :
    row=${row%?}





    # Insert Row 
    echo "$row" >> "$table_name"


    echo "1 record inserted successfully"


}
