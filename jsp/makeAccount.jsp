<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>

<%
    request.setCharacterEncoding("utf-8");
    String name = (String)session.getAttribute("userName");

//try catch 넣기

    if (name != null){
        %>
            <script>
                alert("이미 로그인되어 있습니다. 일정 페이지로 이동합니다.");
                window.location.href = "mainCalendar.jsp"; // 아이디랑 비밀번호 넘기기? idx 넘기기?
            </script>
        <%
            }
       

//회원가입 : onchange 걸어서 조건 명시
//틀렸는데 로그인 하면 focus()걸어서 틀린 부분 박스로 표현하기

%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <link type="text/css" rel="stylesheet" href="../css/makeAccount.css">
    <link type="text/css" rel="stylesheet" href="../css/element.css">

</head>

<body>
    
    <h1 id="mainFont">회원가입</h1>
    <form action="../action/makeAccountAction.jsp" >
        <div id="loginBox">
            <div class="insertBox">
                <span id="nameFont" class="fontSize" >이름 : </span>
                <input id="nameBox" placeholder="필수 입력 사항입니다." name="name" type="text" maxlength="12" onchange="validName()">
                <span id="validName"></span>
            </div>
            <div class="insertBox" id="idAppendBox">
                <span id="idFont" class="fontSize">아이디 : </span>
                <input id="idBox" placeholder="4~10자리 사이" name="id" type="text" length="18" maxlength="16"  onchange="validId()">
                <span id="validId"></span>

                <button type="button" id="checkButton" onclick="checkIdDuplicate()">중복확인</button>
                <input type="hidden" name="idDuplication" id="idDuplicationCheck" value="unchecked">
            </div>
            <div class="insertBox">
                <span class="fontSize">비밀번호 : </span>
                <input id="pwBox" placeholder="4~16자리 사이" name="pw" type="password" length="18" maxlength="16" onchange="validPw()">
                <span id="validPw"></span>
            </div>
            <div class="insertBox">
                <span class="fontSize">재확인 비밀번호 : </span>
                <input id="comfirmPwBox" placeholder="4~16자리 사이" name="confirmPw" type="password" length="18" maxlength="16" onchange="validConfirmPw()">
                <span id="validConfirmPw"></span>
            </div>
            <div class="insertBox">
                <span class="fontSize">전화번호 : </span>
                <input id="numBox" placeholder="(-) 없이 입력해주세요." name="tel" type="text" length="18" maxlength="16" onchange="validTel()">
                <span id="validTel"></span> 
            </div>
            <div class="insertBox">
                <span id="selectTeam" class="fontSize">부서명 : </span>
                <div class="selectFont">
                    <input type="radio" name="team" value="디자인" onclick="selectTeam(this.value)"> 디자인
                    <input type="radio" name="team" value="개발" onclick="selectTeam(this.value)"> 개발
                </div>
            </div>
            <div class="insertBox">
                <span id="selectOcc" class="fontSize">직급선택 : </span>
                <div id="selectBox">
                    <input type="radio" name="company" onclick="selectTeam(this.value)" value="팀장"> 팀장
                    <input type="radio" name="company" onclick="selectTeam(this.value)" value="팀원"> 팀원
                </div>
            </div>
        </div>
    
</form>

    <button id="button" onclick="checkNoInput()">회원가입 하기</button>
    

    <div id="myModal" class="modal">
        <p id="modalText"></p>
        <button onclick="closeModal()">닫기</button>
        <button id="useIdButton" onclick="useIdEvent()">아이디 사용하기</button>
    </div>
    <script src="../js/makeAccount.js"></script>
    <script>
        function validName() {    
    var nameInput = document.getElementById('nameBox'); 
    var nameRegex = /^[a-zA-Z가-힣]{2,50}$/;
    
    if (nameRegex.test(nameInput.value)) {
        document.getElementById("validName").innerHTML = "";
    } else {
        document.getElementById("validName").innerHTML = "이름은 영어나 한글로 2자리 이상 50자리 이하로 작성해 주세요.";
    }
}
function validId(){
    var idInput = document.getElementById('idBox');
    var idRegex = /^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{6,12}$/;
    if ((idRegex).test(idInput)) {
        
        document.getElementById("validId").innerHTML = "";
    } else {
      
        document.getElementById("validId").innerHTML = "아이디는 6자리 이상 12자리 이하, 영어와 숫자 조합으로 작성해 주세요.";
    }
}
function validPw(){
    var password = document.getElementById('pwBox').value;
    var pwRegex = /^(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[!@#$%^&*(),.?":{}|<>])\S{6,16}$/
    if ((pwRegex).test(password)) {
        // 유효한 비밀번호인 경우
        document.getElementById("validPw").innerHTML = "";
    } else {
        // 유효하지 않은 비밀번호인 경우
        document.getElementById("validPw").innerHTML = "비밀번호는 6자리 이상 16자리 이하, 영어와 숫자 특수문자 조합으로 작성해 주십시오.";
    }
}
function validConfirmPw(){    
    var confirmPassword = document.getElementById('confirmPwBox').value;
    var pwRegex = /^(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[!@#$%^&*(),.?":{}|<>])\S{6,16}$/
    if ((pwRegex).test(confirmPassword)) {
        // 유효한 비밀번호인 경우
        document.getElementById("validConfirmPw").innerHTML = "";
    } else {
        // 유효하지 않은 비밀번호인 경우
        document.getElementById("validConfirmPw").innerHTML = "비밀번호는 6자리 이상 16자리 이하, 영어와 숫자 특수문자 조합으로 작성해 주십시오.";
    }
}
function validTel(){
    var numInput = document.getElementById('numBox');
    var phoneNumberRegex = /^\d+$/; 
    if ((pwRegex).test(password)) {
        // 유효한 비밀번호인 경우
        document.getElementById("validTel").innerHTML = "";
    } else {
        // 유효하지 않은 비밀번호인 경우
        document.getElementById("validTel").innerHTML = "전화번호는 11자리 숫자로만 입력해 주세요.";
    }
}
    </script>
</body>

</html>

