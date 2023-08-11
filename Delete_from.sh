function deleteFromTable() {

  local table=$1

  # Validate input
  if [ ! -f "$table" ]; then
    echo "Error: Table not found"
    return 1
  fi

  # Get column to delete on
  read -p "Enter column name: " column
  if ! columnExists "$column" "$table.meta"; then
    echo "Error: Column does not exist"
    return 1
  fi

  # Get rows to delete
  rows=()
  while read -r row; 
    do
        rows+=("$row")
    done < <(getMatchingRows "$table" "$column" "$value")

    # Sort rows in reverse order
    rows=($(for row in "${rows[@]}"; do echo $row; done | sort -rn))

  # Delete rows
  for row in "${rows[@]}"; 
  do
        deleteRow "$table" $row
        echo "Deleted row $row"
  done  

  

  # Print total
  echo "Deleted ${#rows[@]} rows"
}



# Check if column exists
function columnExists() {
  local col=$1
  local meta=$2
  
  if grep -q "^$col:" "$meta"; then
    return 0
  else  
    return 1
  fi
}

# Get rows matching condition
function getRows() {
  local table=$1
  local col=$2
  local val=$3

  local col_idx=$(getColumnIndex "$col" "$table.meta")
  awk -F: -v idx=$col_idx -v value=$val '{ if ($idx == value) print NR }' "$table"
}

# Delete single row
function deleteRow() {
  local table=$1
  local row=$2
  
  sed -i "${row}d" "$table"
}

# Get column index
function getColumnIndex() {
  local col=$1
  local meta=$2

  awk -F: -v c="$col" '(NR>1 && $1 == c) { print NR }' "$meta"
}