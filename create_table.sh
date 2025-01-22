#!/bin/bash
source colors.sh
DB_PATH=$1

read -p "Enter Table Name: " table_name
            if [[ "$table_name" =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]; then
                table_path="$DB_PATH/$table_name"
                if [ ! -f "$table_path" ]; then
                    read -p "Enter number of columns: " col_count
                    col_names=()
                    col_types=()
                    for ((i=1; i<=col_count; i++)); do
                        read -p "Enter name for column $i: " col_name
                        read -p "Enter type for column $i: " col_type
                        col_names+=("$col_name")
                        col_types+=("$col_type")
                    done
                    echo "${col_types[*]}" > "$table_path.meta"
                    echo "${col_names[*]}" >> "$table_path.meta"
                    touch "$table_path"
                    echo -e "${GREEN}Table '$table_name' created with columns: ${col_names[*]} ${RESET}"
                else
                    echo -e "${BLUE}Table '$table_name' already exists. ${RESET}"

                fi
             else
                echo -e "${RED}Invalid table name. Must start with a letter or underscore. ${RESET}"
            fi

