*** Settings ***
Documentation       Read OS information and manipulate processes.

Library             RPA.Desktop.OperatingSystem


*** Tasks ***
Get computer information
    ${boot_time}    Get Boot Time    as_datetime=${TRUE}
    ${machine}    Get Machine Name
    ${username}    Get Username
    &{memory}    Get Memory Stats
    Log Many    ${memory}

Boot Time In Seconds From Epoch
    ${epoch}    Boot Time In Seconds From Epoch

Get Boot Time
    ${boottime}    Get Boot Time
    ${boottime}    Get Boot Time    as_datetime=True
    ${boottime}    Get Boot Time    as_datetime=True    datetime_format=%d.%m.%Y

Get Machine Name
    ${machine}    Get Machine Name

Get Memory Stats
    &{mem}    Get Memory Stats
    &{mem}    Get Memory Stats    humanized=False

Get Username
    ${user}    Get Username

# Kill Process
#    ${process}    Process Exists    calc    strict=False
#    ${status}    Kill Process    ${process.name()}

# Kill Process By Pid
#    ${process}    Process Exists    sharex    strict=False
#    ${status}    Kill Process By PID    ${process.pid}

Process Exists
    ${process}    Process Exists    calc
    ${process}    Process Exists    calc    strict=False

Process Id Exists
    ${process}    Process ID Exists    4567
    IF    ${process}    Log    Process exists

# Put System To Sleep
    # Funciona só no Linux
#    Put System To Sleep
