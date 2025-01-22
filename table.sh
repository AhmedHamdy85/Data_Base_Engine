# #!/bin/bash
source colors.sh


while true ; do

    echo -e  "${BLUE}================================== TABLES MANEGMENT ===================================${RESET}"

    PS3="chose an Option:"
    options=("Create Table" "List Tables" "Drop Table" "Insert Row" "Show Data" "Delete Row" "Update Cell" "Search Data" "Export to CSV" "Exit to Main Menu")

    select choice in "${options[@]}"; do
        case $REPLY in 
        1)
            ./create_table.sh $1
            break
            ;;
        2)
            ./list_tables.sh $1
            break
            ;;
     
        3)
            read -p "Enter table name to drop: " table_name
            ./drop_table.sh $1 $table_name
            break
            ;;
        

        4)
            read -p "Enter table name to insert into: " table_name
            ./insert_row.sh $1 $table_name
            break
            ;;
        5)
            read -p "Enter table name to display: " table_name
            ./show_data.sh $1 $table_name
            break
            ;;
        6)
            read -p "Enter table name to delete row from: " table_name
            ./delete_row.sh $1 $table_name
            break
            ;;
        7)
            ./update_cell.sh $1 
            break
            ;;
        8)
            
            ./search_data.sh $1 
            break
            ;;
        9)
            ./export_to_csv.sh $1 
            break
            ;;
        10)
            echo "Returning to Main Menu..."
            exit 0
            ;;

        esac
    done



done




























































# DB_PATH=$1

# while true; do
#     echo "===== Table Menu ====="
#     PS3="Choose an option: "
#     options=("Create Table" "List Tables" "Drop Table" "Insert Row" "Show Data" "Delete Row" "Update Cell" "Search Data" "Export to CSV" "Exit to Main Menu")
#     select choice in "${options[@]}"; do
#         case $REPLY in
#         1)
#             read -p "Enter table name: " table_name
#             if [[ "$table_name" =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]; then
#                 table_path="$DB_PATH/$table_name"
#                 if [ ! -f "$table_path" ]; then
#                     read -p "Enter number of columns: " col_count
#                     col_names=()
#                     for ((i=1; i<=col_count; i++)); do
#                         read -p "Enter name for column $i: " col_name
#                         col_names+=("$col_name")
#                     done
#                     echo "${col_names[*]}" > "$table_path.meta"
#                     touch "$table_path"
#                     echo "Table '$table_name' created with columns: ${col_names[*]}"
#                 else
#                     echo "Table '$table_name' already exists."
#                 fi
#             else
#                 echo "Invalid table name. Must start with a letter or underscore."
#             fi
#             break
#             ;;
#         2)
#             echo "Available Tables:"
#             ls "$DB_PATH"
#             break
#             ;;
#         3)
#             read -p "Enter table name to drop: " table_name
#             table_path="$DB_PATH/$table_name"
#             if [ -f "$table_path" ]; then
#                 read -p "Are you sure you want to drop table '$table_name'? (y/n): " confirm
#                 if [[ $confirm == "y" ]]; then
#                     rm "$table_path" "$table_path.meta"
#                     echo "Table '$table_name' dropped successfully!"
#                 fi
#             else
#                 echo "Table '$table_name' does not exist."
#             fi
#             break
#             ;;
#         4)
#             read -p "Enter table name to insert into: " table_name
#             table_path="$DB_PATH/$table_name"
#             if [ -f "$table_path" ]; then
#                 columns=($(cat "$table_path.meta"))
#                 row_data=()
#                 for col in "${columns[@]}"; do
#                     read -p "Enter value for $col: " value
#                     row_data+=("$value")
#                 done
#                 echo "${row_data[*]}" >> "$table_path"
#                 echo "Row inserted successfully."
#             else
#                 echo "Table '$table_name' does not exist."
#             fi
#             break
#             ;;
#         5)
#             read -p "Enter table name to display: " table_name
#             table_path="$DB_PATH/$table_name"
#             if [ -f "$table_path" ]; then
#                 echo "Table Columns: $(cat "$table_path.meta")"
#                 echo "Table Data:"
#                 cat "$table_path"
#             else
#                 echo "Table '$table_name' does not exist."
#             fi
#             break
#             ;;
#         6)
#             read -p "Enter table name to delete row from: " table_name
#             table_path="$DB_PATH/$table_name"
#             if [ -f "$table_path" ]; then
#                 read -p "Enter row number to delete: " row_number
#                 sed -i "${row_number}d" "$table_path"
#                 echo "Row deleted successfully."
#             else
#                 echo "Table '$table_name' does not exist."
#             fi
#             break
#             ;;
#         7)
#             read -p "Enter table name to update: " table_name
#             table_path="$DB_PATH/$table_name"
#             if [ -f "$table_path" ]; then
#                 read -p "Enter row number to update: " row_number
#                 read -p "Enter column number to update: " col_number
#                 read -p "Enter new value: " new_value
#                 awk -v r=$row_number -v c=$col_number -v v=$new_value \
#                     'NR==r {$c=v}1' OFS=" " "$table_path" > "$table_path.tmp" && mv "$table_path.tmp" "$table_path"
#                 echo "Cell updated successfully."
#             else
#                 echo "Table '$table_name' does not exist."
#             fi
#             break
#             ;;
#         8)
#             read -p "Enter table name to search: " table_name
#             table_path="$DB_PATH/$table_name"
#             if [ -f "$table_path" ]; then
#                 read -p "Enter value to search for: " search_value
#                 grep -n "$search_value" "$table_path" || echo "No results found."
#             else
#                 echo "Table '$table_name' does not exist."
#             fi
#             break
#             ;;
#         9)
#             read -p "Enter table name to export: " table_name
#             table_path="$DB_PATH/$table_name"
#             if [ -f "$table_path" ]; then
#                 csv_file="$DB_PATH/$table_name.csv"
#                 echo "$(cat "$table_path.meta")" > "$csv_file"
#                 cat "$table_path" >> "$csv_file"
#                 echo "Table exported to $csv_file."
#             else
#                 echo "Table '$table_name' does not exist."
#             fi
#             break
#             ;;
#         10)
#             echo "Returning to Main Menu..."
#             exit 0
#             ;;
#         *)
#             echo "Invalid option. Please choose a valid number."
#             ;;
#         esac
#     done
# done
