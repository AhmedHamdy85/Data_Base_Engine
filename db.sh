#!/bin/bash
source colors.sh


# Ensure the database path exists
if [ ! -d "$DB_PATH" ]; then
    mkdir -p "$DB_PATH"
    echo -e "${GREEN}Database directory created at '$DB_PATH'.${RESET}"
fi

while true; do
    echo -e  "${BLUE}================================== Bash DBMS Engine ===================================${RESET}"
    PS3="chose an Option:"
    Options=("Create Database" "List Databases" "Connect to Database" "Delete Database" "Refresh Screen" "Exit")
    select choice in "${Options[@]}"; do
    case $REPLY in 
    1)
        read -p "ENTER DATABASE NAME:" db_name
        if [[ "$db_name" =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]; then
            if [ ! -d "$DB_PATH/$db_name" ]; then
                mkdir "$DB_PATH/$db_name"
                echo -e "${GREEN}Database '$db_name' created successfully!${RESET}"
            else
                echo "Database '$db_name' already exists."
            fi
        else
            echo "Invalid database name. Must start with a letter or underscore."
        fi
        break
        ;;

    2)
        
        echo "Available Databases:"
        if [ -z "$(ls -A $DB_PATH)" ]; then
            echo "No databases found."
        else
            echo -e "${CYAN}=========================${RESET}"
            echo -e "${BLUE}|    Available Databases    |${RESET}"
            echo -e "${CYAN}=========================${RESET}"
            printf "${GREEN}| %-22s |\n${RESET}" "Database Name"
            echo -e "${CYAN}-------------------------${RESET}"
            for db in $(ls "$DB_PATH"); do
            printf "${GREEN}| %-22s |\n${RESET}" "$db"
            done
            echo -e "${CYAN}=========================${RESET}"
        fi
     
        break
        ;;

    3)
        read -p "ENTER DATABASE NAME TO CONNECT:" db_name
        if [ -d "$DB_PATH/$db_name" ]; then
            echo -e "${GREEN}CONECTING TO DATABASE '$db_name'. ${RESET}"
            ./table.sh "$DB_PATH/$db_name"
        else
            echo "Database '$db_name' does not exist."
        fi
        break
        ;;
    4)
        read -p "ENTER DATABASE NAME TO DELETE:" db_name
            if [ -d "$DB_PATH/$db_name" ]; then
                echo -e "${YELLOW}WARNING: ${RED}You will lose all your data, confirm deletion of database '$db_name'? (y/n):${RESET}"
                read  confirm
                 if [[ $confirm == "y" || $confirm == "Y" || $confirm == "yes" || $confirm == "YES" ]]; then
                     rm -r "$DB_PATH/$db_name"
                     echo "Database '$db_name' deleted successfully!"
                 else
                      echo "Deletion of database '$db_name' canceled."
                 fi  
               
            else
                echo "Database '$db_name' does not exist."
            fi
            break
            ;;

    5)
      # Emulate Ctrl + L to refresh the screen
            
        echo -e "\033[H\033[2J"
         break
        ;;
    6)
    read -p "Are you sure you want to exit? (y/n): " confirm
     
            if [[ $confirm == "y" || $confirm == "Y" || $confirm == "yes" || $confirm == "YES" ]]; then
                            echo -e "${CYAN}Exiting. Goodbye! ${RESET}"

                exit 0
            fi
            break
            ;;
    *)
    
        echo "Invalid option. Please choose a valid number."
        ;;
    esac
    done
done
