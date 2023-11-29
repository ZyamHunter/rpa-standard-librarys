*** Settings ***
Library     RPA.PDF
Library     RPA.FileSystem
Library     String
Library     Collections
Library     Screenshot


*** Tasks ***
Extrair dados da primeira página do pdf
    ${PDF_PATH}=    Absolute Path    src\\pdf\\assets\\report-of-tests.pdf

    ${text}=    Get Text From PDF    ${PDF_PATH}
    ${lines}=    Get Lines Matching Regexp    ${text}[${1}]    .+pain.+
    Log    ${lines}

    Close Pdf

Encontrar texto no pdf de forma simples
    ${PDF_PATH}=    Absolute Path    src\\pdf\\assets\\report-of-tests.pdf

    Open Pdf    ${PDF_PATH}
    ${matches}=    Find Text    Login
    Log List    ${matches}

    Close Pdf

Validar outro pdf de forma diferente
    [Documentation]    Esse caso faz mais sentido quando vc quer validar um outro pdf

    ${PDF_PATH}=    Absolute Path    src\\pdf\\assets\\PDF Form.pdf

    Switch To Pdf    ${PDF_PATH}
    ${fields}=    Get Input Fields    encoding=utf-16
    Set Field Value    field_name=摡牤獥㝳慛摤彲楬敮崱    value=Marcos
    Set Field Value    field_name=摡牤獥㝳慛摤彲楬敮崲    value=Marcos
    Save Field Values    output_path=${OUTPUT_DIR}${/}completed-form.pdf
    ...    use_appearances_writer=${True}
    # Salvando segundo pdf para uso em outros casos de teste
    Save Field Values    output_path=${OUTPUT_DIR}${/}robot.pdf
    ...    use_appearances_writer=${True}

    Set Screenshot Directory    ${OUTPUTDIR}
    Take Screenshot    approved
    Take Screenshot    approved

    Close All Pdfs

Adicionar arquivos ao pdf
    ${files}=    Create List
    ...    ${OUTPUT_DIR}${/}completed-form.pdf
    ...    ${OUTPUT_DIR}${/}approved_1.jpg:align=center
    ...    ${OUTPUT_DIR}${/}robot.pdf:1
    ...    ${OUTPUT_DIR}${/}approved_1.jpg:x=0,y=0
    ...    ${OUTPUT_DIR}${/}robot.pdf:2-10,15
    ...    ${OUTPUT_DIR}${/}approved_1.jpg
    ...    ${OUTPUT_DIR}${/}approved_2.jpg:rotate=-90,orientation=L
    ...    ${OUTPUT_DIR}${/}approved_2.jpg:format=Letter
    Add Files To PDF    ${files}    ${OUTPUT_DIR}${/}newdoc.pdf

Mesclar pdf
    ${files}=    Create List
    ...    ${OUTPUT_DIR}${/}completed-form.pdf
    ...    ${OUTPUT_DIR}${/}robot.pdf:1
    ...    ${OUTPUT_DIR}${/}robot.pdf:2-10,15
    Add Files To Pdf    ${files}    ${OUTPUT_DIR}${/}merged-doc.pdf

Split pdf
    ${files}=    Create List
    ...    ${OUTPUT_DIR}${/}completed-form.pdf:2-10,15
    Add Files To Pdf    ${files}    ${OUTPUT_DIR}${/}split-doc.pdf

Adicionar imagem a um pdf
    ${PDF_PATH}=    Absolute Path    src\\pdf\\assets\\report-of-tests.pdf

    Add Watermark Image To PDF
    ...    image_path=${OUTPUT_DIR}${/}approved_1.jpg
    ...    source_path=${PDF_PATH}
    ...    output_path=${OUTPUT_DIR}${/}output.pdf

Converter pdf
    Convert    source_path=${OUTPUT_DIR}${/}output.pdf

Encriptar pdf com senha
    Encrypt PDF
    ...    source_path=${OUTPUT_DIR}${/}output.pdf
    ...    output_path=${OUTPUT_DIR}${/}sample_encrypted.pdf
    ...    user_pwd=complex_password_here
    ...    owner_pwd=different_complex_password_here
    ...    use_128bit=${TRUE}

Decriptar pdf com senha
    ${success}=    Decrypt PDF
    ...    source_path=${OUTPUT_DIR}${/}sample_encrypted.pdf
    ...    output_path=${OUTPUT_DIR}${/}sample_decrypted.pdf
    ...    password=complex_password_here

