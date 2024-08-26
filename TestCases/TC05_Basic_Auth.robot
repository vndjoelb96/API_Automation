*** Settings ***
Library  RequestsLibrary
Library  Collections


*** Variables ***
${base_url}  https://postman-echo.com
${URI}  /basic-auth

*** Test Cases ***
Basic_Authentication
    ${auth}=    create list   postman    password
    create session  mysession   ${base_url}   auth=${auth}
    ${response}=    get request  mysession  ${URI}
    log to console  ${response.content}
    should be equal as strings  ${response.status_code}  200