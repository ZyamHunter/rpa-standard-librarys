*** Settings ***
Documentation       Manipulate, sort, and filter tabular data.

Library             RPA.Tables
Library             RPA.FileSystem
Library             RPA.JSON


*** Tasks ***
Files to Table
    ${files}=    List Files In Directory    ${CURDIR}
    ${files}=    Create table    ${files}
    Filter table by column    ${files}    size    >=    ${1024}
    FOR    ${file}    IN    @{files}
        Log    ${file}[name]
    END
    Write table to CSV    ${files}    ${OUTPUT_DIR}${/}files.csv
    Write table to CSV    ${files}    ${OUTPUT_DIR}${/}files.xlsx

Create Table
    # Create a new table using a Dictionary of Lists
    # Because of the dictionary keys the column names will be automatically set
    @{Table_Data_name}=    Create List    Mark    John    Amy
    @{Table_Data_age}=    Create List    ${58}    ${22}    ${67}
    &{Table_Data}=    Create Dictionary
    ...    name=${Table_Data_name}
    ...    age=${Table_Data_age}
    ${table}=    Create Table    ${Table_Data}

Add Table Column
    @{Table_Data_name}=    Create List    Mark    John    Amy
    @{Table_Data_age}=    Create List    ${58}    ${22}    ${67}
    &{Table_Data}=    Create Dictionary
    ...    name=${Table_Data_name}
    ...    age=${Table_Data_age}
    ${table}=    Create Table    ${Table_Data}

    # Add empty column with name
    Add table column    ${table}    name=Home Address

    # Add new column where every every row has the same value
    Add table column    ${table}    name=TOS    values=${FALSE}

    # Add new column where every row has a unique value
    ${is_first}=    Create list    ${TRUE}    ${FALSE}    ${FALSE}
    Add table column    ${table}    name=IsFirst    values=${is_first}

Add Table Row
    @{Table_Data_name}=    Create List    Mark    John    Amy
    @{Table_Data_age}=    Create List    ${58}    ${22}    ${67}
    &{Table_Data}=    Create Dictionary
    ...    name=${Table_Data_name}
    ...    age=${Table_Data_age}
    ${table}=    Create Table    ${Table_Data}
    # Add empty row
    Add table row    ${table}

    # Add row where every column has the same value
    Add table row    ${table}    Unknown

    # Add values per column
    ${values}=    Create dictionary    Username=Mark    Mail=mark@robocorp.com
    Add table row    ${table}    ${values}

Clear Table
    @{Table_Data_name}=    Create List    Mark    John    Amy
    @{Table_Data_age}=    Create List    ${58}    ${22}    ${67}
    &{Table_Data}=    Create Dictionary
    ...    name=${Table_Data_name}
    ...    age=${Table_Data_age}
    ${table}=    Create Table    ${Table_Data}
    Clear Table    ${table}
    Log To Console    Table clear: ${table}

Copy Table
    @{Table_Data_name}=    Create List    Mark    John    Amy
    @{Table_Data_age}=    Create List    ${58}    ${22}    ${67}
    &{Table_Data}=    Create Dictionary
    ...    name=${Table_Data_name}
    ...    age=${Table_Data_age}
    ${table}=    Create Table    ${Table_Data}

    ${new_table}=    Copy Table    ${table}

Export Table
    @{Table_Data_name}=    Create List    Mark    John    Amy
    @{Table_Data_age}=    Create List    ${58}    ${22}    ${67}
    &{Table_Data}=    Create Dictionary
    ...    name=${Table_Data_name}
    ...    age=${Table_Data_age}
    ${table}=    Create Table    ${Table_Data}

    ${export}=    Export table    ${table}

Filter Empty Rows
    @{Table_Data_name}=    Create List    Mark    John    Amy
    @{Table_Data_age}=    Create List    ${58}    ${22}    ${67}
    &{Table_Data}=    Create Dictionary
    ...    name=${Table_Data_name}
    ...    age=${Table_Data_age}
    ${table}=    Create Table    ${Table_Data}
    Filter empty rows    ${table}

Filter Table By Column
    @{Table_Data_name}=    Create List    Mark    John    Amy
    @{Table_Data_age}=    Create List    ${58}    ${22}    ${67}
    &{Table_Data}=    Create Dictionary
    ...    name=${Table_Data_name}
    ...    age=${Table_Data_age}
    ${table}=    Create Table    ${Table_Data}
    # Only accept prices that are non-zero
    Filter table by column    ${table}    age    !=    ${0}

    # Remove uwnanted product types
    @{types}=    Create list    Unknown    Removed
    Filter table by column    ${table}    name    not in    ${types}

