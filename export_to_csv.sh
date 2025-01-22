source colors.sh 
            read -p "Enter table name to export: " table_name
            table_path="$1/$table_name"
            if [ -f "$table_path" ]; then
                csv_file="$1/$table_name.csv"
                echo "$(tail -n1 < $table_path.meta )" > "$csv_file"
                cat "$table_path" >> "$csv_file"
                echo -e "${GREEN}Table exported Succesfuly to $csv_file. ${RESET}"
            else
                echo -e "${RED}Table '$table_name' does not exist. ${RESET}"
            fi
           