Run Test Suite
TC_03_GET_Search_Request

*** Settings ***
Library  RequestsLibrary
Library  JSONLibrary
Library  Collections

Resource  ../Resources/GlobalVariables.robot

*** Variables ***
${relative_search_transactions_url}     transactions/search
${keyword}                              Burg
${category}                             Food
${type}                                 Expense

*** Test Cases ***
TC_03_01_Valid_GET_Search_Request
    [Tags]    Regression    SEARCH

    # creating params values
    ${params}=              create dictionary        keyword=${keyword}  type=${type}  category=${category}

    # GET
    create session          Get_Transactions_List    ${BASE_URL}
    ${response}=            get on session           Get_Transactions_List   ${relative_search_transactions_url}   params=${params}

    # Validate Status Code
    ${status_code}=         convert to string        ${response.status_code}
    should be equal         ${status_code}           200

    # Validate Response (Should NOT be Empty)
    ${length}=              get length               ${response.json()}
    should not be equal     ${length}                0