Filter Table With Keyword
    @{Table_Data_name}=    Create List    Mark    John    Amy
    @{Table_Data_age}=    Create List    ${58}    ${22}    ${67}
    &{Table_Data}=    Create Dictionary
    ...    name=${Table_Data_name}
    ...    age=${Table_Data_age}
    ${table}=    Create Table    ${Table_Data}

    Filter Table With Keyword    ${table}    Map Table

Find Table Rows
    @{Table_Data_name}=    Create List    Mark    John    Amy
    @{Table_Data_age}=    Create List    ${58}    ${22}    ${67}
    &{Table_Data}=    Create Dictionary
    ...    name=${Table_Data_name}
    ...    age=${Table_Data_age}
    ${table}=    Create Table    ${Table_Data}
    # Find all rows where price is over 200
    @{rows}=    Find table rows    ${table}    age    >    ${200}

    # Find all rows where the status does not contain "removed"
    @{rows}=    Find table rows    ${table}    name    not contains    removed

Get Table Cell
    @{Table_Data_name}=    Create List    Mark    John    Amy
    @{Table_Data_age}=    Create List    ${58}    ${22}    ${67}
    &{Table_Data}=    Create Dictionary
    ...    name=${Table_Data_name}
    ...    age=${Table_Data_age}
    ${table}=    Create Table    ${Table_Data}
    # Get the value in the first row and first column
    Get table cell    ${table}    0    0

    # Get the value in the last row and first column
    Get table cell    ${table}    -1    0

    # Get the value in the last row and last column
    Get table cell    ${table}    -1    -1

    # Get the value in the third row and column "Name"
    Get table cell    ${table}    2    name

Get Table Column
    @{Table_Data_name}=    Create List    Mark    John    Amy
    @{Table_Data_age}=    Create List    ${58}    ${22}    ${67}
    &{Table_Data}=    Create Dictionary
    ...    name=${Table_Data_name}
    ...    age=${Table_Data_age}
    ${table}=    Create Table    ${Table_Data}
    ${emails}=    Get table column    ${table}    name

Get Table Dimensions
    @{Table_Data_name}=    Create List    Mark    John    Amy
    @{Table_Data_age}=    Create List    ${58}    ${22}    ${67}
    &{Table_Data}=    Create Dictionary
    ...    name=${Table_Data_name}
    ...    age=${Table_Data_age}
    ${table}=    Create Table    ${Table_Data}
    ${rows}    ${columns}=    Get table dimensions    ${table}
    Log    Table has ${rows} rows and ${columns} columns.

Get Table Row
    @{Table_Data_name}=    Create List    Mark    John    Amy
    @{Table_Data_age}=    Create List    ${58}    ${22}    ${67}
    &{Table_Data}=    Create Dictionary
    ...    name=${Table_Data_name}
    ...    age=${Table_Data_age}
    ${table}=    Create Table    ${Table_Data}
    # returns the first row in the table
    ${first}=    Get Table Row    ${table}    1

    # returns the last row in the table
    ${last}=    Get table row    ${table}    -1    as_list=${TRUE}

Get Table Slice
    @{Table_Data_name}=    Create List    Mark    John    Amy
    @{Table_Data_age}=    Create List    ${58}    ${22}    ${67}
    &{Table_Data}=    Create Dictionary
    ...    name=${Table_Data_name}
    ...    age=${Table_Data_age}
    ${table}=    Create Table    ${Table_Data}
    # Get all rows except first five
    ${slice}=    Get table slice    ${table}    start=0

    # Get rows at indexes 5, 6, 7, 8, and 9
    ${slice}=    Get table slice    ${table}    start=0    end=2

    # Get all rows except last five
    ${slice}=    Get table slice    ${table}    end=-2

Group Table By Column
    @{Table_Data_name}=    Create List    Mark    John    Amy
    @{Table_Data_age}=    Create List    ${58}    ${22}    ${67}
    &{Table_Data}=    Create Dictionary
    ...    name=${Table_Data_name}
    ...    age=${Table_Data_age}
    ${table}=    Create Table    ${Table_Data}
    # Groups rows of matching customers from the customer column
    # and returns the groups or rows as Tables
    @{groups}=    Group table by column    ${table}    name
    # An example of how to use the List of Tables once returned
    FOR    ${group}    IN    @{groups}
        # Process all orders for the customer at once
        Log    ${group}
    END

