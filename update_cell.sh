
#!/bin/bash

source colors.sh

# Get the table name and path
read -p "Enter table name: " table_name
table_path="$1/$table_name"
meta_path="$table_path.meta"

# Check if the table exists
if [ ! -f "$table_path" ]; then
    echo -e "${BOLD}${RED}Table '$table_name' does not exist.${RESET}"
    exit 1
fi

# Read column metadata
col_names=($(tail -n 1 "$meta_path"))
col_types=($(head -n 1 "$meta_path"))

row_count=$(wc -l < "$table_path")
col_count=${#col_names[@]}

if [ $row_count -eq 0 ]; then
    echo -e "${BOLD}${RED}Table '$table_name' is empty.${RESET}"
    echo -e "${BOLD}${BLUE}please insert some data${RESET}"
    exit 1
fi  
# Display the table columns
echo -e "${BOLD}${YELLOW}Table: $table_name${RESET}"
echo -e "${BOLD}${CYAN}Columns:${RESET}"
for ((i = 0; i < col_count; i++)); do
    echo -e "${BOLD}${CYAN}$((i + 1)). ${col_names[$i]} (${col_types[$i]})${RESET}"
done
echo -e "${BOLD}${CYAN}Nomber of Rows: $row_count${RESET}"

# Get the row number and column name for the update
read -p "Enter row number to update: " row_number
if ! [[ "$row_number" =~ ^[0-9]+$ && "$row_number" -gt 0 ]]; then
    echo -e "${RED}Invalid row number. Must be a positive integer greater than zero.${RESET}"
    exit 1
fi

read -p "Enter column name to update: " col_name
col_index=-1

# Find the column index
for ((i = 0; i < col_count; i++)); do
    if [ "${col_names[$i]}" == "$col_name" ]; then
        col_index=$i
        break
    fi
done

if [ "$col_index" -eq -1 ]; then
    echo -e "${RED}Column '$col_name' not found in table.${RESET}"
    exit 1
fi

# Get the new value for the cell
valid=false
while [ "$valid" = false ]; do
    read -p "Enter new value for column '${col_name}' (type: ${col_types[$col_index]}): " new_value
    case "${col_types[$col_index]}" in
    int)
        if [[ "$new_value" =~ ^-?[0-9]+$ ]]; then
            valid=true
        else
            echo -e "${RED}Invalid input. Expected an integer.${RESET}"
        fi
        ;;
    float)
        if [[ "$new_value" =~ ^-?[0-9]*\.?[0-9]+$ ]]; then
            valid=true
        else
            echo -e "${RED}Invalid input. Expected a float.${RESET}"
        fi
        ;;
    string)
        if [[ "$new_value" =~ ^.+$ ]]; then
            valid=true
        else
            echo -e "${RED}Invalid input. Expected a non-empty string.${RESET}"
        fi
        ;;
    *)
        echo -e "${RED}Unknown data type '${col_types[$col_index]}' in metadata.${RESET}"
        exit 1
        ;;
    esac
done

# Check if the row exists

if [ "$row_number" -gt "$row_count" ]; then
    echo -e "${RED}Row number $row_number does not exist in the table.${RESET}"
    exit 1
fi

# Update the specific cell
col_index=$((col_index + 1))
awk -v r=$row_number -v c=$col_index -v v=$new_value \
    'NR==r {$c=v}1' OFS=" " "$table_path" > "$table_path.tmp" && mv "$table_path.tmp" "$table_path"

echo -e "${GREEN}Cell updated successfully in row $row_number, column '$col_name'.${RESET}"
