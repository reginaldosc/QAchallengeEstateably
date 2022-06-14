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
    ${response}=     delete request     Delete_Transaction           ${relative_transactions_url}

    # Validate the Status Code
    ${str_response}=  convert to string     ${response.json()}
    should contain    ${str_response}       404

    # Validate the Response Body
    should contain  ${str_response}         Transaction not found
