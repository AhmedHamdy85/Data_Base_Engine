
source colors.sh

table_name=$2


table_path="$1/$table_name"

if [ -f "$table_path" ]; then
    if [ -f "$table_path.meta" ]; then
        col_types=($(head -n 1 "$table_path.meta"))
        col_names=($(tail -n 1 "$table_path.meta"))
        row_data=()
        for ((i=0; i<${#col_names[@]}; i++)); do
            col_name="${col_names[$i]}"
            col_type="${col_types[$i]}"
            valid=false

            while [ "$valid" = false ]; do
                read -p "Enter value for column '${col_name}' (type: ${col_type}): " value

                case "$col_type" in
                
                int)
                    if [[ "$value" =~ ^-?[0-9]+$ ]]; then
                        # is_exested=$(awk -v value="$value" -v col_name="$col_name" -F, 'BEGIN{found=0} {if($1==value) found=1} END{print found}' "$table_path")
                        valid=true
                    else
                        echo -e "${RED}Invalid input. Expected an integer. ${RESET}"
                    fi
                  
                    ;;
                float)
                    if [[ "$value" =~ ^[0-9]*\.?[0-9]+$ ]]; then
                        valid=true
                    else
                        echo -e "${RED}Invalid input. Expected a float. ${RESET}"
                    fi
                    ;;
                string)
                    if [[ "$value" != "" ]]; then
                        valid=true
                    else
                        echo -e "${RED}Invalid input. Expected a string. ${RESET}"
                    fi
                    ;;
                *)
                    echo -e "${RED}Unknown data type '${col_type}' in metadata. ${RESET}"
                    exit 1
                    ;;
                esac
            done
            row_data+=("$value")
        done

        echo "${row_data[*]}" >> "$table_path"
        echo -e "${GREEN}Row inserted into table '$table_name'. ${RESET}"
     else
        echo -e "${RED}Metadata for table '$table_name' not found. ${RESET}"
    fi
 else
    echo -e "${RED}Table '$table_name' does not exist. ${RESET}"
   
fi


























