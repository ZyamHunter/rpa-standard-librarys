*** Settings ***
Library     RPA.FileSystem
Library     Collections


*** Tasks ***
Absolute Path
    ${FILE_PATH}    Absolute Path    src\\fileSystem\\assets\\nave.jpg

Append To Binary File
    ${data}    Evaluate    b'Hello, binary data!'
    ${data_second}    Evaluate    b'Hello, new data!'
    Create Binary File    ${OUTPUT_DIR}${/}new_binary_file.txt    ${data}    ${True}
    Wait Until Created    ${OUTPUT_DIR}${/}new_binary_file.txt
    Append To Binary File    ${OUTPUT_DIR}${/}new_binary_file.txt    ${data_second}

Append To File
    Create file    ${OUTPUT_DIR}${/}file_to_append.txt    content=File to file_to_append
    ...    overwrite=${True}
    Wait Until Created    ${OUTPUT_DIR}${/}file_to_append.txt
    Append To File    ${OUTPUT_DIR}${/}file_to_append.txt    content=Informação nova

Change File Extension
    Create file    ${OUTPUT_DIR}${/}file_to_change_extension.txt    content=File to change
    ...    overwrite=${True}
    Wait Until Created    ${OUTPUT_DIR}${/}file_to_change_extension.txt
    Change File Extension    ${OUTPUT_DIR}${/}file_to_change_extension.txt    .html

Create Binary File
    ${data}    Evaluate    b'Hello, binary data!'
    Create Binary File    ${OUTPUT_DIR}${/}binary_file.txt    ${data}    ${True}

Create Directory
    Create directory    ${OUTPUT_DIR}${/}build
    Create directory    ${OUTPUT_DIR}${/}test
    Create directory    ${OUTPUT_DIR}${/}past
    Create directory    ${OUTPUT_DIR}${/}folder
    Create directory    ${OUTPUT_DIR}${/}robot
    Create directory    ${OUTPUT_DIR}${/}files
    Create directory    ${OUTPUT_DIR}${/}output
    Create directory    ${OUTPUT_DIR}${/}temp
    Create directory    output
    Create directory    temp

    Wait Until Created    output
    Wait Until Created    temp
    Wait Until Created    ${OUTPUT_DIR}${/}build

Copy Directory
    Copy Directory    output    aab

Copy File
    Read File    ${OUTPUT_DIR}${/}file_to_append.txt
    Copy File    ${OUTPUT_DIR}${/}file_to_append.txt    ${OUTPUT_DIR}${/}build/file_to_append.txt

Copy Files
    ${files}    Find files    **/*.txt
    FOR    ${file}    IN    @{files}
        Read file    ${file}
    END
    Copy Files    ${files}    ${OUTPUT_DIR}${/}past

Create File
    Create file    ${OUTPUT_DIR}${/}newfile.txt    content=Teste criando arquivo
    ...    overwrite=${True}
    Create file    ${OUTPUT_DIR}${/}file_to_read.txt    content=Teste criando arquivo para leitura posterior
    ...    overwrite=${True}

    Create file    ${OUTPUT_DIR}${/}empty_file.txt    content=${None}
    Create file    ${OUTPUT_DIR}${/}test1.txt    content=Teste1
    Create file    ${OUTPUT_DIR}${/}test2.txt    content=Teste2
    Create file    ${OUTPUT_DIR}${/}test3.txt    content=Teste3
    Create file    ${OUTPUT_DIR}${/}file_to_remove.txt    content=file to remove

Does Directory Exist
    ${PATH}    Absolute Path    src\\fileSystem\\tests
    ${RESULT}    Does Directory Exist    ${PATH}

Does Directory Not Exist
    ${PATH}    Absolute Path    src\\fileSystem\\logs
    ${RESULT}    Does Directory Not Exist    ${PATH}

Does File Exist
    ${PATH}    Absolute Path    src\\fileSystem\\assets\\JOSIAS.docx
    ${RESULT}    Does File Exist    ${PATH}

Does File Not Exist
    ${PATH}    Absolute Path    src\\fileSystem\\assets\\log.html
    ${RESULT}    Does File Not Exist    ${PATH}

Empty Directory
    ${PATH}    Absolute Path    src\\fileSystem\\empty
    ${RESULT}    Empty Directory    ${PATH}

    ${OTHER_PATH}    Absolute Path    src\\fileSystem\\assets
    ${OTHER_RESULT}    Empty Directory    ${OTHER_PATH}

Find Files
    ${files}    Find files    **/*.html
    FOR    ${file}    IN    @{files}
        Read file    ${file}
        # Log To Console    ${file}
    END

Get File Creation Date
    ${PATH}    Absolute Path    ${OUTPUT_DIR}${/}output.xml
    ${RESULT}    Get File Creation Date    ${PATH}

Get File Extension
    ${PATH}    Absolute Path    src\\fileSystem\\assets\\JOSIAS.docx
    ${RESULT}    Get File Extension    ${PATH}

Get File Modified Date
    ${PATH}    Absolute Path    ${OUTPUT_DIR}${/}output.xml
    ${RESULT}    Get File Modified Date    ${PATH}

