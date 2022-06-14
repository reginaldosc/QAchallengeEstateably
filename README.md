# **Environment Setup**

* Python (check with: python --version)

* pip (check with: pip --version)

* Pycharm IDE (https://www.jetbrains.com/pycharm/download/)


# **Cloning the Project**

* Open the CMD terminal on desired folder

* Clone the Code running: `$ git clone https://github.com/reginaldosc/QAchallengeEstateably.git`

* Install all libraries dependencies running the command: `$ pip install -r requirements.txt`
    
# **Running Tests**

* All Tests: `..\QAchallengeEstateably>robot -d Reports -i Regression Tests/`

* TC-01: `..\QAchallengeEstateably>robot -d Reports Tests/TC_01_POST_Request.robot`
* TC-02: `..\QAchallengeEstateably>robot -d Reports Tests/TC_02_GET_Request.robot`
* TC-03: `..\QAchallengeEstateably>robot -d Reports Tests/TC_03_GET_SearchRequest.robot`
* TC-04: `..\QAchallengeEstateably>robot -d Reports Tests/TC_04_DELETE_Request.robot`

# **Report & Log**
* Report: Go to the folder `..\QAchallengeEstateably\Reports\` and open the file `report.html`

* Log: Go to the folder `..\QAchallengeEstateably\Reports\` and open the file `log.html`
