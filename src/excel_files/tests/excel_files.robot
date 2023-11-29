*** Settings ***
Library     RPA.Tables
Library     RPA.Excel.Files
Library     RPA.FileSystem


*** Tasks ***
Create Workbook
    Create Workbook    ${OUTPUT_DIR}${/}my_new_excel.xlsx
    FOR    ${index}    IN RANGE    20
        &{row}=    Create Dictionary
        ...    Row No    ${index}
        ...    Amount    ${index * 25}
        Append Rows to Worksheet    ${row}    header=${TRUE}
    END

    Create Worksheet    Teste1
    Save Workbook

    Create Workbook    ${OUTPUT_DIR}${/}my_new_excel.xlsx    xlsx
    FOR    ${index}    IN RANGE    20
        &{row}=    Create Dictionary
        ...    Row No    ${index}
        ...    Amount    ${index * 25}
        Append Rows to Worksheet    ${row}    header=${TRUE}
    END

    Create Worksheet    Teste1
    Save Workbook

Append Rows To Worksheet
    Create Workbook    ${OUTPUT_DIR}${/}append_excel.xlsx    xlsx
    FOR    ${index}    IN RANGE    20
        &{row}=    Create Dictionary
        ...    Row No    ${index}
        ...    Amount    ${index * 25}
        Append Rows to Worksheet    ${row}    header=${TRUE}
    END

    Create Worksheet    TesteRowsWorkSheet
    Save Workbook

Auto Size Columns
    ${EXCEL_FILE}=    Absolute Path    src\\excel_files\\assets\\TAXA_EDIT.xlsx
    Open workbook    ${EXCEL_FILE}
    Auto Size Columns    start_column=A    end_column=D    width=16
    Close Workbook

Clear Cell Range
    ${EXCEL_FILE}=    Absolute Path    ${OUTPUT_DIR}${/}my_new_excel.xlsx
    Open workbook    ${EXCEL_FILE}
    Clear Cell Range    A1:A20
    # another example
    ${EXCEL_FILE}=    Absolute Path    ${OUTPUT_DIR}${/}my_new_excel.xlsx
    Open workbook    ${EXCEL_FILE}
    Clear Cell Range    A2

Close Workbook
    ${EXCEL_FILE}=    Absolute Path    src\\excel_files\\assets\\TAXA_EDIT.xlsx
    Open workbook    ${EXCEL_FILE}
    ${worksheet}=    Read worksheet    header=${TRUE}
    [Teardown]    Close workbook

Copy Cell Values
    ${EXCEL_FILE}=    Absolute Path    ${OUTPUT_DIR}${/}my_new_excel.xlsx
    Open workbook    ${EXCEL_FILE}
    Copy Cell Values    A1:D4    G10

Create Worksheet
    ${EXCEL_FILE}=    Absolute Path    ${OUTPUT_DIR}${/}my_new_excel.xlsx
    Open workbook    ${EXCEL_FILE}
    Create Worksheet    Sheet15
    Save Workbook

Delete Columns
    ${EXCEL_FILE}=    Absolute Path    ${OUTPUT_DIR}${/}my_new_excel.xlsx
    Open workbook    ${EXCEL_FILE}
    Delete Columns    start=A    end=D

Delete Rows
    ${EXCEL_FILE}=    Absolute Path    ${OUTPUT_DIR}${/}my_new_excel.xlsx
    Open workbook    ${EXCEL_FILE}
    Delete Rows    start=2    end=4

Find Empty Row
    ${EXCEL_FILE}=    Absolute Path    ${OUTPUT_DIR}${/}my_new_excel.xlsx
    Open workbook    ${EXCEL_FILE}
    Find Empty Row

Get Active Worksheet
    ${EXCEL_FILE}=    Absolute Path    ${OUTPUT_DIR}${/}my_new_excel.xlsx
    Open workbook    ${EXCEL_FILE}
    Get Active Worksheet

Get Cell Value
    ${EXCEL_FILE}=    Absolute Path    ${OUTPUT_DIR}${/}my_new_excel.xlsx
    Open workbook    ${EXCEL_FILE}
    Get Cell Value    2    2

Get Worksheet Value
    ${EXCEL_FILE}=    Absolute Path    ${OUTPUT_DIR}${/}my_new_excel.xlsx
    Open workbook    ${EXCEL_FILE}
    Get Worksheet Value    2    2

Hide Columns
    ${EXCEL_FILE}=    Absolute Path    ${OUTPUT_DIR}${/}my_new_excel.xlsx
    Open workbook    ${EXCEL_FILE}
    Hide Columns    start_column=A    end_column=

Insert Columns After
    ${EXCEL_FILE}=    Absolute Path    ${OUTPUT_DIR}${/}my_new_excel.xlsx
    Open workbook    ${EXCEL_FILE}
    Insert Columns After    column=B    amount=5

Insert Columns Before
    ${EXCEL_FILE}=    Absolute Path    ${OUTPUT_DIR}${/}my_new_excel.xlsx
    Open workbook    ${EXCEL_FILE}
    Insert Columns Before    column=A    amount=10

Insert Image To Worksheet
    ${EXCEL_FILE}=    Absolute Path    ${OUTPUT_DIR}${/}my_new_excel.xlsx
    ${IMAGE_FILE}=    Absolute Path    src\\excel_files\\assets\\nave.jpg
    Open workbook    ${EXCEL_FILE}
    Insert Image To Worksheet    4    4    ${IMAGE_FILE}

Insert Rows After
    ${EXCEL_FILE}=    Absolute Path    ${OUTPUT_DIR}${/}my_new_excel.xlsx
    Open workbook    ${EXCEL_FILE}
    Insert Rows After    row=2    amount=5

