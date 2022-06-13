*** Settings ***
Library  RequestsLibrary
Library  JSONLibrary
Library  Collections
Library  OperatingSystem
Library  String

Resource  ../Resources/GlobalVariables.robot


*** Variables ***
${relative_transactions_url}    transactions/
${aux}
${aux2}
${file}

*** Test Cases ***
TC_04_DELETE_Request
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
