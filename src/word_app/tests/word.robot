*** Settings ***
Library     RPA.Word.Application
Library     RPA.FileSystem


*** Tasks ***
Criar novo documento word
    Open Application    visible=${False}    display_alerts=${False}
    Create New Document
    Save Document As    filename=${OUTPUT_DIR}${/}DOCUMENT_CREATED    fileformat=DOCX
    Close Document    save_changes=${False}

Set Footer
    Open Application    visible=${False}    display_alerts=${False}
    Create New Document

    Set Footer    FOOTER FOR RPA WORD APPLICATION
    Save Document As    filename=${OUTPUT_DIR}${/}SET_FOOTER_WORD    fileformat=DOCX
    Close Document    save_changes=${False}

Set Header
    Open Application    visible=${False}    display_alerts=${False}
    Create New Document

    Set Header    HEADER FOR RPA WORD APPLICATION
    Save Document As    filename=${OUTPUT_DIR}${/}SET_HEADER_WORD    fileformat=DOCX
    Close Document    save_changes=${False}

Abrir aplicativo word
    Open Application    visible=${False}    display_alerts=${False}
    Create New Document
    Close Document    save_changes=${False}

Fechar aplicativo word
    Open Application    visible=${False}    display_alerts=${False}
    Create New Document
    Set Header    HEADER FOR RPA WORD APPLICATION
    Set Footer    FOOTER FOR RPA WORD APPLICATION
    Save Document As    ${OUTPUT_DIR}${/}DOC_FOR_QUIT    DOCX

    Quit Application    save_changes=${False}

Fechar documento
    Open Application    visible=${False}    display_alerts=${False}

    ${DOCX_PATH}    Absolute Path    src\\word_app\\assets\\JOSIAS.docx
    Open File    ${DOCX_PATH}

    Close Document    save_changes=${False}

Abrir arquivo word
    ${DOCX_PATH}    Absolute Path    src\\word_app\\assets\\JOSIAS.docx
    Open File    ${DOCX_PATH}
    Close Document    save_changes=${False}

Export To Pdf
    ${DOCX_PATH}    Absolute Path    src\\word_app\\assets\\JOSIAS.docx
    Open File    ${DOCX_PATH}
    Export To Pdf    ${OUTPUT_DIR}${/}JOSIAS_PDF
    Close Document    save_changes=${False}

Get All Texts
    ${DOCX_PATH}    Absolute Path    src\\word_app\\assets\\JOSIAS.docx
    Open File    ${DOCX_PATH}
    ${TEXTS}    Get All Texts
    Close Document    save_changes=${False}

Replace Text
    Open Application    visible=${False}    display_alerts=${False}
    ${DOCX_PATH}    Absolute Path    src\\word_app\\assets\\EDIT_DOC.docx
    Open File    ${DOCX_PATH}

    Replace Text    editado    : REPLACE TEXT FOR RPA WORD APPLICATION
    Save Document As    filename=${OUTPUT_DIR}${/}REPLACE_WORD_TEXT    fileformat=DOCX
    Close Document    save_changes=${False}

Write Text
    ${DOCX_PATH}    Absolute Path    src\\word_app\\assets\\JOSIAS.docx
    Open File    ${DOCX_PATH}

    Write Text    INTRODUÇÃO
    Close Document    save_changes=${False}

Save Document
    ${DOCX_PATH}    Absolute Path    src\\word_app\\assets\\JOSIAS.docx
    Open File    ${DOCX_PATH}
    # Save Document
    Close Document    save_changes=${False}

Save Document As
    ${DOCX_PATH}    Absolute Path    src\\word_app\\assets\\JOSIAS.docx
    Open File    ${DOCX_PATH}

    Save Document As    filename=${OUTPUT_DIR}${/}JOSIAS_WORD_SAVE    fileformat=PDF
    Save Document As    filename=${OUTPUT_DIR}${/}JOSIAS_WORD_SAVE    fileformat=docx
    Close Document    save_changes=${False}