Map Column Values
    @{Table_Data_name}=    Create List    Mark    John    Amy
    @{Table_Data_age}=    Create List    ${58}    ${22}    ${67}
    &{Table_Data}=    Create Dictionary
    ...    name=${Table_Data_name}
    ...    age=${Table_Data_age}
    ${table}=    Create Table    ${Table_Data}
    # Convert all columns values to a different type
    Map column values    ${table}    age    Map Table

    # Look up values with a custom keyword
    Map column values    ${table}    name    Map Table

Merge Tables
    @{Table_Data_name}=    Create List    arroz    feijão    leite
    @{Table_Data_age}=    Create List    ${5}    ${8}    ${7}
    &{Table_Data}=    Create Dictionary
    ...    name=${Table_Data_name}
    ...    price=${Table_Data_age}
    ${prices}=    Create Table    ${Table_Data}

    @{Table_Data_name}=    Create List    carne    frango    proco
    @{Table_Data_age}=    Create List    ${30}    ${16}    ${20}
    &{Table_Data}=    Create Dictionary
    ...    name=${Table_Data_name}
    ...    stock=${Table_Data_age}
    ${stock}=    Create Table    ${Table_Data}

    ${products}=    Merge tables    ${prices}    ${stock}    index=name
    FOR    ${product}    IN    @{products}
        Log many
        ...    Product: ${product}[name]
        ...    Price: ${product}[price]
        ...    Stock: ${product}[stock]
    END

Pop Table Column
    @{Table_Data_name}=    Create List    arroz    feijão    leite
    @{Table_Data_age}=    Create List    ${5}    ${8}    ${7}
    &{Table_Data}=    Create Dictionary
    ...    name=${Table_Data_name}
    ...    age=${Table_Data_age}
    ${table_food}=    Create Table    ${Table_Data}

    # Remove column from table and discard it
    Pop table column    ${table_food}    name

    # Remove column from table and iterate over it
    ${ids}=    Pop table column    ${table_food}    age
    FOR    ${id}    IN    @{ids}
        Log    User id: ${id}
    END

Pop Table Row
    @{Table_Data_name}=    Create List    arroz    feijão    leite
    @{Table_Data_age}=    Create List    ${5}    ${8}    ${7}
    &{Table_Data}=    Create Dictionary
    ...    name=${Table_Data_name}
    ...    age=${Table_Data_age}
    ${table_food}=    Create Table    ${Table_Data}

    # Pop the firt row in the table and discard it
    Pop table row    ${table_food}

    # Pop the last row in the table and store it
    ${row}=    Pop table row    ${table_food}    -1    as_list=${TRUE}

Read table from CSV
    # Source dialect is deduced automatically
    ${table}=    Read table from CSV    ${OUTPUT_DIR}${/}files.csv
    Log    Found columns: ${table.columns}

    # Source dialect is known and given explicitly
    ${table}=    Read table from CSV    ${OUTPUT_DIR}${/}files.csv    dialect=excel
    Log    Found columns: ${table.columns}

Rename Table Columns
    @{Table_Data_name}=    Create List    Mark    John    Amy
    @{Table_Data_age}=    Create List    ${58}    ${22}    ${67}
    &{Table_Data}=    Create Dictionary
    ...    name=${Table_Data_name}
    ...    age=${Table_Data_age}
    ${table}=    Create Table    ${Table_Data}
    # Initially set the column names
    ${columns}=    Create list    First    Second    Third
    Rename table columns    ${table}    ${columns}
    # First, Second, Third

    # Update the first and second column names to Uno and Dos
    ${columns}=    Create list    Uno    Dos
    Rename table columns    ${table}    ${columns}
    # Uno, Dos, Third

Set Row As Column Names
    @{Table_Data_name}=    Create List    Mark    John    Amy
    @{Table_Data_age}=    Create List    ${58}    ${22}    ${67}
    &{Table_Data}=    Create Dictionary
    ...    name=${Table_Data_name}
    ...    age=${Table_Data_age}
    ${table}=    Create Table    ${Table_Data}
    # Set the column names based on the first row
    Set row as column names    ${table}    0

