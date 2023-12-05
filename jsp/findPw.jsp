<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>

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
    <form action="findPwAction.jsp">
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
            <button id="button" >비밀번호 찾기</button>
        </div>
    </form>
    <script src="../js/makeAccount.js"></script>
</body>
</html>