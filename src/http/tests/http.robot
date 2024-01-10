*** Settings ***
Documentation       Interact directly with web APIs.

Library             RPA.HTTP
Library             RPA.FileSystem


*** Tasks ***
Check Vulnerabilities
    [Documentation]    Check for possible vulnerabilities in the installed runtime environment packages.
    ...    Currently will check only for OpenSSL version and outputs warning message on any discovered vulnerability.

    ${results}    Check Vulnerabilities
    FOR    ${result}    IN    @{results}
        Log To Console    TYPE: ${result}[type]
        Log To Console    VULNERABLE: ${result}[vulnerable]
        Log To Console    MESSAGE: ${result}[message]
    END

Create Client Cert Session
    ${KEY_PATH}    Absolute Path    ${OUTPUT_DIR}    # substituir pelo caminho do certificado
    Create Client Cert Session
    ...    alias=cert_session
    ...    url=https://api.thecatapi.com/v1/breeds
    ...    client_certs=${KEY_PATH}
    ...    timeout=10

Create Custom Session
    ${CREDENTIALS}    Create Dictionary    user=tester1    password=passTester1
    Create Custom Session
    ...    alias=dog_api
    ...    url=https://api.thecatapi.com/v1/breeds
    ...    auth=${CREDENTIALS}    # Coloque aqui as credenciais
    ...    timeout=10

Create Digest Session
    ${CREDENTIALS}    Create Dictionary    user=tester1    password=passTester1
    Create Digest Session
    ...    alias=digest_session
    ...    url=https://api.thecatapi.com/v1/breeds
    ...    auth=${CREDENTIALS}    # Coloque aqui as credenciais
    ...    timeout=10

Create Ntlm Session
    ${CREDENTIALS}    Create List    https://domain.exmaple    tester1    passTester1
    Create Ntlm Session
    ...    alias=ntlm_session
    ...    url=https://api.thecatapi.com/v1/breeds
    ...    auth=${CREDENTIALS}

Create Session
    Create Session
    ...    alias=standard_session
    ...    url=https://api.thecatapi.com/v1/breeds

DELETE
    ${DELETE_RESPONSE}    DELETE    url=https://jsonplaceholder.typicode.com/posts/1    expected_status=200

Delete All Sessions
    Delete All Sessions

DELETE On Session
    Create Session
    ...    alias=json_placeholder
    ...    url=https://jsonplaceholder.typicode.com

    DELETE On Session    alias=json_placeholder    url=/posts/1    expected_status=200

Download
    Download
    ...    url=https://jsonplaceholder.typicode.com/posts/1
    ...    target_file=${OUTPUT_DIR}${/}downloads

GET
    ${GET_RESPONSE}    GET    url=https://jsonplaceholder.typicode.com/posts/1    expected_status=200

Get Current Session Alias
    ${SESSION}    Get Current Session Alias

Get File For Streaming Upload
    ${FILE_PATH}    Absolute Path    src/http/assets/users.json
    Get File For Streaming Upload    ${FILE_PATH}

GET On Session
    Create Session
    ...    alias=json_placeholder
    ...    url=https://jsonplaceholder.typicode.com

    GET On Session    alias=json_placeholder    url=/posts/1    expected_status=200

HEAD
    ${HEAD_RESPONSE}    HEAD    url=https://jsonplaceholder.typicode.com/posts/1    expected_status=200

HEAD On Session
    Create Session
    ...    alias=json_placeholder
    ...    url=https://jsonplaceholder.typicode.com

    HEAD On Session    alias=json_placeholder    url=/posts/1    expected_status=200

# Http Get
#    Http Get
#    ...    url=https://upload.wikimedia.org/wikipedia/commons/a/aa/Oi_logo_2022.png
#    ...    target_file=${OUTPUT_DIR}${/}imag.png

OPTIONS
    ${OPTIONS_RESPONSE}    OPTIONS    url=https://jsonplaceholder.typicode.com/posts/1    expected_status=204

OPTIONS On Session
    Create Session
    ...    alias=json_placeholder
    ...    url=https://jsonplaceholder.typicode.com

    OPTIONS On Session    alias=json_placeholder    url=/posts/1    expected_status=204

PATCH
    ${BODY}    Create Dictionary
    ...    title=teste robot
    ...    id=1
    ...    userid=1
    ...    body=teste body robot

    ${PATCH_RESPONSE}    PATCH
    ...    url=https://jsonplaceholder.typicode.com/posts/1
    ...    json=${BODY}
    ...    expected_status=200

PATCH On Session
    ${BODY}    Create Dictionary
    ...    title=teste robot
    ...    id=1
    ...    userid=1
    ...    body=teste body robot

    Create Session
    ...    alias=json_placeholder
    ...    url=https://jsonplaceholder.typicode.com

    PATCH On Session    alias=json_placeholder    url=/posts/1    json=${BODY}    expected_status=200

POST
    ${BODY}    Create Dictionary
    ...    title=teste robot
    ...    userid=1
    ...    body=teste body robot

    ${POST_RESPONSE}    POST    url=https://jsonplaceholder.typicode.com/posts    json=${BODY}    expected_status=201

POST On Session
    ${BODY}    Create Dictionary
    ...    title=teste robot
    ...    userid=1
    ...    body=teste body robot

    Create Session
    ...    alias=json_placeholder
    ...    url=https://jsonplaceholder.typicode.com

    POST On Session    alias=json_placeholder    url=/posts    json=${BODY}    expected_status=201

PUT
    ${BODY}    Create Dictionary
    ...    title=teste robot
    ...    id=1
    ...    userid=1
    ...    body=teste body robot

    ${PUT_RESPONSE}    PUT    url=https://jsonplaceholder.typicode.com/posts/1    json=${BODY}    expected_status=200

PUT On Session
    ${BODY}    Create Dictionary
    ...    title=teste robot
    ...    id=1
    ...    userid=1
    ...    body=teste body robot

    Create Session
    ...    alias=json_placeholder
    ...    url=https://jsonplaceholder.typicode.com

    PUT On Session    alias=json_placeholder    url=/posts/1    json=${BODY}    expected_status=200

Request Should Be Successful
    ${GET_RESPONSE}    GET    url=https://jsonplaceholder.typicode.com/posts/1    expected_status=200
    Request Should Be Successful    ${GET_RESPONSE}

Session Exists
    Create Session
    ...    alias=standard_session
    ...    url=https://api.thecatapi.com/v1/breeds

    Session Exists    standard_session

Status Should Be
    ${GET_RESPONSE}    GET    url=https://jsonplaceholder.typicode.com/posts/1    expected_status=200
    Status Should Be    expected_status=200    response=${GET_RESPONSE}

Update Session
    ${HEADERS}    Create Dictionary    Content-type=application/json; charset=UTF-8

    ${COOKIES}    Create Dictionary    access_token=233kkdhkkdnni

    Update Session
    ...    alias=standard_session
    ...    headers=${HEADERS}
    ...    cookies=${COOKIES}
