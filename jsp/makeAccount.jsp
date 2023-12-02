<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>

<%
    request.setCharacterEncoding("utf-8");
    String name = (String)session.getAttribute("userName");
    String id = (String)session.getAttribute("userId");
    String pw = (String)session.getAttribute("userPw");
    String role = (String)session.getAttribute("role");
    String team =(String)session.getAttribute("team");
    String tel = (String)session.getAttribute("tel");
    int idx = (Integer)session.getAttribute("idx");
//try catch 넣기

    if (name != null){
        %>
            <script>
                alert("이미 로그인되어 있습니다. 일정 페이지로 이동합니다.");
                window.location.href = "mainCalendar.jsp"; // 아이디랑 비밀번호 넘기기? idx 넘기기?
            </script>
        <%
            }
        %>

//회원가입 : onchange 걸어서 조건 명시
//틀렸는데 로그인 하면 focus()걸어서 틀린 부분 박스로 표현하기


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
    <form action="makeAccountAction.jsp" >
        <div id="loginBox">
            <div class="insertBox">
                <span id="nameFont" class="fontSize">이름 : </span>
                <input id="nameBox" placeholder="필수 입력 사항입니다." name="name" type="text" length="14" maxlength="12">
            </div>
            <div class="insertBox" id="idAppendBox">
                <span id="idFont" class="fontSize">아이디 : </span>
                <input id="idBox" placeholder="4~10자리 사이" name="id" type="text" length="18" maxlength="16">
                <button type="button" id="checkButton" onclick="checkIdDuplicate()">중복확인</button>
                <input type="hidden" name="idDuplication" value="unchecked">
            </div>
            <div class="insertBox">
                <span class="fontSize">비밀번호 : </span>
                <input id="pwBox" placeholder="4~16자리 사이" name="pw" type="password" length="18" maxlength="16">
            </div>
            <div class="insertBox">
                <span class="fontSize">재확인 비밀번호 : </span>
                <input id="comfirmPwBox" placeholder="4~16자리 사이" name="confirmPw" type="password" length="18" maxlength="16">
            </div>
            <div class="insertBox">
                <span class="fontSize">전화번호 : </span>
                <input id="numBox" placeholder="(-) 없이 입력해주세요." name="tel" type="text" length="18" maxlength="16">
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
        <button id="useIdButton" onclick="useId()">아이디 사용하기</button>
    </div>
    <script src="../js/makeAccount.js"></script>
</body>

</html>