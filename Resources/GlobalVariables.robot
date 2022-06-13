*** Variables ***
${BASE_URL}                     https://estateably-todo.herokuapp.com/

@{CATEGORIES}                   Salary    Food    Transport    House    Other
@{TYPES}                        Expense    Income
@{IDS}
${FILE_DIR}                     Resources/ids.txt

*** Keywords ***
set global variable  @{CATEGORIES}
set global variable  @{TYPES}
set global variable  @{IDS}
set global variable  ${FILE_DIR}
