*** Settings ***
Library     RPA.Assistant
Library     RPA.FileSystem


*** Tasks ***
Success dialog
    Add icon    Success
    Add heading    Your orders have been processed
    Add Loading Bar    Carregando %    100    30
    Add files    *.txt
    # Run dialog    title=Success
    Clear Dialog

Failure dialog
    Add icon    Failure
    Add heading    There was an error
    Add text    The assistant failed to login to the Enterprise portal
    Add link    https://robocorp.com/docs    label=Troubleshooting guide
    Add Loading Spinner    Carregando %    100    30
    # Run dialog    title=Failure
    Clear Dialog

Large dialog
    Add heading    A real chonker    size=large
    Add image    src\\assistant\\assets\\nave.jpg
    # Run dialog    title=Large    height=1024    width=1024
    Clear Dialog

Confirmation dialog
    Add icon    Warning
    Add heading    Delete user João?
    Add submit buttons    buttons=No,Yes    default=Yes
    # ${result}=    Run dialog
    # IF    $result.submit == "Yes"
    #    Log    Usuário deletado
    # END
    Clear Dialog

Input form dialog
    Add heading    Send feedback
    Add text input    email    label=E-mail address
    Add text input    message
    ...    label=Feedback
    ...    placeholder=Enter feedback here
    ...    maximum_rows=5
    # ${result}=    Run dialog
    # Send feedback message    ${result.email}    ${result.message}
    Log    enviando e-mail
    Clear Dialog

First View
    Add Heading    Here is the first view of the app
    Add Button    Change View    Second View
    # Run dialog    title=Large    height=1024    width=1024
    Clear Dialog

Second View
    Add Heading    Let's build an infinite loop
    Add Button    Change View    First View
    # Run dialog    title=Large    height=1024    width=1024
    Clear Dialog

Select checkboxes
    Add heading    Enable features
    Add checkbox    name=vault    label=Enable vault    default=True
    Add checkbox    name=triggers    label=Enable triggers    default=False
    Add checkbox    name=assistants    label=Enable assistants    default=True
    # ${result}=    Run dialog
    # IF    $result.vault
    #    Enable vault
    # END
    Clear Dialog

Select birthdate
    Add heading    Enter your birthdate
    Add Date Input    birthdate    default=1993-04-26
    # ${result} =    Run dialog
    # Log To Console    User birthdate year should be: ${result.birthdate.year}
    Clear Dialog

Select user type from drop down
    Add heading    Select user type
    Add drop-down
    ...    name=user_type
    ...    options=Admin,Maintainer,Operator
    ...    default=Operator
    ...    label=User type
    # ${result}=    Run dialog
    # Log    User type should be: ${result.user_type}
    Clear Dialog

Open file button
    ${path}=    Absolute Path    src\\assistant\\assets\\nave.jpg
    Add heading    Current orders
    Add file    ${path}    label=Current
    # Run dialog
    Clear Dialog

Multiple file selections
    # This can be any one file
    Add file input    name=anything

    # This can be multiple files
    Add file input    name=multiple    multiple=True

    # This opens the select dialog to a custom folder
    Add file input    name=src    source=C:\Temp\Output\

    # This restricts files to certain types
    Add file input    name=types    file_type=pdf

    # Every file input result is a list of paths
    # ${result}=    Run dialog
    # FOR    ${path}    IN    @{result.multiple}
    #    Log    Selected file: ${path}
    # END
    Clear Dialog

Open multiple files buttons
    # Add all excel files
    Add files    *.xlsx

    # Add all log files in any subdirectory
    Add files    **/*.log

    # Add all PDFs between order0 and order9
    Add files    order[0-9].pdf

    Clear Dialog

Add custom icon
    Add Heading    Check icon
    Add Flet Icon    icon_name=check_circle_rounded    color=FF00FF    size=48
    # Run Dialog
    Clear Dialog

Add dialog heading
    Add heading    User information    size=Large
    Add heading    Location    size=Small
    Add text input    address    label=User address
    # Run dialog
    Clear Dialog

Get user information
    Add hidden input    user_id    662hhjshgIOiuhsj889NNBFFTGFTDS
    Add text input    username
    # ${result}=    Run dialog
    # Enter user information    ${result.user_id}    ${result.username}
    Clear Dialog

Display image
    Add image    src\\assistant\\assets\\nave.jpg
    Add heading    To start, please press the Continue button    size=Small
    Add submit buttons    Continue
    # Run dialog
    Clear Dialog

Display troubleshoot link
    Add heading    An error occurred
    Add text    See link for documentation
    Add link    https://robocorp.com/docs    label=Troubleshooting
    # Run dialog
    Clear Dialog

Main Form
    Add Heading    Username input
    Add Text Input    name=username_1    placeholder=username
    Add Next Ui Button    Show customer details    Customer Details
    Clear Dialog

Change password
    Add heading    Change password
    Add text input    username    label=Current username
    Add password input    password    label=New password
    Add submit buttons    buttons=Submit
    # ${result}=    Run dialog
    # Change user password    ${result.username}    ${result.password}
    Clear Dialog

Select user type from radio buttons
    Add heading    Select user type
    Add radio buttons
    ...    name=user_type
    ...    options=Admin,Maintainer,Operator
    ...    default=Operator
    ...    label=User type
    # ${result}=    Run dialog
    # Log    User type should be: ${result.user_type}
    Clear Dialog

Create Percentage Slider
    Add Text    Percentage slider
    Add Slider    name=percentage    slider_min=0    slider_max=100
    # Run Dialog
    # Refresh Dialog
    # Clear Dialog

Ask user dialog
    Add heading    Please enter your username
    Add text input    name=username
    # ${result}=    Ask User
    # Log    The username is: ${result.username}
    Clear Dialog

Test
    Add Text    Percentage slider
    Add Slider    name=percentage    slider_min=0    slider_max=100
    Clear Dialog

Double Column Layout
    Open Row
    Open Column
    Add Text    First item in the first column
    Add Text    Second item on the first column
    Close Column
    Open Column
    Add Text    First item on the second column
    Close Column
    Close Row
    Clear Dialog

Padded Element With Background
    Open Container    padding=20    background_color=blue500
    Add Text    sample text
    Close Container
    Clear Dialog

Assistant Navbar
    Open Navbar    title=Assistant
    Add Button    menu    Go To Start Menu
    Close Navbar
    Clear Dialog

Side By Side Elements
    Open Row
    Add Text    First item on the row
    Add Text    Second item on the row
    Close Row
    Clear Dialog

Absolutely Positioned Elements
    # Positioning containers with relative location values requires
    # absolute size for the Stack
    Open Stack    height=360    width=360

    Open Container    width=64    height=64    location=Center
    Add Text    center
    Close Container

    Open Container    width=64    height=64    location=TopRight
    Add Text    top right
    Close Container

    Open Container    width=64    height=64    location=BottomRight
    Add Text    bottom right
    Close Container

    Close Stack
    Clear Dialog
