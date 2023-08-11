#!/bin/bash

# Function to check if table exists
function checkTableExistence {
    local tableName=$1
    
    if [ -f $tableName ]
    then
        return 0 # Table exists
    else
        return 1 # Table does not exist
    fi
}

# Function to display all records in a table
function displayAllRecords {
    local tableName=$1
    
    header=""
    
    # Determine the number of columns from meta file and get column names into an array 
	ArrField=($(cut -d':' -f1 "$tableName.meta"))
	
	# Concatenate column names with a separator (:)
	for (( j=0; j<${#ArrField[@]}; j++ ))
	do	
	    if [[ $j == $((${#ArrField[@]}-1)) ]]
	    then
	        header+="${ArrField[j]}"
	    else	
	        header+="${ArrField[j]}:"
	    fi							
	done
    
	echo "$header"
	echo "___________________________________________"

	cat "$tableName"
}

# Function to display specific record by primary key value 
function displayRecordByPK {
	local tableName=$1
	
	read -p "Enter your Primary Key Value: " primaryKeyValue
	
	PKindex=$(awk -F: '$3=="Yes"{print NR-1}' "$tableName.meta")  
                
	output=$(awk -v c=$primaryKeyValue 'BEGIN{FS=":"} {if ($'$PKindex'==c) print $0}' "$tableName")

	if [[ -z "$output" ]]
	then
    	echo "Record Not Found"
	else
    	echo "$output"
	fi

}

# Function to check if a column exists in a table and display its values 
function displayColumnValues {
	local tableName=$1
	
	read -p "Enter your Column Name: " columnName

	exist=$(awk -F':' -v c="$columnName" '$1 == c {print $0}' "$tableName.meta")

	if [[ ! -z "$exist" ]]
	then
		echo "Column Exist"

		number=$(awk -F':' -v c="$columnName" '$1 == c {print NR-1}' "$tableName.meta") 
		
		awk  'BEGIN{FS=":"} {print $'$number'}' "$tableName"
	else
	    echo "Column \"$columnName\" Does Not Exist"
	fi
	
}

# Function to display records based on a condition 
function displayRecordsWithCondition {
	read -p "Enter Column Name Condition: " ColNameCond
			# get column value in meta file (if existed)
			exist=$(awk  -F : -v c=$ColNameCond '{if($1 == c)print $0 }' $1.meta)
			# check existence
			if ! [[ $exist == "" ]]
			then
				# get column index of column name condition
				(( ConditionColNum=$(awk  -F : -v c=$ColNameCond '{if($1 == c)print NR }' $1.meta) -1 ))
				read -p "Enter the Value Condition : " Val
				# get the value in meta file (if existed)
				ValExist=$(awk  -F : -v c=$Val '{if($'$ConditionColNum' == c)print $0 }' $1)
				# get row index of value condition
				RowIndexVal=($(awk -F : -v c=$Val '{if($'$ConditionColNum' == c)print NR }' $1))
				if ! [[ $ValExist == "" ]]
				then
					for j in ${RowIndexVal[*]}
					do
						# print the value which has this Row Index 
						awk -F: -v c=$j '{if(NR == c) print $0}' $1
					done
				else
					echo "The value condition does not exist"
				fi
			else
				echo "Column not found"  
      fi
}

# Main function to select options from the table
function SelectFromTable {
	local tableName=$1
    
	# Check if only one table name is provided
	if [ $# -eq 1 ]
	then
	    # Check if the table exists (by checking the file)
	    checkTableExistence $tableName

        if [[ $? -eq 0 ]]
    	then
            select SELECTED in "All Records" "Record" "Column" "With Condition"
            do
                case $SELECTED in
                    "All Records")
                        clear
                        
                        displayAllRecords $tableName
                        
				        break;;
                    
					"Record")
					    clear
                    
				    	displayRecordByPK $tableName                
                        
				        break;;
                    
				    "Column")
					    clear
                    
					    displayColumnValues $tableName						
						
				        break;;
                    
				    "With Condition")
                        clear
                        
                        displayRecordsWithCondition $tableName                       
                        
				        break;;
                    
				    *)
					    echo "Invalid Choice"
					    ;;
                esac
            done
            
        else
            echo "This is not a valid table name. Please try again with the correct name."
        fi
        
    else
        echo "You can only select one table at a time."
    fi    
}

