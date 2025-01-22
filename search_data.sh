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
col_count=${#col_names[@]}

# Display the table columns
echo -e "${BOLD}${YELLOW}Table: $table_name${RESET}"
echo -e "${BOLD}${CYAN}Columns:${RESET}"
for ((i = 0; i < col_count; i++)); do
    echo -e "${BOLD}${CYAN}$((i + 1)). ${col_names[$i]} (${col_types[$i]})${RESET}"
done


# Get the column to search in
read -p "Enter column name to search in: " col_name
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

# Get the search value
read -p "Enter value to search for: " search_value

# Search the table
found=false
header_line=$(printf '=%.0s' $(seq 1 $((col_count * 15 + col_count + 1))))
header_line="${BLUE}${header_line}${RESET}"

echo -e "$header_line"
printf "${BLUE}|${RESET}"
for ((i = 0; i < col_count; i++)); do
    printf " ${YELLOW}%-*s${RESET} ${BLUE}|${RESET}" 15 "${col_names[$i]} (${col_types[$i]})"
done
echo
echo -e "$header_line"

awk -v col_index="$col_index" -v search_value="$search_value" -v col_count="$col_count" -v BORDER_COLOR="$BLUE" -v RESET_COLOR="$RESET" -v ROW_COLOR="$GREEN" '
BEGIN {
   found = 0;
}
{
   if ($(col_index + 1) == search_value) {
      found = 1;
      printf "%s|%s", BORDER_COLOR, RESET_COLOR;
      for (i = 1; i <= col_count; i++) {
  
         printf " %s%-*s%s %s|%s", ROW_COLOR, 15, $i, RESET_COLOR, BORDER_COLOR, RESET_COLOR;
      }
      print "";
   }
}
END {
   if (found == 0) {
      print "${CYAN}No matching rows found.${RESET}";
   }
}
' "$table_path"





echo -e "$header_line "

