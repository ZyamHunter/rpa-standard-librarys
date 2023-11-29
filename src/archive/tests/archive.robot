*** Settings ***
Library     RPA.Archive
Library     RPA.FileSystem


*** Tasks ***
Add To Archive
    Add To Archive    src\\archive\\assets\\IMAGE.zip    src\\archive\\assets\\OTHER_IMAGE.zip

Archive Folder With Tar
    Archive Folder With ZIP    src\\archive\\assets    ${OUTPUT_DIR}${/}FILES.tar    recursive=True
    Archive Folder With ZIP    src\\archive\\assets    FILES.tar    recursive=True
    &{info}    Get Archive Info    ${OUTPUT_DIR}${/}FILES.tar

Extract File From Archive
    ${RESULT}    Extract File From Archive    IMAGE.zip    FILES.tar

Extract Archive
    ${RESULT}    Extract Archive    archive_name=IMAGE.zip

Get Archive Info
    &{info}    Get Archive Info    src\\archive\\assets\\TAXA.xlsx

List Archive
    @{files}    List Archive    src\\archive\\assets\\TAXA.xlsx
    FOR    ${file}    IN    ${files}
        Log    ${file}
    END

Creating a ZIP archive
    Archive Folder With ZIP    src\\archive\\assets    ${OUTPUT_DIR}${/}FILES.zip    recursive=True
    &{info}    Get Archive Info    ${OUTPUT_DIR}${/}FILES.zip