Get File Name
    ${PATH}    Absolute Path    src\\fileSystem\\assets\\JOSIAS.docx
    ${RESULT}    Get File Name    ${PATH}

Get File Owner
    ${PATH}    Absolute Path    ${OUTPUT_DIR}${/}output.xml
    ${RESULT}    Get File Owner    ${PATH}

Get File Size
    ${PATH}    Absolute Path    ${OUTPUT_DIR}${/}output.xml
    ${RESULT}    Get File Size    ${PATH}

Get File Stem
    ${PATH}    Absolute Path    src\\fileSystem\\assets\\JOSIAS.docx
    ${RESULT}    Get File Stem    ${PATH}

Is Directory Empty
    ${PATH}    Absolute Path    src\\fileSystem\\empty
    ${RESULT}    Is Directory Empty    ${PATH}

Is Directory Not Empty
    ${PATH}    Absolute Path    src\\fileSystem\\assets
    ${RESULT}    Is Directory Not Empty    ${PATH}

Is File Empty
    ${PATH}    Absolute Path    ${OUTPUT_DIR}${/}empty_file.txt
    ${RESULT}    Is File Empty    ${PATH}

    ${OTHER_PATH}    Absolute Path    ${OUTPUT_DIR}${/}newfile.txt
    ${OTHER_RESULT}    Is File Empty    ${OTHER_PATH}

Is File Not Empty
    ${OTHER_PATH}    Absolute Path    ${OUTPUT_DIR}${/}newfile.txt
    ${OTHER_RESULT}    Is File Not Empty    ${OTHER_PATH}

    ${PATH}    Absolute Path    ${OUTPUT_DIR}${/}empty_file.txt
    ${RESULT}    Is File Not Empty    ${PATH}

Join Path
    Join Path    ${OUTPUT_DIR}${/}output.xml    folder

List Directories In Directory
    ${OTHER_PATH}    Absolute Path    src

    ${directories}    List directories in directory    ${OTHER_PATH}
    FOR    ${path}    IN    @{directories}
        Log    ${path}
    END

List Files In Directory
    ${files}    List files in directory    ${OUTPUT_DIR}
    FOR    ${file}    IN    @{files}
        Log    ${file}
    END

Log Directory Tree
    Log directory tree

# Move a directory
#    Move directory    output    temp    ${True}

Move File
    Move file    ${OUTPUT_DIR}${/}test1.txt    ${OUTPUT_DIR}${/}files/test1.txt

Move Files
    @{files}    Set Variable    ${None}
    Append To List    ${files}    ${OUTPUT_DIR}${/}test2.txt
    Append To List    ${files}    ${OUTPUT_DIR}${/}test3.txt

    Move files    sources=${files}    destination=${OUTPUT_DIR}${/}past

Normalize Path
    ${normalized_path}    Normalize path    ${OUTPUT_DIR}

Read Binary File
    Read Binary File    ${OUTPUT_DIR}${/}binary_file.txt

Read picture as binary
    ${pictures}    Find files    **/*.png
    FOR    ${picture}    IN    @{pictures}
        Read binary file    ${picture}
    END

Read File
    ${PATH}    Absolute Path    ${OUTPUT_DIR}${/}file_to_read.txt
    ${CONTENT}    Read File    ${PATH}

Delete a directory
    Remove directory    ${OUTPUT_DIR}${/}output    recursive=${True}
    Remove directory    ${OUTPUT_DIR}${/}temp    recursive=${True}

Remove File
    ${files}    List files in directory    src\\fileSystem\\assets
    FOR    ${file}    IN    @{FILES}
        IF    ${file.size} > 10**8    Remove file    ${file}
    END

Remove Files
    ${files}    List files in directory    src\\fileSystem\\assets
    FOR    ${file}    IN    @{FILES}
        IF    ${file.size} > 10**8    Remove Files    ${file}
    END

Run Keyword If File Exists
    ${PATH}    Absolute Path    ${OUTPUT_DIR}${/}file_to_read.txt
    ${OTHER_PATH}    Absolute Path    ${OUTPUT_DIR}${/}test1.txt

    Run Keyword If File Exists    ${PATH}    Log To Console    Arquivo existe
    Run Keyword If File Exists    ${OTHER_PATH}    Log To Console    Arquivo não existe

Touch File
    Read File    ${OUTPUT_DIR}${/}file_to_read.txt
    Touch File    ${OUTPUT_DIR}${/}file_to_read.txt

Wait Until Created
    Create File    ${OUTPUT_DIR}${/}file_generated.txt
    Wait Until Created    ${OUTPUT_DIR}${/}file_generated.txt

# Wait Until Modified
#    Create Directory    ${OUTPUT_DIR}${/}Modified9
#    Wait Until Modified    ${OUTPUT_DIR}${/}    10

Wait Until Removed
    ${FILE}    Absolute Path    ${OUTPUT_DIR}${/}file_to_remove.txt
    Remove file    ${FILE}
    Remove Directory    aab
    Remove Directory    output
    Remove Directory    temp
    Wait Until Removed    ${FILE}
