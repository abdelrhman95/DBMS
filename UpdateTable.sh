function UpdateTable {

  if [[ $# -ne 1 ]]; then
    echo "Error: missing table name argument" 
    return 1
  fi
  
  table=$1
  
  if [[ ! -f $table ]]; then
    echo "Error: table $table not found"
    return 1
  fi

  meta=$table.meta
  
  read -p "Enter the Column Name Condition: " cond_col
  cond_col_num=$(awk -F: -v c="$cond_col" '{if ($1 == c) print NR}' $meta)
  
  if [[ -z $cond_col_num ]]; then
    echo "Error: column $cond_col not found"
    return 1
  fi
  
  ((cond_col_num--))
  
  read -p "Enter the Value Condition: " cond_val
  
  cond_val_rows=$(awk -F: -v c="$cond_val" '{if ($'$cond_col_num' == c) print NR}' $table)
  
  if [[ -z $cond_val_rows ]]; then
    echo "Error: value $cond_val not found for column $cond_col"
    return 1
  fi
  
  read -p "Enter Column Name to Set: " set_col
  set_col_num=$(awk -F: -v c="$set_col" '{if ($1 == c) print NR}' $meta)
  
  if [[ -z $set_col_num ]]; then
    echo "Error: column $set_col not found" 
    return 1
  fi

  ((set_col_num--))

  read -p "Enter the New Value: " new_val

  for row in $cond_val_rows; do

    old_val=$(awk -F: -v r=$row '{if (NR == r) print $'$set_col_num'}' $table)

    awk -F: -v r=$row -v v="$new_val" 'BEGIN {OFS=":"} {if (NR == r) $'$set_col_num' = v} {print}' $table > tmp && mv tmp $table

    echo "Updated row $row column $set_col from '$old_val' to '$new_val'"

  done

  echo "Table $table updated successfully"
  
}