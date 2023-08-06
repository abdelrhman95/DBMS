#!usr/bin/bash
source ./DB_Functions.sh

mkdir -p DB

function mainmenu {

    while [ True ]
    do
        echo "Enter your Choice: "
        echo "*********************"

        select choice in "Create DB" "Connect DB" "List DB" "Drop DB" "Exit"
        do 
            case $choice in 
                        "Create DB" ) 

                        clear 
                        echo "****************"
                        read -p "Enter a Database name please: " databasename
                        Create_db $databasename
                        break ;;

                        "Connect DB" )
                        clear 
                        echo "****************"
                        read -p "Enter a Database to connect please: " databasename
                        Connect_db $databasename

                        break ;;
                        
                        "List DB" )
                        clear 
                        echo "****************"
                        echo "Here are the avilable Databases"
                        List_db
                        break ;;

                        "Drop DB" )
                        clear 
                        echo "****************"
                        read -p "Enter a Database to drop it please: " databasename

                        break ;;

                        "Exit" )
                        clear
                        exit;;

                        * )
                        clear 
                        echo "Invalid Choice, Please try again"
                        echo "********************************"
                        break ;;
            esac
        done
    done
}

mainmenu










