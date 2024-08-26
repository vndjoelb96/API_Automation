*** Settings ***
Library  RequestsLibrary
Library  Collections
Library  String
Library  JSONLibrary
Library  XML
Library  OperatingSystem
# https://reqres.in/api/users?page=2
# https://jsonplaceholder.typicode.com/posts/1

*** Variables ***
${base_url}     https://reqres.in
${Delete_base_url}  https://jsonplaceholder.typicode.com
${Delete_endpoint}  /posts/1
${page_path}    $.page

*** Test Cases ***
get request Test title
    [Tags]  Demo
    create session  session1   ${base_url}  disable_warnings=1
    ${endpoint}  set variable  /api/users?page=2
    ${response}=    get on session   session1   ${endpoint}
    log to console  ${response.status_code}
    log to console  ${response.content}
    log to console  ${response.headers}
    log  ${response.content}

    #VALIDATION
    ${status_code}=  convert to string  ${response.status_code}
    should be equal  ${status_code}  200

    ${first_name}=  convert to string  ${response.content}
    should contain  ${first_name}  Michael

    #extract specific Key and value and store value in variable
    ${contentTypeValue}=  get from dictionary  ${response.headers}  Content-Type
    should be equal  ${contentTypeValue}    application/json; charset=utf-8

    ${content_Connection}=  get from dictionary  ${response.headers}  Connection
    should be equal  ${content_Connection}    keep-alive

    ${json_response}=   convert string to json  ${response.content}
    ${contents}=    get value from json   ${json_response}  ${page_path}
    ${contents}=    convert to string  ${contents}
    ${contents}=    remove string using regexp  ${contents}   ['\\[\\],]
    log to console  ${contents}
    should be equal   ${contents}  2

Delete request data
    [Tags]  Demo1
    create session  session1   ${Delete_base_url}  disable_warnings=1
    ${endpoint}  set variable  ${Delete_endpoint}
    ${response}=    Delete On Session   session1   ${endpoint}
    log to console  ${response.status_code}
    log to console  ${response.content}

load and get xml data
    [Tags]  Demo3
    ${filepath}  set variable    ${EXECDIR}/TestCases/Data.xml
    log to console  ${filepath}

    ${XML}=     parse xml  ${filepath}
    ${value}    get element    ${XML}   firstName
    log to console  ${value.text}
    ${firstName}    set variable  ${value.text}
    should be equal  ${firstName}   John

    ${XML}=     parse xml  ${filepath}
    ${value}    get element    ${XML}   .//phoneNumbers[1]//type[2]
    log to console  ${value.text}
    ${firstName}    set variable  ${value.text}
    should be equal  ${firstName}   iPhone2

    ${XML}=     parse xml  ${filepath}
    ${value}    get element    ${XML}   .//address[1]//streetAddress
    log to console  ${value.text}
    ${firstName}    set variable  ${value.text}
    should be equal  ${firstName}   VJ lane

    ${value}    get element    ${XML}   .//age[1]
    log to console  ${value.text}

load and get JSON data
    [Tags]  Demo4
    ${filepath}  set variable    ${EXECDIR}/TestData/data.json
    log to console  ${filepath}

    ${json_obj}=     Get File  ${filepath}
    ${value}    Evaluate    json.loads('''${json_obj}''')   json
    log to console  ${value["firstName"]}
    ${firstName}    set variable   ${value["firstName"]}
    should be equal  ${firstName}   John

    ${ph}    set variable   ${value["phoneNumbers"][0]["type"]}
    should be equal  ${ph}   iPhone