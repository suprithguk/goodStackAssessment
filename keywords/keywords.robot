*** Settings ***
Library     Process
Library     OperatingSystem
Variables   ../Variables/variables.py

*** Keywords ***
Test Ip print with input1.json
    [Tags]      input1    smoke    functional
    ${var1}=    Run Process     python3     ${SCRIPT}   ${INPUT1}
    #Should Be Equal As Strings   ${var1.stdout}    192.168.101.101\n192.168.101.70\n192.168.101.153
    Should Be Equal As Strings    ${var1.rc}     0

Test Ip Print With input2.json
    [Tags]      input2      smoke   functional
    ${var1}=    Run Process     python3    ${SCRIPT}    ${INPUT2}
    #Should Be Equal As Strings    ${var1.stdout}    192.168.102.33 10.0.0.87\n192.168.103.74 10.0.0.77\n192.168.102.155 10.0.0.99
    Should Be Equal As Integers   ${var1.rc}    0

Test File Not Found Error
    [Tags]    fileNotFound
    ${var1}=    Run Process    python3      ${SCRIPT}    ${NON_EXISTENT_FILE}    stderr=True
    Should Be Equal As Strings    ${var1.stdout}    Error: The file 'non_existent.json' was not found.
    Should Be Equal As Integers   ${var1.rc}    1

Test Missing Required Keys
    [Tags]    missingKeys
    ${MISSING_KEYS}    Create File    missing_keys.json    {"vm_private_ips": {"sensitive": false, "type": "map"}}
    ${var1} =   Run Process    python3  ${SCRIPT}    missing_keys.json    stderr=True
    Should Contain    ${var1.stdout}    Error: The required 'vm_private_ips' or 'value' key is missing.
    Should Be Equal As Integers   ${var1.rc}    1
    Remove File    missing_keys.json

Test Malformed Json
    [Tags]    malformedJson
    Create File    ${MALFORMED_JSON}    "invalid_json": true,    # Creates malformed JSON
    ${var1}=    Run Process    python3     ${SCRIPT}    ${MALFORMED_JSON}    stderr=True
    Should Contain    ${var1.stdout}    Error: The file 'malformed.json' contains invalid JSON.
    Should Be Equal As Integers   ${var1.rc}    1
    Remove File    ${MALFORMED_JSON}

Test Empty File
    [Tags]      emptyJson
    Touch     ${EMPTY_JSON}
    ${var1}=   Run Process     python3     ${SCRIPT}   ${EMPTY_JSON}
    File Should Be Empty    ${EMPTY_JSON}
    Should Contain  ${var1.stdout}      Error: The file 'empty.json' contains invalid JSON.
    Should Be Equal As Integers   ${var1.rc}    1
    Remove File    ${EMPTY_JSON}

Test Without File
    [Tags]      noFilePassed
    ${var1}=   Run Process     python3     ${SCRIPT}
    Should Contain  ${var1.stdout}      Usage: python3 ip_print.py FILENAME
    Should Be Equal As Integers   ${var1.rc}    1