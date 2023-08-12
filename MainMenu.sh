#! /usr/bin/bash
source ./DB_Functions.sh

mkdir -p DB

function mainmenu {

    while [ True ]
    do
        echo "Enter your Choice: "
        echo "*********************"

        # Show main menu
        #choice=$(zenity --list --title="Main Menu" --column="Options" --hide-header Create\ DB Connect\ DB List\ DB Drop\ DB Exit)

        #select choice in "Create DB" "Cocnnect DB" "List DB" "Drop DB" "Exit"
        select choice in "Create DB" "Connect DB" "List DB" "Drop DB" "Exit" 
         do

         
            case $choice in 
                        "Create DB" ) 

                        clear 
                        echo "****************"
                        read -p "Enter a Database name please: " databasename
                        #db_name=$(zenity --entry --text="Enter database name:")
                        Create_db "$databasename"
                        break ;;

                        "Connect DB" )
                        clear 
                        echo "****************"
                        read -p "Enter a Database to connect please: " databasename
                        #db_name=$(zenity --entry --text="Enter database name:")      
                        Connect_db "$databasename"
                        break ;;
                        
                        "List DB" )
                        clear 
                        echo "****************"
                        echo "Here are the avilable Databases"
                        (zenity --progress --text="Loading databases..." --percentage=0 &)
                        List_db
                        (zenity --progress --text="Loading databases..." --percentage=100 &)
                        break ;;

                         "Drop DB" )
                        clear 
                        echo "****************"
                        read -p "Enter a Database to drop it please: " databasename
                        #db_name=$(zenity --entry --text="Enter database name:")
                        Drop_db "$databasename"
                        
                        break ;;

                        "Exit" )
                        clear
                        exit;;

                        * )
                        clear 
                        echo "Invalid Choice, Please try again"
                        echo "********************************"
                        #zenity --error --text="Invalid choice. Please try again."
                        break ;;
            esac
        done
    done
}

mainmenu