Set Table Cell
    @{Table_Data_name}=    Create List    Mark    John    Amy
    @{Table_Data_age}=    Create List    ${58}    ${22}    ${67}
    &{Table_Data}=    Create Dictionary
    ...    name=${Table_Data_name}
    ...    age=${Table_Data_age}
    ${table}=    Create Table    ${Table_Data}
    # Set the value in the first row and first column to "First"
    Set table cell    ${table}    0    0    First

    # Set the value in the last row and first column to "Last"
    Set table cell    ${table}    -1    0    Last

    # Set the value in the last row and last column to "Corner"
    Set table cell    ${table}    -1    -1    Corner

    # Set the value in the third row and column "Name" to "Unknown"
    Set table cell    ${table}    2    Name    Unknown

Set Table Column
    @{Table_Data_name}=    Create List    Mark    John    Amy    Jordan    Mikael
    @{Table_Data_age}=    Create List    ${58}    ${22}    ${67}    ${48}    ${60}
    &{Table_Data}=    Create Dictionary
    ...    name=${Table_Data_name}
    ...    age=${Table_Data_age}
    ${table}=    Create Table    ${Table_Data}
    # Set different value for each row (sizes must match)
    ${ids}=    Create list    1    2    3    4    5
    Set table column    ${table}    userId    ${ids}

    # Set the same value for all rows
    Set table column    ${table}    email    ${NONE}

Set Table Row
    @{Table_Data_name}=    Create List    Mark    John    Amy    Jordan    Mikael
    @{Table_Data_age}=    Create List    ${58}    ${22}    ${67}    ${48}    ${60}
    &{Table_Data}=    Create Dictionary
    ...    name=${Table_Data_name}
    ...    age=${Table_Data_age}
    ${table}=    Create Table    ${Table_Data}

    ${values}=    Create list    1    2    3
    Set table row    ${table}    0    ${values}

    ${values}=    Create dictionary    One=1    Two=2    Three=3
    Set table row    ${table}    1    ${values}

    Set table row    ${table}    2    ${NONE}

Sort Table By Column
    @{Table_Data_name}=    Create List    Mark    John    Amy
    @{Table_Data_age}=    Create List    ${58}    ${22}    ${67}
    &{Table_Data}=    Create Dictionary
    ...    name=${Table_Data_name}
    ...    age=${Table_Data_age}
    ${table}=    Create Table    ${Table_Data}
    # Sorts the order_date column ascending
    Sort table by column    ${table}    name

    # Sorts the order_date column descending
    Sort table by column    ${table}    age    ascending=${FALSE}

Table Head
    @{Table_Data_name}=    Create List    Mark    John    Amy
    @{Table_Data_age}=    Create List    ${58}    ${22}    ${67}
    &{Table_Data}=    Create Dictionary
    ...    name=${Table_Data_name}
    ...    age=${Table_Data_age}
    ${table}=    Create Table    ${Table_Data}
    # Get the first 10 employees
    ${first}=    Table head    ${table}    10

Table Tail
    @{Table_Data_name}=    Create List    Mark    John    Amy
    @{Table_Data_age}=    Create List    ${58}    ${22}    ${67}
    &{Table_Data}=    Create Dictionary
    ...    name=${Table_Data_name}
    ...    age=${Table_Data_age}
    ${table}=    Create Table    ${Table_Data}
    # Get the last 10 orders
    ${latest}=    Table tail    ${table}    10

Trim Column Names
    @{Table_Data_name}=    Create List    Mark    John    Amy
    @{Table_Data_age}=    Create List    ${58}    ${22}    ${67}
    &{Table_Data}=    Create Dictionary
    ...    name=${Table_Data_name}
    ...    age=${Table_Data_age}
    ${table}=    Create Table    ${Table_Data}
    # This example will take colums such as:
    # "One", "Two ", "    Three "
    # and trim them to become the below:
    # "One", "Two", "Three"
    Trim column names    ${table}

Trim Empty Rows
    @{Table_Data_name}=    Create List    Mark    John    Amy
    @{Table_Data_age}=    Create List    ${58}    ${22}    ${67}
    &{Table_Data}=    Create Dictionary
    ...    name=${Table_Data_name}
    ...    age=${Table_Data_age}
    ${table}=    Create Table    ${Table_Data}
    Trim empty rows    ${table}


*** Keywords ***
Map Table
    [Arguments]    ${CELL}
    Log    ${CELL}
