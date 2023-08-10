#!usr/bin/bash

InsertTable() {

  local table_name=$1

  # Validate table name
  if [ $# -ne 1 ]; then
    echo "Error: Please provide one table name."
    return 1
  elif [ ! -f "$table_name" ]; then
    echo "Error: Table '$table_name' does not exist."
    return 1
  fi

  # Get metadata
  local columns=$(awk 'END{print NR}' "$table_name.meta")
  local names=($(awk -F: '{print $1}' "$table_name.meta"))
  local types=($(awk -F: '{print $2}' "$table_name.meta"))
  local pks=($(awk -F: '{print $3}' "$table_name.meta"))

  # Loop through columns
  for (( i=0; i<columns; i++ )); do

    # Get input
    read -p "Enter value for ${names[$i]} (${types[$i]}): " value

    # Validate input type
    if [[ ${types[$i]} == "Integer" ]]; then
      if ! [[ $value =~ ^[0-9]+$ ]]; then
        echo "Error: Invalid integer value."
        continue
      fi
    elif ! [[ $value =~ ^[a-zA-Z]+$ ]]; then
      echo "Error: Invalid string value."
      continue  
    fi

    # Validate unique PK
    if [[ ${pks[$i]} == "Yes" ]]; then
      if grep "^${value}:" "$table_name" &>/dev/null; then
        echo "Error: Primary key value must be unique."
        continue
      fi  
    fi

    # Append value to row
    if [[ $i -eq $((columns-1)) ]]; then
      row+="${value}"
    else
      row+="${value}:"
    fi

  done

  # Insert row
  echo "$row" >> "$table_name"

  echo "Inserted row successfully."

}