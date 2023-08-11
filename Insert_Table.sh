#!usr/bin/bash

function check_input_type {
    local type=$1
    local field=$2
    
    if [[ $type == "Integer" ]]; then
        if ! [[ $field =~ ^[0-9]+$ ]]; then 
            echo "Invalid Integer"
            return 1
        fi
    elif [[ $type == "String" ]]; then
        if ! [[ $field =~ ^[a-zA-Z]+$ ]]; then
            echo "Invalid String"
            return 1
        fi
    fi

    return 0    
}

function check_pk_input {
    local arr_PK=($1)
	local counter=$2
	
	local PK_values=($(awk -F : '{print $'$counter'}' "$table_name"))
	
	for i in "${PK_values[@]}"; do
		if [[ $i == "$TableParameter" ]]; then		
			echo "---------------------------------"
			echo "Error: Value duplication in Primary Key!"
			echo "---------------------------------"
			echo "Please Try Again"

			return 1			
		fi		
	done
	
	return 0	
}

function Insert_Table {
	local table_name=$1
	
	if [ $# -eq 1 ]; then

		if [ -f "$table_name" ]; then
		
		    local column_numbers=$(awk 'END{print NR}' "$table_name.meta")
		    ((column_numbers--))
		    
		    typeset -i counter=1
			
	        TableContent=""
	        ColumnSep=":"
	        RowSep="\n"

	        ArrField=($(cut -d ":" -f 1 <"$table_name.meta"))
	        ArrType=($(cut -d ":" -f 2 <"$table_name.meta"))
	        ArrPK=($(cut -d ":" -f 3 <"$table_name.meta"))
	        
	        while [[ $counter -le $column_numbers ]]; do
	            read -p "Enter Value for parameter ${ArrField[counter]} (${ArrType[counter]}): " TableParameter

	            if ! check_input_type "${ArrType[$counter]}" "$TableParameter"; then
	                continue
	            fi

				if [[ ${ArrPK[$counter]} == "Yes" ]]; then
					if ! check_pk_input "${ArrPK[*]}" "$counter"; then
						continue 2	
					fi					
				fi

	        	if [[ $counter == $column_numbers ]]; then
	            	TableContent+=$TableParameter
	        	else
	            	TableContent+=$TableParameter$ColumnSep
	        	fi

	        	(( counter++ ))
	    	done
			
			echo "$TableContent" >> "$table_name"
			
	    else		
	        echo "This is not a valid table name"
	        echo "Please try again with the right name"
	    fi
	
	else	    
        echo "You need to enter one table name"
    fi    
}