Insert Rows Before
    ${EXCEL_FILE}=    Absolute Path    ${OUTPUT_DIR}${/}my_new_excel.xlsx
    Open workbook    ${EXCEL_FILE}
    Insert Rows Before    row=5    amount=10

List Worksheets
    ${EXCEL_FILE}=    Absolute Path    ${OUTPUT_DIR}${/}my_new_excel.xlsx
    Open workbook    ${EXCEL_FILE}
    List Worksheets

Move Range
    ${EXCEL_FILE}=    Absolute Path    ${OUTPUT_DIR}${/}my_new_excel.xlsx
    Open Workbook    ${EXCEL_FILE}
    # move range 4 rows down
    Move Range    E2:E10    rows=4
    # move range 2 rows down, 2 columns right
    Move Range    E2:E10    rows=2    columns=2

Open Workbook
    ${EXCEL_FILE}=    Absolute Path    src\\excel_files\\assets\\TAXA_EDIT.xlsx
    Open Workbook    ${EXCEL_FILE}
    [Teardown]    Close workbook

Read Worksheet
    ${EXCEL_FILE}=    Absolute Path    src\\excel_files\\assets\\TAXA_EDIT.xlsx
    Open Workbook    ${EXCEL_FILE}
    @{sheets}=    List Worksheets
    FOR    ${sheet}    IN    @{sheets}
        ${count}=    Get row count in the sheet    ${sheet}
        Log    Worksheet '${sheet}' has ${count} rows
    END

Read Worksheet As Table
    ${EXCEL_FILE}=    Absolute Path    src\\excel_files\\assets\\TAXA_EDIT.xlsx

    Open workbook    ${EXCEL_FILE}
    ${worksheet}=    Read worksheet    header=${TRUE}
    ${orders}=    Create table    ${worksheet}
    [Teardown]    Close workbook

Save Workbook
    Create Workbook    ${OUTPUT_DIR}${/}my_new_other_excel.xlsx
    FOR    ${index}    IN RANGE    20
        &{row}=    Create Dictionary
        ...    Row No    ${index}
        ...    Amount    ${index * 25}
        Append Rows to Worksheet    ${row}    header=${TRUE}
    END

    Create Worksheet    Teste1
    Save Workbook

Rename Worksheet
    ${EXCEL_FILE}=    Absolute Path    ${OUTPUT_DIR}${/}my_new_other_excel.xlsx
    Open workbook    ${EXCEL_FILE}
    Rename Worksheet    Sheet    Changed_Sheet
    Save Workbook

Remove Worksheet
    ${EXCEL_FILE}=    Absolute Path    ${OUTPUT_DIR}${/}my_new_other_excel.xlsx
    Open workbook    ${EXCEL_FILE}
    Remove Worksheet    Changed_Sheet
    Save Workbook

Set Active Worksheet
    ${EXCEL_FILE}=    Absolute Path    src\\excel_files\\assets\\TAXA_EDIT.xlsx
    Open workbook    ${EXCEL_FILE}
    Set Active Worksheet    Export

Set Cell Format
    ${EXCEL_FILE}=    Absolute Path    ${OUTPUT_DIR}${/}my_new_excel.xlsx
    Open workbook    ${EXCEL_FILE}
    Set Cell Format    2    B    00.0

Set Cell Formula
    ${EXCEL_FILE}=    Absolute Path    ${OUTPUT_DIR}${/}my_new_excel.xlsx
    Open workbook    ${EXCEL_FILE}
    Set Cell Formula    E2:E10    =B2+5

Set Cell Value
    ${EXCEL_FILE}=    Absolute Path    ${OUTPUT_DIR}${/}my_new_excel.xlsx
    Open workbook    ${EXCEL_FILE}
    Set Cell Values    C1    10000

Set Cell Values
    ${EXCEL_FILE}=    Absolute Path    ${OUTPUT_DIR}${/}my_new_excel.xlsx
    Open workbook    ${EXCEL_FILE}
    Set Cell Values    A1    [1, 2, 3, 4]

Set Styles
    ${EXCEL_FILE}=    Absolute Path    ${OUTPUT_DIR}${/}my_new_excel.xlsx
    Open workbook    ${EXCEL_FILE}
    Set Styles
    ...    range_string=A1:D4
    ...    bold=${True}
    ...    cell_fill=Blue
    ...    align_horizontal=center
    ...    number_format=h:mm AM/PM

Set Worksheet Value
    ${EXCEL_FILE}=    Absolute Path    ${OUTPUT_DIR}${/}my_new_excel.xlsx
    Open workbook    ${EXCEL_FILE}
    Set Worksheet Value    2    2    Teste100

Unhide Columns
    ${EXCEL_FILE}=    Absolute Path    ${OUTPUT_DIR}${/}my_new_excel.xlsx
    Open workbook    ${EXCEL_FILE}
    Unhide Columns    start_column=A    end_column=D

Worksheet Exists
    ${EXCEL_FILE}=    Absolute Path    ${OUTPUT_DIR}${/}my_new_other_excel.xlsx
    Open Workbook    ${EXCEL_FILE}
    Worksheet Exists    Teste1

Rows in the sheet
    ${EXCEL_FILE}=    Absolute Path    src\\excel_files\\assets\\TAXA_EDIT.xlsx
    Open Workbook    ${EXCEL_FILE}
    @{sheets}=    List Worksheets
    FOR    ${sheet}    IN    @{sheets}
        ${count}=    Get row count in the sheet    ${sheet}
        Log    Worksheet '${sheet}' has ${count} rows
    END


*** Keywords ***
Get row count in the sheet
    [Arguments]    ${SHEET_NAME}
    ${sheet}=    Read Worksheet    ${SHEET_NAME}
    ${rows}=    Get Length    ${sheet}
    RETURN    ${rows}
