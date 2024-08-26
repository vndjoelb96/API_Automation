*** Settings ***
Library  RequestsLibrary
Library  Collections
Library  String
Library  JSONLibrary

*** Variables ***
${base_url}     https://reqres.in
${patch_url}    /api/users/2
${user}     /api/users
${id_path}  $.id

# https://reqres.in/api/users

#{
#    "name": "vinod123",
#    "job": "leader"
#}

*** Test Cases ***
Post_User_Details
    [Tags]  demo1
    create session  mypost_session   ${base_url}
    ${body}=    create dictionary   name=vinodzzz   job=captain
    ${header}=  create dictionary  Content-Type=application/json; charset=utf-8
    ${response}=    post request  mypost_session    ${user}  data=${body}   headers=${header}

    log to console  ${response.status_code}
    log to console  ${response.content}
    #VALIDATION
    ${status_code}=  convert to string  ${response.status_code}
    should be equal  ${status_code}  201

    ${title}=  convert to string  ${response.content}
    should contain  ${title}  captain
    should contain  ${title}  vinodzzz

    ${json_response}=   convert string to json  ${response.content}
    ${contents}=    get value from json   ${json_response}  ${id_path}
    should not be empty   ${contents}

Patch_User_Details
    [Tags]  demo2
    create session  mypost_session   ${base_url}
    ${body}=    create dictionary   name=morpheus   job=zion resident
    ${header}=  create dictionary  Content-Type=application/json; charset=utf-8
    ${response}=    patch request  mypost_session    ${patch_url}  data=${body}   headers=${header}

    log to console  ${response.status_code}
    log to console  ${response.content}



