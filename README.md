# goodStackAssessment

This is a project created solely as an assessment for organization Good Stack. This doesn't use any proprietary softwares.

### Author
Suprith Gangawar <suprithguk@gmail.com>

### Pre Requisites
1. python3
2. pip3
3. virtualenv
4. robotframework
5. Blue Ocean Jenkins plugin
6. Robot Jenkins plugin

### Installation and Usage
1. Clone the repo https://github.com/suprithguk/goodStackAssessment.git
2. Copy or download the Jenkinsfile into your Jenkins server as a pipeline type Jenkins job
3. Install BlueOcean and robot plugins from plugins section in Jenkins for better viewing the html reports
4. Once setup, Build the Jenkins job
5. Observe the results in the console output of the build
6. Activate the virtualenv using $ source ./bin/activate
7. To run the tests on a local machine, ensure python3, pip3 & robotframework are installed
8. To run the python script: $python3 ip_print.py input1.json
9. To run the robot test cases: $robot ipPrintTestCases.robot
10. Deactivate the virtualenv: $ deactivate

### Important Files
1. ip_print.py - Python script to test all test cases
2. ipPrintTestCases.robot - All positive and negative test cases for above python script in robot framework
3. input1.json - Input file 1
4. input2.json - Input file 2
5. requirements.txt - Maintains all pip prerequisites required before running the Jenkins job
6. Jenkinsfile - Pipeline script to clone the repo and run the tests. This file can be the starting point.

### Test Cases
All the tests are written in ipPrintTestCases.robot file
1. Test ip print with input1.json
Scenario: Run the python script with input1.json file as input parameter using python3 \
Expected Behaviour: Script should run successfully with following output: \
192.168.101.101
192.168.101.70
192.168.101.153

The script should return with exit code 0

2. Test ip print with input2.json
Scenario: Run the python script with input2.json file as input parameter using python3 \
Expected Behaviour: Script should run successfully with following output: \
192.168.102.33 10.0.0.87
192.168.103.74 10.0.0.77
192.168.102.155 10.0.0.99

The script should return with exit code 0

3. Test File Not Found Error
Scenario: Run the python script with a non existenmt file as input parameter using python3 \
Expected Behaviour: Script should run successfully with following output: \
"Error: The file 'non_existent.json' was not found."

The script should return with exit code 1

4. Test Missing Required Keys
Scenario: Run the python script with newly created file with missing required keys as input parameter using python3 \
Expected Behaviour: Script should run successfully with following output: \
"Error: The required 'vm_private_ips' or 'value' key is missing."

The script should return with exit code 1

5. Test Malformed Json
Scenario: Run the python script with a newly created invalid json file as input parameter using python3 \
Expected Behaviour: Script should run successfully with following output: \
"Error: The file 'malformed.json' contains invalid JSON."

The script should return with exit code 1

6. Test Empty File
Scenario: Run the python script with a newly created empty file as input parameter using python3 \
Expected Behaviour: Script should run successfully with following output: \
"Error: The file 'empty.json' contains invalid JSON."

The script should return with exit code 1

8. Test Without File
Scenario: Run the python script with no file as input parameter using python3 \
Expected Behaviour: Script should run successfully with following output: \
"Usage: python3 ip_print.py FILENAME"

The script should return with exit code 1


### Reporting
1. Robot framework by default creates reports in html format, sample reports are attached in the repo for reference 
2. An additional output.xml file is generated which can be used as input to surefire reports in Jenkins
3. For this assessment, reports are configured to store in test1output and test2output folders, one per each stage