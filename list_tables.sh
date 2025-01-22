source colors.sh

    echo "Available Tables:"
    if [ -z "$(ls -A $1)" ]; then
        echo -e "${CYAN}No Tables found. ${RESET}"
    else
        echo -e "${CYAN}=========================${RESET}"
        echo -e "${BLUE}|    Available Tables    |${RESET}"
        echo -e "${CYAN}=========================${RESET}"
        printf "${GREEN}| %-22s |\n${RESET}" "Table Name"
        echo -e "${CYAN}-------------------------${RESET}"
        for db in $(ls "$1" | grep -v "\.meta"); do
            printf "${GREEN}| %-22s |\n${RESET}" "$db"
        done
        echo -e "${CYAN}=========================${RESET}"
    fi