*** Settings ***
Name        "Test cases suite for ip_print"
Resource    keywords/keywords.robot

*** Test Cases ***
TC1
    Test Ip print with input1.json

TC2
    Test Ip Print With input2.json

TC3
    Test File Not Found Error

TC4
    Test Missing Required Keys

TC5
    Test Malformed Json

TC6
    Test Empty File

TC7
    Test Without File