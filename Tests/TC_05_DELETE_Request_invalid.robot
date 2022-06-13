*** Settings ***
Library  RequestsLibrary
Library  JSONLibrary
Library  Collections

Resource  ../Resources/GlobalVariables.robot


*** Variables ***
${wrong_id}                     11111111-1111-1111-1111-111111111111
${relative_transactions_url}    transactions/${wrong_id}


*** Test Cases ***
TC_05_DELETE_Request
    [Tags]    Regression    DELETE

    # Delete Command
    create session   Delete_Transaction    ${BASE_URL}
    ${response}=     DELETE On Session     Delete_Transaction           ${relative_transactions_url}

    # Validate the Status Code
    ${status_code}=  convert to string     ${response.status_code}
    should be equal  ${status_code}        404

    # Validate the Response Body
    ${body}         convert to string      ${response.content}
    should contain  ${body}                Transaction not found
