#!/bin/bash

checkColumnExistence() {
    local tableName=$1
    local columnName=$2
    
    existCol=$(awk -F':' -v c="$columnName" '$1 == c { print $0 }' "$tableName.meta")
    
    if [[ ! $existCol == "" ]]; then
        return 0
    else 
       return 1  
   fi
}

getRowIndexByCondition() {
    local tableName=$1
    local columnName=$2
    local conditionValue=$3
    
	((colIdx=$(awk -F':' -v c="$columnName" '$1 == c { print NR }' "$tableName.meta")-1))
	
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
			
	   rowIndicesToDelete=($(getRowIndexByCondition "$tableName" "$columnName" "$conditionValue"))
	   
	   if [[ ${#rowIndicesToDelete[@]} > 0 ]]; then
		   deleteRowsByIndices "$tableName" "${rowIndicesToDelete[@]}"
	   else
		   echo "Value not found."
	   fi
		
	else 
		echo "Table not found."
	fi

}
