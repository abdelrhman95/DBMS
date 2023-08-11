DeleteFromTable () {

    if [ $# -eq 1 ]
    then
        if [ -f $1 ]
        then
			read -p "Please Enter the Column Name: " Coln
			# Check column exist, if existed set the row meta data of it
			exist_col=$(awk  -F : -v c=$Coln '{if($1 == c)print $0 }' $1.meta)
			if ! [[ $exist_col == "" ]]
			then
				 read -p "Enter Delete Condition Value: " condition
				 # get the column index in  meta data file
				 (( ColIdx=$(awk  -F : -v c=$Coln '{if($1 == c)print NR }' $1.meta) -1 ))
				 # using column index in meta file to check if the value existed in any line on data file
				 value=($(awk -F : -v x=$condition '{if($'$ColIdx' == x) print NR}' $1)) 
				 if ! [[ ${value[*]} == "" ]]
				 then
				 	for (( i =${#value[*]}-1; i>=0; i-- ))
					 do
				 		sed -i ''${value[i]}'d' $1
						echo "Row ${value[i]} has value equal to $condition is deleted successfully"
					done
				 else
				 	echo "Value not found"
				 fi
			else
				echo "column not found"
			fi
		else
			echo "table not found"
		fi
	else
		echo "table not found"
	fi

                
                

}