source colors.sh
table_name=$2


table_path="$1/$table_name"

if [ -f "$table_path" ]; then
    row_count=$(wc -l < "$table_path")
     if [ $row_count -eq 0 ]; then
        echo -e "${RED}Table '$table_name' is empty. ${RESET}"
      else
        read -p "Enter row number to delete: " row_number
      if [[ $row_number -gt 0 ]]; then
        sed -i "${row_number}d" "$table_path"
        echo -e "${GREEN}Row deleted successfully. ${RESET}"
      else
        echo -e "${RED}Invalid row number.  ${RESET}"
      fi
    fi
 else
    echo -e "${RED}Table '$table_name' does not exist. ${RESET}"
fi




















