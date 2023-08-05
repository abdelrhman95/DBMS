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

                    "Drop Dataabse" )
                    clear 
                    echo "****************"
                    read -p "Enter a Database to drop it please: " databasename

                    break ;;

                    "Exit" )
                    clear
                    Exit;;

                    * )
                    clear 
                    echo "Invalid Choice, Please try again"
                    break ;;
        esac
    done
done











