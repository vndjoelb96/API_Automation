*** Settings ***
Library  RequestsLibrary
Library  Collections

*** Variables ***
${base_url}     https://demoqa.com
${books}    Books

#https://demoqa.com/BookStore/v1/Books

*** Test Cases ***
Get_bookstore_info
    create session  mysession   ${base_url}
    ${response}=    get request  mysession  /BookStore/v1/${books}

    #capture status code, content and header
#    log to console  ${response.status_code}
#    log to console  ${response.content}
#    log to console  ${response.headers}

    #VALIDATION
    ${status_code}=  convert to string  ${response.status_code}
    should be equal  ${status_code}  200

    ${title}=  convert to string  ${response.content}
    should contain  ${title}  Git Pocket Guide

#extract specific Key and value and store value in variable
    ${contentTypeValue}=  get from dictionary  ${response.headers}  Content-Type
    should be equal  ${contentTypeValue}    application/json; charset=utf-8

    ${content_Connection}=  get from dictionary  ${response.headers}  Connection
    should be equal  ${content_Connection}    keep-alive








