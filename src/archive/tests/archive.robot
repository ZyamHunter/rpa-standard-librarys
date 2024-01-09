*** Settings ***
Library     RPA.Archive
Library     RPA.FileSystem
Library    ../../Helpers/Absolute_path.py


*** Tasks ***
Add To Archive
    ${PATH}    Get Absolute Path    src\\archive\\assets\\IMAGE.zip
    Add To Archive    ${PATH}    src\\archive\\assets\\OTHER_IMAGE.zip

Archive Folder With Tar
    ${PATH}    Get Absolute Path    src\\archive\\assets

    Archive Folder With ZIP    ${PATH}    ${OUTPUT_DIR}${/}FILES.tar    recursive=True
    Archive Folder With ZIP    ${PATH}    FILES.tar    recursive=True
    &{info}    Get Archive Info    ${OUTPUT_DIR}${/}FILES.tar

Extract File From Archive
    ${RESULT}    Extract File From Archive    IMAGE.zip    FILES.tar

Extract Archive
    ${RESULT}    Extract Archive    archive_name=IMAGE.zip

Get Archive Info
    ${PATH}    Get Absolute Path     src\\archive\\assets\\TAXA.xlsx

    &{info}    Get Archive Info     ${PATH}

List Archive
    ${PATH}    Get Absolute Path     src\\archive\\assets\\TAXA.xlsx

    @{files}    List Archive    ${PATH}
    FOR    ${file}    IN    ${files}
        Log    ${file}
    END

Creating a ZIP archive
    ${PATH}    Get Absolute Path     src\\archive\\assets

    Archive Folder With ZIP    ${PATH}    ${OUTPUT_DIR}${/}FILES.zip    recursive=True
    &{info}    Get Archive Info    ${OUTPUT_DIR}${/}FILES.zip
