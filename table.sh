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
            read -p "Are you sure you want to exit to Main Menu? (y/n): " confirm
            if [[ $confirm == "y" || $confirm == "Y" || $confirm == "yes" || $confirm == "YES" ]]; then
                            echo "Returning to Main Menu..."

                exit 0
            fi
            break
            ;;

        esac
    done



done
