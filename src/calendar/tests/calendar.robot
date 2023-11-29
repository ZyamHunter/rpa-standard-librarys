*** Settings ***
Documentation       Library for common encryption and hashing operations.

Library             RPA.Calendar


*** Tasks ***
Add Custom Holidays
    @{custom_holidays}=    Add Custom Holidays    2023-03-08
    Log    ${custom_holidays}
    # ${custom_holidays} == ["2023-03-08"]
    @{more_holidays}=    Create List    2023-03-09    2023-03-10
    @{custom_holidays_2}=    Add Custom Holidays    ${more_holidays}
    Log    ${custom_holidays_2}
    # ${custom_holidays_2} == ["2023-03-08", "2023-03-09", "2023-03-10"]

Compare Times
    ${recent}=    Compare Times    2023-03-09 13:02    2023-03-09 13:47
    IF    ${recent}    Log    2023-03-09 13:47 is more recent

Compare Times ${time1} < ${time2}
    ${recent}=    Compare Times 2023-03-09 15:50 < 2023-03-09 15:59
    IF    ${recent}    Log    2023-03-09 15:59 is more recent

Compare Times ${time1} > ${time2}
    ${recent}=    Compare Times 2023-03-09 15:59 > 2023-03-09 15:58
    IF    ${recent}    Log    2023-03-09 15:59 is more recent

Create Time
    ${date}=    Create Time
    ...    22 May 19
    ...    DD MMM YY

First Business Day Of The Month
    ${first_day}=    First Business Day of the Month    2024-06-01
    # ${first_day} == "2024-06-03"

Get Iso Calendar
    ${iso_cal}=    Get ISO Calendar    2023-03-09
    ${iso_year}=    Set Variable    ${iso_cal.year}
    ${iso_week}=    Set Variable    ${iso_cal.week}
    ${iso_weekday}=    Set Variable    ${iso_cal.weekday}

Is the ${date} Business Day in ${country}
    ${is_business_day}=    Is the 2023-01-02 business day in FI
    IF    ${is_business_day}
        Log To Console    It is time for the work
    ELSE
        Log To Console    It is time to relax
    END

Is the ${date} Holiday in ${country}
    ${is_it}=    Is the 2022-12-26 holiday in FI
    IF    ${is_it}    Log    Time to relax    ELSE    Log    Time for the work

Is The Date Business Day
    FOR    ${day}    IN RANGE    1    32
        ${date}=    Set Variable    2023-1-${day}
        ${is_business_day}=    Is the date business day    ${date}    FI
        IF    ${is_business_day}
            Log To Console    It is time for the work on ${date}
        ELSE
            Log To Console    It is time to relax on ${date}
        END
    END

Is The Date Holiday
    ${is_holiday}=    Is the date holiday    2022-12-26    FI
    IF    ${is_holiday}
        Log    Time to relax
    ELSE
        Log    Time for the work
    END

Last Business Day Of The Month
    ${last_day}=    Last Business Day of the Month    2023-12-01
    # ${last_day} == "2023-12-29"

Reset Custom Holidays
    @{custom_holidays}=    Add Custom Holidays    2023-03-08
    @{more_holidays}=    Create List    2023-03-09    2023-03-10
    @{custom_holidays_2}=    Add Custom Holidays    ${more_holidays}
    Reset Custom Holidays

Return Holidays
    &{holidays}=    Return Holidays    2023    FI
    FOR    ${date}    IN    @{holidays.keys()}
        Log To Console    ${date} is ${holidays}[${date}]
    END

Return Next Business Day
    ${next_business}=    Return Next Business Day    2023-01-05    FI
    # ${next_business} == "2023-01-09"

Return Previous Business Day
    ${previous_business}=    Return Previous Business Day    2023-01-09    FI
    # ${previous_business} == "2023-01-05"

Set Business Days
    @{days}=    Create List    1    2    3    4
    @{previous}=    Set Business Days    ${days}
    # ${previous} == [1,2,3,4,5]

Set Locale
    Set Locale    es
    ${now}=    Time Now    return_format=dddd DD MMMM YYYY
    # ${now} == "jueves 09 marzo 2023"
    Set Locale    en
    ${now}=    Time Now    return_format=dddd DD MMMM YYYY
    # ${now} == "Thursday 09 March 2023"

Sort List Of Dates
    @{datelist}=    Create List
    ...    2023-07-02 12:02:31
    ...    2023-07-03 12:02:35
    ...    2023-07-03 12:02:31
    ${sorted}=    Sort List Of Dates    ${datelist}
    # ${sorted}[0] == "2023-07-03 12:02:35"
    # ${sorted}[-1] == "2023-07-02 12:02:31"
    ${sorted}=    Sort List Of Dates    ${datelist}    reverse=True
    # ${sorted}[0] == "2023-07-02 12:02:31"
    # ${sorted}[-1] == "2023-07-03 12:02:35"

Time Difference
    &{diff}=    Time Difference    1975-05-22T18:00:00    1975-05-22T22:45:30
    # ${diff}[end_date_is_later] == True
    # ${diff}[days] == 0
    # ${diff}[hours] == 4
    # ${diff}[minutes] == 45
    # ${diff}[seconds] == 30

Time Difference Between Timezones
    ${diff}=    Time Difference Between Timezones
    ...    America/New_York
    ...    Europe/Helsinki
    # ${diff} == 7

Time Difference In Days
    ${diff}=    Time Difference In Days
    ...    2023-05-21
    ...    2023-05-29
    # ${diff} == 8

Time Difference In Hours
    ${diff}=    Time Difference In Hours
    ...    2023-08-21T22:00:00
    ...    2023-08-22T04:00:00
    # ${diff} == 6

Time Difference In Minutes
    ${diff}=    Time Difference In Minutes
    ...    12:30
    ...    16:35
    # ${diff} == 245

Time Difference In Months
    ${diff}=    Time Difference In Months
    ...    2022-05-21T22:00:00
    ...    2023-08-21T22:00:00
    # ${diff} == 15

Time Now
    ${now}=    Time Now    Europe/Helsinki
