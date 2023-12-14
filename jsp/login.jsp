<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<%
    request.setCharacterEncoding("utf-8");
    String name = (String)session.getAttribute("userName");
    String id = (String)session.getAttribute("userId");
    String pw = (String)session.getAttribute("userPw");
    String role = (String)session.getAttribute("role");
    String team = (String)session.getAttribute("team");
    String tel = (String)session.getAttribute("tel");
    Integer idx = (Integer)session.getAttribute("idx");

    if (name != null && id != null && pw != null && role != null && team != null && tel != null  && idx != null && idx > 0)
     {
%>
    <script>
        alert("이미 로그인되어 있습니다. 일정 페이지로 이동합니다.");
        window.location.href = "mainCalendar.jsp"; // 아이디랑 비밀번호 넘기기? idx 넘기기?
    </script>
<%
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인 페이지</title>
    <link type="text/css" rel="stylesheet" href="../css/login.css">
    <link type="text/css" rel="stylesheet" href="../css/element.css">
</head>
<body>
    <h1 id="mainFont">LOG IN</h1>
    <form action="../action/loginAction.jsp" method="post">
        <div id="loginBox">
            <div class="insertBox">
                <span>아이디 : </span>
                <input id="idBox" name="id" type="text" length="14" maxlength="12">
            </div>
            <div class="insertBox">
                <span>비밀번호 : </span>
                <input id="pwBox" name="pw" type="password" length="18" maxlength="16">
            </div>
            <input type="button" id="button" value="로그인" onclick="checkExceptionEvent()">
        </div>
    </form>
    <div id="linkBox">
        <a class="linkFont" href="findId.jsp">아이디 찾기</a>
        <a id="middleLinkFont" href="findPw.jsp">비밀번호 찾기</a>
        <a class="linkFont" href="makeAccount.jsp">회원가입</a>
    </div>
</body>
<script>
   function checkExceptionEvent() {
    // 정규표현식 추가하기
    // 아이디 6~12자리, 비밀번호 6~16자리
    var idInput = document.getElementById('idBox');
    var pwInput = document.getElementById('pwBox');
    var idRegex = /^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{6,12}$/;  // 영어와 숫자를 포함하고, 6자리 이상 12자리 이하 - 아이디 정규표현식
    var pwRegex = /^(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[!@#$%^&*(),.?":{}|<>])\S{6,16}$/; // 영어, 숫자, 특수문자 포함하기 6자리 이상 16자리 이하 - 비밀번호 정규표현식

    if (!idRegex.test(idInput.value.trim())) {
        alert('아이디는 6자리 이상 12자리 이하이며 영어와 숫자를 포함해야 합니다. 다시 입력해 주세요.');
        idInput.focus();
    } else if (!pwRegex.test(pwInput.value.trim())) {
        alert('비밀번호는 6~16자리이며, 숫자, 영어, 특수문자가 각각 하나 이상 포함되어야 합니다. 다시 입력해 주세요');
        pwInput.focus();
    } else {
        // location.href="../jsp/loginAction.jsp?year=" + year + "&month=" + month + "&day=" + day;
        location.href="../action/loginAction.jsp?id="+idInput.value+"&pw="+pwInput.value;
    }
} 
</script>
</html>
