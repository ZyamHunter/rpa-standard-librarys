*** Settings ***
Library             RPA.Browser.Selenium
Library             RPA.RobotLogListener

Task Setup          Set Task Variable    ${TRIES}    1
Task Teardown       Close All Browsers


*** Tasks ***
Check the official website
    Mute Run On Failure    Log tries
    Open Available Browser    https://www.robocorp.com
    Check for visible element
    Capture Page Screenshot

Check the official website with error log
    Mute Run On Failure    Test    optional_keyword_to_run=Log tries
    Open Available Browser    https://www.robocorp.com
    Check for visible element
    Capture Page Screenshot

Protecting keywords
    This will not output    # will output because called before register
    Register Protected Keywords    This will not output
    This will not output    # is now registered
    This will output

End Keyword
    This will not output    # will output because called before register
    Register Protected Keywords    This will not output
    This will not output    # is now registered
    This will output

    End Keyword    This will not output    attributes

Only info Level
    This will not output
    Only Info Level    This will not output
    This will not output    # is now registered
    This will output

Start keyword
    This will not output    # will output because called before register
    Register Protected Keywords    This will not output
    This will not output    # is now registered
    This will output

    Start Keyword    This will not output    attributes


*** Keywords ***
Check for visible element
    FOR    ${idx}    IN RANGE    1    20
        Set Task Variable    ${TRIES}    ${idx}
        ${status}    Run Keyword And Return Status    Element Should Be Visible    id:xyz
        IF    '${status}' == 'PASS'    BREAK
        # Sleep    2s
    END

Log tries
    Log    Checked element visibility ${TRIES} times

Test
    Log    Other message

This will not output
    Log    1

This will output
    Log    2

Info keyword
    Log    Info
