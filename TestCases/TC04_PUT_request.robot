*** Settings ***
Library  RequestsLibrary
Library  Collections
Library  String
Library  JSONLibrary

*** Variables ***
${base_url}     https://reqres.in
${user}     /api/users/2
${updated_time}  $.updatedAt

# https://reqres.in/api/users

#{
#    "name": "vinod123",
#    "job": "leader"
#}

*** Test Cases ***
Put_User_Details
    [Tags]  put request demo
    create session  mypost_session   ${base_url}
    ${body}=    create dictionary   name=vinodput   job=SW_Engineer
    ${header}=  create dictionary  Content-Type=application/json; charset=utf-8
    ${response}=    put request  mypost_session    ${user}  data=${body}   headers=${header}

    log to console  ${response.status_code}
    log to console  ${response.content}

    #VALIDATION
    ${status_code}=  convert to string  ${response.status_code}
    should be equal  ${status_code}  200

    ${title}=  convert to string  ${response.content}
    should contain  ${title}  vinodput
    should contain  ${title}  SW_Engineer

    ${json_response}=   convert string to json  ${response.content}
    ${contents}=    get value from json   ${json_response}  ${updated_time}
    should not be empty   ${contents}





