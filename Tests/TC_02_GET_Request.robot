Run Test Suite
TC_02_GET_Request

*** Settings ***
Library  RequestsLibrary
Library  JSONLibrary
Library  Collections

Resource  ../Resources/GlobalVariables.robot


*** Variables ***
${relative_transactions_url}    transactions


*** Test Cases ***
TC_02_01_GET_Valid_Request
    [Tags]    Regression    GET

    # GET
    create session           Get_Transactions_List      ${BASE_URL}
    ${response}=             get on session             Get_Transactions_List       ${relative_transactions_url}

    # Validate Status Code
    ${status_code}=          convert to string          ${response.status_code}
    should be equal          ${status_code}             200

    # Validate Body
    ${body}                  convert to string          ${response.content}
    should contain           ${body}                    name

    # Validate Header
    ${content_type}=         get from dictionary        ${response.headers}         Content-Type
    should not be equal      ${content_type}            application/json
