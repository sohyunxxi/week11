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
    <title>비밀번호 찾기</title>
    <link type="text/css" rel="stylesheet" href="../css/findPw.css">
    <link type="text/css" rel="stylesheet" href="../css/element.css">

</head>
<body>
    <h1 id="mainFont">비밀번호 찾기</h1>
    <form action="../action/findPwAction.jsp">
        <div id="loginBox">
            <div class="insertBox">
                <span id="nameFont">이름 : </span>
                <input id="nameBox" name="name" type="text" length="14" maxlength="12">
            </div>
            <div class="insertBox">
                <span>아이디 : </span>
                <input id="idBox" name="id" type="text" length="18" maxlength="16">
            </div>
            <div class="insertBox">
                <span>전화번호 : </span>
                <input id="pwBox" name="tel" type="text" length="18" maxlength="16">
            </div>
            <button id="button" type="button" onclick="searchPw()">비밀번호 찾기</button>
        </div>
    </form>
    <img src="../image/back.png" id="backImg" type="button" onclick="moveBackEvent()">

    <script src="../js/makeAccount.js"></script>
    <script>
        function moveBackEvent() {
            window.history.back();
        }
    </script>
</body>
</html>