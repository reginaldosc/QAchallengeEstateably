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
POST create
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

*** Test Cases ***
TC_01_POST_Request
    [Tags]    Regression    POST

    # Create the session
    create session     Add_Data             ${BASE_URL}

    # Call POST creation
    POST create

    # Print the IDS list components
    Print IDS

    # Save IDS in a file
    Save in a File

