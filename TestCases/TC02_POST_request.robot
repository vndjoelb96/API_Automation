*** Settings ***
Library  RequestsLibrary
Library  Collections

*** Variables ***
${base_url}     https://reqres.in
${user}     /api/users

# https://reqres.in/api/users

#{
#    "name": "vinod123",
#    "job": "leader"
#}

*** Test Cases ***
Post_User_Details
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




