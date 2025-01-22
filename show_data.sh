
source colors.sh

table_name=$2


table_path="$1/$table_name"


if [ -f "$table_path" ]; then
    # Read column types and names from the metadata file
    col_types=($(head -n 1 "$table_path.meta"))
    col_names=($(tail -n 1 "$table_path.meta"))

    # Calculate the number of columns
    col_count=${#col_names[@]}

    # Define column width
    col_width=15



    # Print the table name
    echo -e "${BOLD}${YELLOW}Table: $table_name${RESET}"

    # Create a horizontal border line
    border_line=$(printf '=%.0s' $(seq 1 $((col_count * col_width + col_count + 1))))
    border_line="${BLUE}${border_line}${RESET}"

    # Print the table header with column names and types
    echo -e "$border_line"
    printf "${BLUE}|${RESET}"
    for ((i = 0; i < col_count; i++)); do
        printf " ${YELLOW}%-*s${RESET} ${BLUE}|${RESET}" "$col_width" "${col_names[$i]} (${col_types[$i]})"
    done
    echo
    echo -e "$border_line"

    # Check if the table contains any rows
    if [ -s "$table_path" ]; then
        # Print each row in a formatted way using awk
        awk -v col_count="$col_count" -v col_width="$col_width" -v BLUE="$BLUE" -v GREEN="$GREEN" -v RESET="$RESET" '
        {
            printf "%s|%s", BLUE, RESET
            for (i = 1; i <= col_count; i++) {
                printf " %s%-*s%s %s|%s", GREEN, col_width, $i, RESET, BLUE, RESET
            }
            print ""
        }' "$table_path"
    else
        echo -e "${BLUE}| ${RESET}${BOLD}${CYAN}No data available in the table.${RESET} ${BLUE}|${RESET}"
    fi

    # Print the bottom border
    echo -e "$border_line"
else
    echo -e "${BOLD}${RED}Table '$table_name' does not exist.${RESET}"
fi


           