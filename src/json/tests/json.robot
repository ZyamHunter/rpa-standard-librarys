*** Settings ***
Library     RPA.JSON
Library     RPA.FileSystem


*** Tasks ***
Add to JSON
    &{json_before}=    Convert string to JSON    {"People": [{"Name": "Mark"}, {"Name": "Jane"}]}
    &{json_expected}=    Convert String to JSON    {"People": [{"Name": "Mark"}, {"Name": "Jane"}, {"Name": "John"}]}
    &{person}=    Create dictionary    Name=John
    &{json_after}=    Add to JSON    ${json_before}    $.People    ${person}

    Should be equal    ${json_after}    ${json_expected}

Convert JSON to String
    ${obj}=    Create dictionary    Key=Value
    ${json}=    Convert JSON to string    ${obj}
    Should be equal    ${json}    {"Key": "Value"}

Convert String to JSON
    ${json}=    Set variable    {"Key": "Value"}
    &{obj}=    Convert string to JSON    ${json}
    Should be equal    ${obj.Key}    Value

Delete from JSON
    &{before}=    Convert string to JSON    {"People": [{"Name": "Mark"}, {"Name": "Jane"}]}
    &{after}=    Delete from JSON    ${before}    $.People[*]
    &{json_expected}=    Convert String to JSON    {"People": []}
    Should Be Equal    ${before}    ${json_expected}

    &{other_json}=    Convert string to JSON    {"People": [{"Name": "Mark"}, {"Name": "Jane"}]}
    &{result}=    Delete from JSON    ${other_json}    $.People[0]
    &{other_json_expected}=    Convert String to JSON    {"People": [{"Name": "Jane"}]}
    Should Be Equal    ${result}    ${other_json_expected}

Get value from JSON
    ${JSON_DOC}=    Absolute Path    src\\json\\assets\\users.json
    &{JSON}=    Load JSON from file    ${JSON_DOC}
    ${value}=    Get value from JSON    ${JSON}    $.clients[0].orders[0]
    # other example
    &{people}=    Convert string to JSON    {"People": [{"Name": "Mark"}, {"Name": "Jane"}]}
    ${first}=    Get value from JSON    ${people}    $.People[0].Name
    Should Be Equal    ${first}    Mark

Get values from JSON
    ${JSON_DOC}=    Absolute Path    src\\json\\assets\\users.json
    &{JSON}=    Load JSON from file    ${JSON_DOC}
    # Find delivery addresses for all orders
    ${prices}=    Get values from JSON    ${JSON}    $..address
    # Find orders that cost over 100
    ${expensives}=    Get values from JSON    ${JSON}    $..orders[?(@.price>100)]
    # third example
    &{people}=    Convert string to JSON    {"People": [{"Name": "Mark"}, {"Name": "Jane"}]}
    @{names}=    Get values from JSON    ${people}    $.People[*].Name

Get All Prices and Order Ids
    ${JSON_DOC}=    Absolute Path    src\\json\\assets\\users.json
    &{JSON}=    Load JSON from file    ${JSON_DOC}
    # Arithmetic operations only work when lists are of equal lengths and types.
    ${prices}=    Get values from json
    ...    ${JSON}
    ...    $.clients[*].orders[*].id + " has price " + $.clients[*].orders[*].price.`str()`
    # Log    \nOUTPUT IS\n ${prices}    console=${True}
    Should be equal as strings
    ...    ${prices}
    ...    ['guid-001 has price 103.2', 'guid-002 has price 98.99', 'guid-003 has price 22.0', 'guid-004 has price 2330.01', 'guid-005 has price 152.12']

Find Only Valid Emails With Regex
    ${JSON_DOC}=    Absolute Path    src\\json\\assets\\users.json
    &{JSON}=    Load JSON from file    ${JSON_DOC}
    # The regex used in this example is simplistic and
    # will not work with all email addresses
    ${emails}=    Get values from json
    ...    ${JSON}
    ...    $.clients[?(@.email =~ "[a-zA-Z]+@[a-zA-Z]+\.[a-zA-Z]+")].email
    # Log    \nOUTPUT IS\n ${emails}    console=${True}
    Should be equal as strings    ${emails}    ['john@example.com', 'jane@example.com']

Find Orders From Texas Over 100
    ${JSON_DOC}=    Absolute Path    src\\json\\assets\\users.json
    &{JSON}=    Load JSON from file    ${JSON_DOC}

    ${orders}=    Get values from json
    ...    ${JSON}
    ...    $.clients[*].orders[?(@.price > 100 & @.state == "TX")]
    # Log    \nOUTPUT IS\n ${orders}    console=${True}
    Should be equal as strings
    ...    ${orders}
    ...    [{'address': 'Streetroad 123', 'state': 'TX', 'price': 103.2, 'id': 'guid-001'}, {'address': 'Streetroad 123', 'state': 'TX', 'price': 2330.01, 'id': 'guid-004'}]

Load JSON from file
    ${JSON_DOC}=    Absolute Path    src\\json\\assets\\users.json
    &{JSON}=    Load JSON from file    ${JSON_DOC}

Save dictionary to file
    ${john}=    Create dictionary    name=John    mail=john@example.com
    Save JSON to file    ${john}    ${OUTPUT_DIR}${/}john.json

Save string to file
    ${mark}=    Set variable    {"name": "Mark", "mail": "mark@example.com"}
    Save JSON to file    ${mark}    ${OUTPUT_DIR}${/}mark.json

Update value to JSON
    # Change the name key for all people
    &{before}=    Convert string to JSON    {"People": [{"Name": "Mark"}, {"Name": "Jane"}]}
    &{after}=    Update value to JSON    ${before}    $.People[*].Name    JohnMalkovich
    Should Be Equal    ${after.People[0].Name}    JohnMalkovich
    Should Be Equal    ${after.People[1].Name}    JohnMalkovich

Update user email
    ${JSON_DOC}=    Absolute Path    src\\json\\assets\\users.json
    &{JSON}=    Load JSON from file    ${JSON_DOC}
    ${updated_doc}=    Update value to json
    ...    ${JSON}
    ...    $.clients[?(@.id=="user-001")].email
    ...    johnny@example.com
    # Log    \nNEW JSON IS\n ${updated_doc}    console=${True}
    ${new_email}=    Get value from json    ${updated_doc}    $.clients[?(@.id=="user-001")].email
    Should be equal as strings    ${new_email}    johnny@example.com

Add additional charge to all prices in WA
    # This example also shows how the update keyword changes the original JSON doc in memory.

    ${JSON_DOC}=    Absolute Path    src\\json\\assets\\users.json
    &{JSON}=    Load JSON from file    ${JSON_DOC}
    ${ID}=    Set Variable    guid-003

    ${id_price}=    Get values from json
    ...    ${JSON}
    ...    $.clients[*].orders[?(@.state=="WA")].id,price
    FOR    ${order_id}    ${price}    IN    @{id_price}
        Update value to json    ${JSON}    $.clients[*].orders[?(@.id=="${order_id}")].price    ${{${price} * 1.06}}
    END
    # Log    \nNEW JSON IS\n ${JSON}    console=${True}
    ${one_price}=    Get value from json    ${JSON}    $..orders[?(@.id==${ID})].price
    Should be equal as numbers    ${one_price}    23.32
