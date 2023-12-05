<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>

<%
    request.setCharacterEncoding("utf-8");
    String sessionName = (String)session.getAttribute("userName");
    String sessionId = (String)session.getAttribute("userId");
    String sessionPw = (String)session.getAttribute("userPw");
    String sessionRole = (String)session.getAttribute("role");
    String sessionTeam =(String)session.getAttribute("team");
    int sessionIdx = (Integer)session.getAttribute("idx");
    String sessionTel = (Integer)session.getAttribute("tel");

    if (sessionName==null){
        response.sendRedirect("login.jsp");
    }

    String u_Pw = request.getParameter("pw");
    String u_Tel = request.getParameter("tel");
    String u_Role = request.getParameter("company");
    String u_Team = request.getParameter("team");
    int accountSet = 0;

    Class.forName("com.mysql.jdbc.Driver");

    // 데이터베이스 연결
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/week10","Sohyunxxi","1234");

    //SQL 만들기
    String sql = "UPDATE user SET pw = ?, tel = ?, department = ?, role = ? WHERE user_idx = ?";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, u_Pw);
    query.setString(2, u_Tel);
    query.setString(3, u_Team);
    query.setString(4, u_Role);
    query.setInt(5, sessionIdx);
    accountSet = query.executeUpdate();

    session.setAttribute("userPw", u_Pw);
    session.setAttribute("idx", sessionIdx);
    session.setAttribute("tel", u_Tel);
    session.setAttribute("team", u_Team);
    session.setAttribute("role", u_Role);

    response.sendRedirect("showInfo.jsp");
   
%>

