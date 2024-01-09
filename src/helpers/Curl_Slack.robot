*** Settings ***
Library     ../Helpers/Absolute_path.py
Library     ../Helpers/Get_Tests_Status.py
Library     ../Helpers/Get_Envs.py
Library     RequestsLibrary
Library     Collections


*** Tasks ***
Send Curl to Slack
    ${reportBank}    Set Variable    bank\\output.xml
    ${pathBank}    Get Absolute Path    ${reportBank}
    ${msgBank}    Get Test Status    ${pathBank}    banco

    ${reportProvider}    Set Variable    provider\\output.xml
    ${pathProvider}    Get Absolute Path    ${reportProvider}
    ${msgProvider}    Get Test Status    ${pathProvider}    fornecedor

    ${report}    Set Variable    mooz\\output.xml
    ${path}    Get Absolute Path    ${report}
    ${msg}    Get Test Status    ${path}    mooz

    ${result}    Set Variable    ${msgBank}\n ${msgProvider}\n ${msg}
    Curl    ${result}

*** Keywords ***
Curl
    [Arguments]    ${msg}

    ${curl_slack}    Get Enviroment Variables
    ${endpoint}    Set Variable    ${curl_slack['SLACK_WEBHOOK']}

    ${headers}    Create Dictionary    Content-type=application/json
    ${json_data}    Create Dictionary    message=${msg}

    POST    url=${endpoint}    headers=${headers}    json=${json_data}    expected_status=200
