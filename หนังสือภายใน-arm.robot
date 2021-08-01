*** Settings ***
Library    SeleniumLibrary

*** Test Cases ***
จนท.จัดทำหนังสือนำ และยกร่างหนังสือบันทึกข้อความ ออกเลขเวียน ไม่มีชั้นความลับ ไม่มีความเร่งด่วน เสนอ ผู้อํานวยการสำนัก/กอง/กลุ่ม/ศูนย์ ลงนาม

    # หน้าจอ login
    เปิด browser เข้า url=    https://rd-dev.summitthai.com/
    พิมพ์ username=    sunisa.ra
    พิมพ์ password=    P@ssw0rd
    กดปุ่ม login
    
    # หน้าจอ home 
    กดเข้า menu  ระบบสารบรรณฯ

    # ระบบ edcs    
    กดเข้า menu  ทะเบียนหนังสือส่ง
    กดเข้า menu  ยกร่างหนังสือ

    # หน้าจอ ยกร่างหนังสือ
    เลือกลงวันที่    17    6    2564
    ระบุชื่อเรื่อง  การประชาสัมพันธ์การยื่นแบบแสดงรายการภาษีเงินได้บุคคลธรรมดา ภ.ง.ด.90, 91 ปีภาษี 2563 - arm  
    ระบุ Autocomplete เรียน   ผู้อำนวยการกองมาตรฐานการจัดเก็บภาษี
    กดปุ่มออกเลขหนังสือ

    # หน้าจอ เลือกดำเนินการ
    กดปุ่มเสนอ

    # หน้าจอ เสนอ
    เลือกรายการที่จะเสนอ     หัวหน้ากลุ่มวิเคราะห์ข้อมูลการเสียภาษีเงินได้บุคคลธรรมดา (นางสาวกนกพร ดีหลายศรี)
    คลิกปุ่มเพิ่อเสนอ
    รอโหลดเสร็จ

    ปิด browser

*** Keywords***
เปิด browser เข้า url=
    [Arguments]     ${url-param}
    Open Browser     url= ${url-param}    browser=chrome 

พิมพ์ username=
    [Arguments]       ${type-text}
    Input Text    form-login:userId    ${type-text}

พิมพ์ password=
    [Arguments]       ${type-text}
    Input Password   form-login:password    ${type-text}    

กดปุ่ม login
    Click Button    form-login:btn

กดเข้า menu
    [Arguments]     ${search-word}
    click Link    locator=partial link:${search-word}  


เลือกลงวันที่
    [Arguments]    ${day}    ${month}    ${year}
    เลือกวันที่    id=formc:bookDate1_input    ${day}    ${month}    ${year}

เลือกวันที่
    [Arguments]    ${locator}    ${day}    ${month}    ${year}
    Click Element    ${locator}
    Click Element    //*[@id="ui-datepicker-div"]//select[@class="ui-datepicker-month"]
    Click Element    //*[@id="ui-datepicker-div"]//select[@class="ui-datepicker-month"]/option[${month}]
    Click Element    //*[@id="ui-datepicker-div"]//select[@class="ui-datepicker-year"]
    Click Element    //*[@id="ui-datepicker-div"]//select[@class="ui-datepicker-year"]/option[text() = '${year}']
    Click Element    //*[@id="ui-datepicker-div"]//table[@class="ui-datepicker-calendar"]//a[text() = '${day}']


ระบุชื่อเรื่อง
    [Arguments]    ${subjectName}
    Input Text    id=formc:subject1    ${subjectName}

ระบุ Autocomplete เรียน
    [Arguments]     ${receiverName}
    Input Text      //*[@id="formc:receiverNameAuto1_input"]   ${receiverName}
    Wait Until Element Is Visible    id=formc:receiverNameAuto1_panel
    Click Element   //*[@id="formc:receiverNameAuto1_panel"]//*[contains(text(), '${receiverName}')]

กดปุ่มออกเลขหนังสือ
    Click Element    id=formc:e_btnInsert

กดปุ่มเสนอ
    Wait Until Page Contains Element    id=formc:btnOfferS
    Scroll Element Into View    id=formc:btnOfferS
    Execute JavaScript    window.scrollTo(window.scrollX, window.scrollY + 200)
    Click Element    id=formc:btnOfferS

เลือกรายการที่จะเสนอ
    [Arguments]    ${purposeName}
    Wait Until Page Contains Element    id=formc:chkGetManager1_2_P
    Scroll Element Into View    //*[@id="formc:chkGetManager1_2_P"]//*[contains(text(), '${purposeName}')]
    Execute JavaScript    window.scrollTo(window.scrollX, window.scrollY + 200)
    Click Element    //*[@id="formc:chkGetManager1_2_P"]//*[contains(text(), '${purposeName}')]

คลิกปุ่มเพิ่อเสนอ
    Click Element    id=formc:e_btnAddSendLetter1

รอโหลดเสร็จ
    Wait For Condition    style = document.querySelectorAll("[id*='_start']")[0].style; return style.display == "none"

ปิด browser
    Close All Browsers