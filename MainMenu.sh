#!usr/bin/bash
DB_Functions.sh

mkdir -p DB

function mainmenu {

    while [ True ]
    do
        echo "Enter your Choice: "
        echo "*********************"

        select choice in "Create Database" "Connect Database" "Show Databases" "Drop Database" "Exit"
        do 
            case $choice in 
                        "Create Database" ) 

                        clear 
                        echo "****************"
                        read -p "Enter a Database name please: " databasename
                        Create_db $databasename
                        break ;;

                        "Connect Database" )
                        clear 
                        echo "****************"
                        read -p "Enter a Database to connect please: " databasename

                        break ;;
                        
                        "Show Databases" )
                        clear 
                        echo "****************"
                        echo "Here are the avilable Databases"

                        read -p "Enter a Database name to show it please: " databasename
                        break ;;

                        "Drop Database" )
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