XML para pdf
    ${xml}=    Dump PDF as XML    ${OUTPUT_DIR}${/}output.pdf

Recortar páginas de determinado pdf em um novo pdf
    ${pages}=    Extract Pages From PDF
    ...    source_path=${OUTPUT_DIR}${/}output.pdf
    ...    output_path=${OUTPUT_DIR}${/}pages.pdf
    ...    pages=5

Recuperar todas as figuras do pdf
    &{figures}=    Get All Figures    ${OUTPUT_DIR}${/}output.pdf

Número de páginas de um pdf
    ${page_count}=    Get Number Of Pages    ${OUTPUT_DIR}${/}output.pdf

Recuperar metadados de um pdf
    ${metadata}=    Get PDF Info    ${OUTPUT_DIR}${/}output.pdf

Create PDF from HTML
    HTML to PDF    ${OUTPUT_DIR}${/}report.html    ${OUTPUT_DIR}${/}report-html.pdf

Multi Page PDF
    @{pages}=    Create List    ${OUTPUT_DIR}${/}report.html    ${OUTPUT_DIR}${/}log.html
    HTML To PDF    ${pages}    ${OUTPUT_DIR}${/}multi-page-html.pdf
    ...    margin=10
    ...    working_directory=logs

Is PDF encrypted
    ${is_encrypted}=    Is PDF Encrypted    ${OUTPUT_DIR}${/}sample_encrypted.pdf
    ${is_decrypted}=    Is PDF Encrypted    ${OUTPUT_DIR}${/}sample_decrypted.pdf

Girar pdf
    Rotate Page
    ...    source_path=${OUTPUT_DIR}${/}sample_decrypted.pdf
    ...    output_path=${OUTPUT_DIR}${/}rotate.pdf
    ...    angle=90
    ...    pages=5

# Salvar figura do pdf em imagem
#    Close All Pdfs
#    Open Pdf    ${OUTPUT_DIR}${/}output.pdf
#    ${FIGURES}=    Get All Figures
#
#    ${image_file_path}=    Save figure as image
#    ...    figure=${FIGURES}
#    ...    images_folder=${OUTPUT_DIR}${/}figures
#    ...    file_prefix=figure_pdf

Figures to Images
    ${figures}=    Get All Figures    ${OUTPUT_DIR}${/}output.pdf

    ${image_filenames}=    Save figures as images
    ...    source_path=${OUTPUT_DIR}${/}output.pdf
    ...    images_folder=${OUTPUT_DIR}${/}
    ...    pages=${4}
    ...    file_prefix=all_figures_to_images

Salvar pdf
    Save PDF    ${OUTPUT_DIR}${/}output.pdf

Abrir pdf
    Close All Pdfs
    Open Pdf    ${OUTPUT_DIR}${/}output.pdf

Recuperar texto do pdf
    Close All Pdfs
    ${PDF_PATH}=    Absolute Path    src\\pdf\\assets\\report-of-tests.pdf

    ${text}=    Get Text From PDF    ${PDF_PATH}

Fechar pdf atual aberto
    Close Pdf

Fechar todos os pdfs abertos
    Close All Pdfs

Encontrar texto no pdf
    ${PDF_PATH}=    Absolute Path    src\\pdf\\assets\\report-of-tests.pdf

    Open Pdf    ${PDF_PATH}
    ${text}=    Find Text    Login

Ancorar pdf
    Close All Pdfs
    Open Pdf    ${OUTPUT_DIR}${/}output.pdf
    ${success}=    Set Anchor To Element    Login

Setar padrões de conversão
    Set Convert Settings    line_margin=0.00000001    word_margin=0.00002    char_margin=1.0    boxes_flow=0.2
    ${texts}=    Get Text From PDF    ${OUTPUT_DIR}${/}output.pdf

Create PDF from HTML template
    ${TEMPLATE}=    Absolute Path    src\\pdf\\assets\\base.html
    ${PDF}=    Set Variable    ${OUTPUT_DIR}${/}report.pdf
    &{DATA}=    Create Dictionary
    ...    name=Robot Generated
    ...    email=robot@domain.com
    ...    zip=00100
    ...    items=Item 1, Item 2
    Template HTML to PDF
    ...    template=${TEMPLATE}
    ...    output_path=${OUTPUT_DIR}${/}${PDF}
    ...    variables=${DATA}
