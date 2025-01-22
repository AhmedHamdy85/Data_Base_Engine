source colors.sh


table_name=$2


table_path="$1/$table_name"

if [ -f "$table_path" ]; then
echo -e "${YELLOW}WARNNIG:${RED}Are you sure you want to drop table '$table_name'? (y/n): ${RESET}"
    read confirm
    if [[ $confirm == "y" || $confirm == "Y" || $confirm == "yes" || $confirm == "YES" ]]; then
        rm "$table_path" "$table_path.meta"
        echo -e "${GREEN}Table '$table_name' dropped successfully! ${RESET}"
    else
        echo -e "${BLUE} Table '$table_name' Drop operation cancelled! ${RESET}"
    fi
 else
    echo -e "${BLUE}Table '$table_name' does not exist. ${RESET}"
fi

