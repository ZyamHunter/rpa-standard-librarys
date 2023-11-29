*** Settings ***
Library             RPA.Excel.Application
Library             RPA.FileSystem

Task Setup          Open Application
Task Teardown       Quit Application


*** Tasks ***
Add New Sheet
    Add New Sheet    sheetname=CREATED_SHEET    create_workbook=${True}

Add New Workbook
    Add New Workbook

Close Document
    Add New Sheet    sheetname=CREATED_SHEET    create_workbook=${True}
    Add New Workbook
    Close Document

Export As Pdf
    ${EXCEL_FILE}    Absolute Path    src\\excel_app\\assets\\TAXA.xlsx

    Add New Sheet    sheetname=EXPORTED_SHEET_PDF    create_workbook=${True}
    Add New Workbook
    Export As Pdf    ${OUTPUT_DIR}${/}EXPORTED_SHEET_PDF.pdf    ${EXCEL_FILE}
    Close Document

Find First Available Cell
    ${EXCEL_FILE}    Absolute Path    src\\excel_app\\assets\\TAXA_EDIT.xlsx
    Open Workbook    ${EXCEL_FILE}
    ${RESULT}    Find First Available Cell    worksheet=Export    row=2    column=1
    Close Document

    # other example
    ${EXCEL_FILE}    Absolute Path    src\\excel_app\\assets\\TAXA_EDIT.xlsx
    Open Workbook    ${EXCEL_FILE}
    ${RESULT}    Find First Available Cell    worksheet=${None}    row=2    column=1
    Close Document

Find First Available Row
    ${EXCEL_FILE}    Absolute Path    src\\excel_app\\assets\\TAXA_EDIT.xlsx
    Open Workbook    ${EXCEL_FILE}
    ${RESULT}    Find First Available Row    worksheet=Export    row=2    column=1
    Close Document
    # other example
    ${EXCEL_FILE}    Absolute Path    src\\excel_app\\assets\\TAXA_EDIT.xlsx
    Open Workbook    ${EXCEL_FILE}
    ${RESULT}    Find First Available Row    worksheet=${None}    row=2    column=1
    Close Document

Open Application
    Open Application

Open Workbook
    ${EXCEL_FILE}    Absolute Path    src\\excel_app\\assets\\TAXA_EDIT.xlsx
    Open Workbook    ${EXCEL_FILE}
    Close Document

Quit Application
    Open Application
    Quit Application

Read From Cells
    ${EXCEL_FILE}    Absolute Path    src\\excel_app\\assets\\TAXA_EDIT.xlsx
    Open Workbook    ${EXCEL_FILE}
    Read From Cells    worksheet=Export    row=2    column=3
    Close Document
    # other example
    ${EXCEL_FILE}    Absolute Path    src\\excel_app\\assets\\TAXA_EDIT.xlsx
    Open Workbook    ${EXCEL_FILE}
    Read From Cells    worksheet=${None}    row=2    column=3
    Close Document

# Run Macro
    # ${EXCEL_FILE}    Absolute Path    src\\excel_app\\assets\\TAXA_EDIT.xlsx
    # Open Workbook    ${EXCEL_FILE}
    # Run Macro    Sheet1.CommandButton1_Click
    # Close Document

Save Excel
    ${EXCEL_FILE}    Absolute Path    src\\excel_app\\assets\\TAXA_EDIT.xlsx
    Open Workbook    ${EXCEL_FILE}
    Save Excel
    Close Document

Save Excel As
    ${EXCEL_FILE}    Absolute Path    src\\excel_app\\assets\\TAXA_EDIT.xlsx
    Open Workbook    ${EXCEL_FILE}
    Save Excel
    Save Excel As    filename=${OUTPUT_DIR}${/}SAVED_AS_EXCEL.xlsx
    Close Document

    ${EXCEL_FILE}    Absolute Path    src\\excel_app\\assets\\TAXA_EDIT.xlsx
    Open Workbook    ${EXCEL_FILE}
    Save Excel
    Save Excel As    filename=${OUTPUT_DIR}${/}SAVED_AS_EXCEL.csv
    Close Document

    ${EXCEL_FILE}    Absolute Path    src\\excel_app\\assets\\TAXA_EDIT.xlsx
    Open Workbook    ${EXCEL_FILE}
    Save Excel
    Save Excel As    filename=${OUTPUT_DIR}${/}SAVED_AS_EXCEL.xml
    Close Document

Set Active Worksheet
    ${EXCEL_FILE}    Absolute Path    src\\excel_app\\assets\\TAXA_EDIT.xlsx
    Open Workbook    ${EXCEL_FILE}
    Set Active Worksheet    sheetname=Export
    Close Document
    # another example
    ${EXCEL_FILE}    Absolute Path    src\\excel_app\\assets\\TAXA_EDIT.xlsx
    Open Workbook    ${EXCEL_FILE}
    Set Active Worksheet    sheetnumber=1
    Close Document

Write To Cells
    ${EXCEL_FILE}    Absolute Path    src\\excel_app\\assets\\TAXA_EDIT.xlsx
    Open Workbook    ${EXCEL_FILE}
    Write To Cells
    ...    worksheet=Export
    ...    row=2
    ...    column=3
    ...    value=6
    Close Document

Manipulate Excel application
    ${EXCEL_FILE}    Absolute Path    src\\excel_app\\assets\\TAXA_EDIT.xlsx
    Open Workbook    ${EXCEL_FILE}
    Set Active Worksheet    sheetname=Export
    Write To Cells    row=1
    ...    column=1
    ...    value=11/11
    Save Excel
