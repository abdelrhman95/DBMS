# DBMS
Database Management Engine Using Linux Bash Scripting 

# About the project
The project aim is to build a database engine simulator, and I have used bash scripting to do that, through the project you will find: 

- the awk programming language that used to perform text processing and data extraction
- Functions for modularization and readability purposes
- the sed for searching, finding, and replacing

  # Project details
  
  The engine will first construct the "DB" directory, the top layer directory used to hold database folders. then the database directories that will hold the tables. Third, at the level of tables, the engine creates two files for each table it creates in a DBMS:
      
  - Data file: stores the data by users
  - Metadata file: Table schema(Table name, primary key, columns types)


# Note 

- to run it make sure to set the project path to .bashrc file
  
```bash
export PATH=$PATH:/the_projectpath_in_your_machine
```
- after that run it in your terminal
  ```bash
  MainMenu.sh
  ```
  
