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
    <title>내 정보 수정</title>
    <link type="text/css" rel="stylesheet" href="../css/updateInfo.css">
    <link type="text/css" rel="stylesheet" href="../css/element.css">

</head>

<body>
    <header>
        <h1 id="mainFont">내 정보 수정</h1>
    </header>
    <form action="../action/updateInfoAction.jsp">
        <main>
            <div id="loginBox">
                <div class="insertBox">
                    <span id="nameFont">이름 : </span>
                    <span id="nameFont"><%=name %></span>
                </div>
                <div class="insertBox">
                    <span id="idFont">아이디 : </span>
                    <span id="nameFont"><%=id %></span>

                </div>
                <div id="pwInsertBox">
                    <span id="pwFont">비밀번호 : </span>
                    <input id="pwBox" name="pw" type="password" placeholder="4자 이상 16자 이하로 입력해주세요." value="<%=pw %>"></span>
                </div>
                <div id="confirmInsertBox">
                    <span>재확인 비밀번호 : </span>
                    <input id="confirmPwBox"  name="confirmPw"type="password" placeholder="4자 이상 16자 이하로 입력해주세요." value="<%=pw %>"></span>
                </div>
                <div id="telInsertBox">
                    <span id="telFont">전화번호 : </span>
                    <input id="telBox" name="tel" value="<%=tel %>" placeholder="-(하이픈)은 제외한 숫자만 입력해주세요."></span>
                </div>
                <div id="teamInsertBox">
                    <span id="selectTeam">부서명 : </span>
                    <div class="selectFont">
                        <input type="radio" name="team" value="디자인"> 디자인
                        <input type="radio" name="team" value="개발"> 개발
                    </div>
                </div>
                <div id="occInsertBox">
                    <span id="selectOcc">직급선택 : </span>
                    <div id="selectBox">
                        <input type="radio" name="company" value="팀장"> 팀장
                        <input type="radio" name="company" value="팀원"> 팀원
                    </div>
                </div>
            </div>
        </main>
        <footer>
            <img src="../image/back.png" id="backImg" onclick="moveBackEvent()">
                <div id="buttonBox">
                    <button class="footerButtons" type="button" onclick="updateEvent()">완료</button>
                </div>
        </footer>
    </form>
    <script src="../js/showInfo.js"></script>
    <script>
        function checkRadioButtons() {
            var role = "<%= (String)session.getAttribute("role") %>";
            var team = "<%= (String)session.getAttribute("team") %>";

            if (role && team) {
                var teamRadioButtons = document.getElementsByName("team");
                for (var i = 0; i < teamRadioButtons.length; i++) {
                    if (teamRadioButtons[i].value === team) {
                        teamRadioButtons[i].checked = true;
                        break;
                    }
                }

                var roleRadioButtons = document.getElementsByName("company");
                for (var j = 0; j < roleRadioButtons.length; j++) {
                    if (roleRadioButtons[j].value === role) {
                        roleRadioButtons[j].checked = true;
                        break;
                    }
                }
            }
        }

        // 페이지 로드 시 실행
        checkRadioButtons();
    </script>
</body>

</html>