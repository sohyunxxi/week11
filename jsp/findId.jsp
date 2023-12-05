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
    <title>아이디 찾기</title>
    <link type="text/css" rel="stylesheet" href="../css/findId.css">
    <link type="text/css" rel="stylesheet" href="../css/element.css">

</head>
<body>
    <h1 id="mainFont">아이디 찾기</h1>
    <form action="findIdAction.jsp">
        <div id="loginBox">
            <div class="insertBox">
                <span id="nameFont">이름 : </span>
                <input id="idBox" name="name" type="text" length="14" maxlength="12">
            </div>
            <div class="insertBox">
                <span>전화번호 : </span>
                <input id="pwBox" name="tel" type="text" length="18" maxlength="16">
            </div>
            <button id="button">아이디 찾기</button>
        </div>
    </form>
    <script src="../js/makeAccount.js"></script>
</body>
</html>