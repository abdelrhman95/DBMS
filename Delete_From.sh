#!/bin/bash

checkColumnExistence() {
    local tableName=$1
    local columnName=$2
	
	    # Check if the column exists in the table metadata file
    existCol=$(awk -F':' -v c="$columnName" '$1 == c { print $0 }' "$tableName.meta")
    
    if [[ ! $existCol == "" ]]; then
        return 0 # Column exists, return success status (0)
    else 
       return 1   # Column does not exist, return failure status (non-zero)
   fi
}

getRowIndexByCondition() {
    local tableName=$1
    local columnName=$2
    local conditionValue=$3
    	# Get the column index in the metadata file by searching for its name and subtract 1 to get field number/index.
	((colIdx=$(awk -F':' -v c="$columnName" '$1 == c { print NR }' "$tableName.meta")-1))
	
		# Search for rows that match the condition value in specified column and store their indices in an array.
	value=($(awk -F':' -v x="$conditionValue" '$'$colIdx' == x { print NR }' "$tableName"))
	
	echo "${value[@]}"
}

deleteRowsByIndices() {
	local tableName=$1
	
	for idx in "$@"; do 
        sed -i "${idx}d" "$tableName"
        echo "Row ${idx} has been deleted successfully."
	done
}

Delete_FromTable () {

	if [ $# -eq 1 ]; then
		
		local tableName=$1
		
		if [ ! -f "$tableName" ]; then
			echo "Table not found: $tableName"
			return 0;
		fi
		
		read -p "Please enter the column name: " columnName
		
		if ! checkColumnExistence "$tableName" "$columnName"; then 
			echo "Column not found: $columnName"
			return 0;
	   fi
			
	   read -p "Enter delete condition value: " conditionValue
			
				   # Get the indices of rows to be deleted based on the column name and condition value
	   rowIndicesToDelete=($(getRowIndexByCondition "$tableName" "$columnName" "$conditionValue"))
	   
	   if [[ ${#rowIndicesToDelete[@]} > 0 ]]; then
	   		   # Delete rows with specified indices from the table file
		   deleteRowsByIndices "$tableName" "${rowIndicesToDelete[@]}"
	   else
		   echo "Value not found."
	   fi
		
	else 
		echo "Table not found."
	fi

}
