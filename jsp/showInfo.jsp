<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>

<%
    request.setCharacterEncoding("utf-8");
    String name = (String)session.getAttribute("userName");
    String id = (String)session.getAttribute("userId");
    String pw = (String)session.getAttribute("userPw");
    String role = (String)session.getAttribute("role");
    String team =(String)session.getAttribute("team");
    String tel = (String)session.getAttribute("tel");
    Integer idx = (Integer)session.getAttribute("idx");

   
    if (name == null || id == null || pw == null || role == null || team == null || tel == null || idx ==null)
    {
        %>
        <script>
        alert("로그인 상태가 아닙니다. 서비스를 이용할려면 로그인 해 주세요.");
        window.location.href = "login.jsp"; // 아이디랑 비밀번호 넘기기? idx 넘기기?
        </script>
        <%
        }
    
%>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내 정보 보기</title>
    <link type="text/css" rel="stylesheet" href="../css/showInfo.css">
    <link type="text/css" rel="stylesheet" href="../css/element.css">

</head>

<body>
    <header>
        <h1 id="mainFont">내 정보 보기</h1>
    </header>
    <main>
        <form>
            <div id="loginBox">
                <div class="insertBox">
                    <span class="nameFont">이름 : </span>
                    <span class="nameFont"><%=name%> </span>
                </div>
                <div class="insertBox">
                    <span id="idFont">아이디 : </span>
                    <span class="nameFont"><%=id%></span>

                </div>
                <div class="insertBox">
                    <span id="pwFont">비밀번호 : </span>
                    <span id="hiddenPW"><%=pw%></span>
                    <button id="checkButton" type="button" onclick="showPwEvent()">보기</button>
                </div>
                <div class="insertBox">
                    <span id="telFont">전화번호 : </span>
                    <span id="idFont"><%=tel%></span>
                </div>
                <div id="teamBox" class="insertBox">
                    <span id="selectTeam">부서명 : </span>
                    <div><%=team%></div>
                </div>
                <div id="leaderBox" class="insertBox">
                    <span id="selectOcc">직급선택 : </span>
                    <div><%=role%></div>
                </div>
            </div>
        </form>
    </main>
    <footer>
        <img src="../image/back.png" id="backImg" type="button" onclick="moveBackEvent()">
        <div id="buttonBox">
            <form action="updateInfo.jsp">
                <button class="footerButtons">
                    수정
                </button>
            </form>
            <form action="../action/deleteUserAction.jsp">
                <button class="footerButtons">탈퇴</button>
            </form>
        </div>
    </footer>
    
    <script src="../js/showInfo.js"></script>
</body>

</html>