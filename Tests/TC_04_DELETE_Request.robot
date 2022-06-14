Run Test Suite
TC_04_DELETE_Request

*** Settings ***
Library  RequestsLibrary
Library  JSONLibrary
Library  Collections
Library  OperatingSystem
Library  String

Resource  ../Resources/GlobalVariables.robot
Library  RequestsLibrary
Library  JSONLibrary
Library  Collections
Library  OperatingSystem


*** Variables ***
${relative_transactions_url}    transactions/
${aux}
${aux2}
${file}
${wrong_id}                     11111111-1111-1111-1111-111111111111
${wrong_relative_transactions_url}    transactions/${wrong_id}


*** Test Cases ***
TC_04_01_Valid_DELETE_Request
    [Tags]    Regression    DELETE

    ${file}=        get file            ${FILE_DIR}
    @{line}=        Split To Lines      ${file}
    ${aux}=         catenate      SEPARATOR=    ${relative_transactions_url}       ${line}[0]
    log to console  ${aux}

    # Delete Command
    create session   Delete_Transaction    ${BASE_URL}
    ${response}=     DELETE On Session     Delete_Transaction       ${aux}

    # Validate the Status Code
    ${status_code}=  convert to string     ${response.status_code}
    should be equal  ${status_code}        204

    # Validate the Response
    ${length}=       get length            ${response.content}
    should be equal as integers            ${length}                0


TC_04_02_Invalid_DELETE_Request
    [Tags]    Regression    DELETE

    # Delete Command
    create session   Delete_Transaction    ${BASE_URL}
    ${response}=     delete request     Delete_Transaction           ${wrong_relative_transactions_url}

    # Validate the Status Code
    ${str_response}=  convert to string     ${response.json()}
    should contain    ${str_response}       404

    # Validate the Response Body
    should contain  ${str_response}         Transaction not found