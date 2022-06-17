Run Test Suite
TC_01_POST_Request

*** Settings ***
Library  RequestsLibrary
Library  JSONLibrary
Library  Collections
Library  OperatingSystem

Resource  ../Resources/GlobalVariables.robot

*** Variables ***
${relative_transactions_url}    transactions
${name}                         Burger Queen Order
${value}                        25.9
${date}                         2022-06-11T12:46:02.937Z
${v1}
${v2}
${i}
${data}

*** Keywords ***
Valid POST create
    FOR  ${v1}  IN  @{CATEGORIES}
        FOR    ${v2}   IN      @{TYPES}
            # Creating Post Data
            ${body}=           create dictionary    name=${name}  category=${v1}  type=${v2}  value=${value}  date=${date}

            # Post
            ${response}=       POST On Session      Add_Data  ${relative_transactions_url}  json=${body}

            # Validate Status Code
            ${status_code}=    convert to string    ${response.status_code}
            should be equal    ${status_code}       201

            # Validade Body response
            dictionary should contain value         ${response.json()}      ${name}
            dictionary should contain value         ${response.json()}      ${v1}
            dictionary should contain value         ${response.json()}      ${v2}
            dictionary should contain value         ${response.json()}      ${value}
            dictionary should contain value         ${response.json()}      ${date}

            # Check id and save it
            dictionary should contain key           ${response.json()}      id
            ${id}=      get from dictionary         ${response.json()}      id
            append to list                          ${IDS}                  ${id}
        END
    END


Print IDS
    FOR  ${i}  IN  @{IDS}
        log to console  ${i}
    END


Save in a File
    FOR    ${data}    IN    @{IDS}
        APPEND TO FILE     ${FILE_DIR}    ${data}\n
    END


Invalid POST create
    [Arguments]  ${args}

    IF     '${args}' == 'name'
        ${name}=    set variable  ${EMPTY}
        ${v1}=      set variable  ${CATEGORIES}[0]
        ${v2}=      set variable  ${TYPES}[0]

    ELSE IF     '${args}' == 'category'
        ${name}=    set variable  Burguer
        ${v1}=      set variable  ${EMPTY}
        ${v2}=      set variable  ${TYPES}[0]

    ELSE IF     '${args}' == 'type'
        ${name}=    set variable  Burguer
        ${v1}=      set variable  ${CATEGORIES}[0]
        ${v2}=      set variable  ${EMPTY}

    ELSE IF     '${args}' == 'value'
        ${name}=    set variable  Burguer
        ${v1}=      set variable  ${CATEGORIES}[0]
        ${v2}=      set variable  ${TYPES}[0]
        ${value}=   set variable  ${EMPTY}

    ELSE IF     '${args}' == 'date'
        ${name}=    set variable  Burguer
        ${v1}=      set variable  ${CATEGORIES}[0]
        ${v2}=      set variable  ${TYPES}[0]
        ${value}=   set variable  12.32
        ${date}=    set variable  ${EMPTY}

    ELSE IF     '${args}' == 'wrong_date'
        ${name}=    set variable  Burguer
        ${v1}=      set variable  ${CATEGORIES}[0]
        ${v2}=      set variable  ${TYPES}[0]
        ${value}=   set variable  12.32
        ${date}=    set variable  1234

    END

    ${body}=           create dictionary    name=${name}  category=${v1}  type=${v2}  value=${value}  date=${date}

    # Post
    ${response}=       post request      Add_Data  ${relative_transactions_url}  json=${body}

    # Validate Status Code
    ${status_code}=    convert to string    ${response.json()}
    [return]  ${status_code}



*** Test Cases ***
TC_01_01_Valid_POST_Request
    [Tags]    Regression    POST
    [Documentation]

    # Create the session
    create session     Add_Data             ${BASE_URL}

    # Call POST creation
    Valid POST create

    # Print the IDS list components
    Print IDS

    # Save IDS in a file
    Save in a File


TC_01_02_Invalid_POST_Request
    [Tags]  Regression  POST

    # Create the session
    create session     Add_Data             ${BASE_URL}

    # Call POST without name
    ${ret}=     Invalid POST create     name

    should contain      ${ret}          400
    should contain      ${ret}          Name is required


TC_01_03_Invalid_POST_Request
    [Tags]  Regression  POST

    # Create the session
    create session     Add_Data             ${BASE_URL}

    # Call POST without name
    ${ret}=     Invalid POST create     category

    should contain      ${ret}          400
    should contain      ${ret}          Category is required


TC_01_04_Invalid_POST_Request
    [Tags]  Regression  POST

    # Create the session
    create session     Add_Data             ${BASE_URL}

    # Call POST without name
    ${ret}=     Invalid POST create     type

    should contain      ${ret}          400
    should contain      ${ret}          Type is required

TC_01_05_Invalid_POST_Request
    [Tags]  Regression  POST

    # Create the session
    create session     Add_Data             ${BASE_URL}

    # Call POST without name
    ${ret}=     Invalid POST create     value

    should contain      ${ret}          400
    should contain      ${ret}          Number is required

TC_01_06_Invalid_POST_Request
    [Tags]  Regression  POST

    # Create the session
    create session     Add_Data             ${BASE_URL}

    # Call POST without name
    ${ret}=     Invalid POST create     date

    should contain      ${ret}          400
    should contain      ${ret}          Date is required

TC_01_07_Invalid_POST_Request
    [Tags]  Regression  POST

    # Create the session
    create session     Add_Data             ${BASE_URL}

    # Call POST without name
    ${ret}=     Invalid POST create     wrong_date

    should contain      ${ret}          400