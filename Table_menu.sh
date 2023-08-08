#!usr/bin/bash 
source ./create_table.sh 
source ./list_tables.sh
source ./drop_table.sh

table_menu () {

    select choice in "Create Table" "List Table" "Drop Table" "Insert Into Table" "Select From Table" "Delete From Table" "Update Table" "Quit"
    do 
        case $choice in 
            "Create Table" ) 
                clear
                read -p "Enter table name: " table_name
                # call create tabel fun
                CreatTable $table_name

                break;;

            "List Table" )
               clear
               #call list_table fun
               List_Tables
               echo "__________________________"
               break;;

            "Drop Table" )
               clear 
               read -p "Enter table name please: " table_name
               #call drop table fun
               Drop_table $table_name
               break;;

            "Insert Into Table" )
                clear
                read -p "Enter table name please: " table_name
                #call insert into func
                break;;

            "Select From Table" )
                clear 
                read -p "Enter table name please: " table_name
                #call select from fun 
                break;;
            
            "Delete From Table" ) 
                clear 
                read -p "Enter table name please: " table_name
                #call delete from fun 
                break;;

            "Update Table" )

                clear 
                read -p "Enter table name please: " table_name
                #call update from fun 
                break;;
            
            "Quit" )
                clear
                exit
                break;;

            * )
                clear
                echo "Invalid Choice"
            
        esac
    done
        


}