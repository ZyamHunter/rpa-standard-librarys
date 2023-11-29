*** Settings ***
Documentation       Control Robot Framework task execution.

Library             RPA.Tasks


*** Variables ***
${TARGET}       5
${CURRENT}      1


*** Tasks ***
Jump To Task
    Jump To Task    Jump To Task If Keyword Fails
    Log To Console    Jump To Task

Jump To Task If
    Jump To Task If    ${False}    Set Next Task
    Jump To Task If    ${True}    Set Next Task
    Log To Console    Jump To Task If

Jump To Task If Keyword Fails
    Jump To Task If Keyword Fails    Jump To Task If    Log    Falha
    Jump To Task If Keyword Fails    Jump To Task If    Fail
    Log To Console    Jump To Task If Keyword Fails

Jump To Task If Keyword Succeeds
    Jump To Task If Keyword Succeeds    Set Next Task If Keyword Fails    Fail
    Jump To Task If Keyword Succeeds    Set Next Task If Keyword Fails    Log    Sucesso!
    Log To Console    Jump To Task If Keyword Succeeds

Set Next Task
    Set Next Task    Jump To Task If Keyword Succeeds
    Log To Console    Set Next Task

Set Next Task If
    Set Next Task If    ${False}    Set Next Task If Keyword Succee
    Set Next Task If    ${True}    Set Next Task If Keyword Succee
    Log To Console    Set Next Task If

Set Next Task If Keyword Fails
    Set Next Task If Keyword Fails    Set Next Task If    Log    Falha com sucesso
    Set Next Task If Keyword Fails    Set Next Task If    Fail
    Log To Console    Set Next Task If Keyword Fails

Control Task
    Log    I'm trying to count to ${TARGET}
    ${NEW_COUNT}    Evaluate    ${CURRENT} + 1
    Set suite variable    ${CURRENT}    ${NEW_COUNT}

    Set Next Task If    ${CURRENT} >= ${TARGET}    Set Next Task If Keyword Succee

Set Next Task If Keyword Succee
    Jump To Task    Control Task
    Set Next Task If Keyword Succeeds    Jump To Task    Fail
    Set Next Task If Keyword Succeeds    Jump To Task    Log    Última task
    Log To Console    Set Next Task If Keyword Succee
