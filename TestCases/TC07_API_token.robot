# create a new project in google cloud console "PlacesAPI"
# create API key for that project
# enable API
# https://places.googleapis.com/v1/places/ChIJj61dQgK6j4AR4GeTYWZsKWw?fields=id,displayName&key=${Api_token}

*** Settings ***
Library  RequestsLibrary
Library  Collections
Library  OperatingSystem
Resource   ../TestCases/Credentials.robot

*** Variables ***
${base_url}  https://places.googleapis.com
${request_uri}  /v1/places/ChIJj61dQgK6j4AR4GeTYWZsKWw?

*** Test Cases ***
Google_Maps_PlacesAPI
    create session  mysession   ${base_url}
    ${params}   create dictionary   fields=id,displayName      key=${Api_token}
    ${response}=  get on session  mysession  ${request_uri}  params=${params}
    log to console  ${response.status_code}
    log to console  ${response.content}



