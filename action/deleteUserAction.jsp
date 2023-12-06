<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
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
    int idx = (Integer)session.getAttribute("idx");
    
        Class.forName("com.mysql.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/week10", "Sohyunxxi", "1234");

        // SQL 만들기
        String sql = "DELETE FROM user WHERE user_idx = ?";
        PreparedStatement query = connect.prepareStatement(sql);
        query.setInt(1, idx); // Use setInt for an integer parameter

        // query 전송
        query.executeUpdate();
        session.invalidate(); // 세션 무효화 (로그아웃)

%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <script>
        alert("회원 정보를 삭제합니다. 안녕~");
        location.href = "../jsp/login.jsp";
    </script>
</body>
