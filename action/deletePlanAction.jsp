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

    int event_idx=  Integer.parseInt(request.getParameter("eventIdx"));
    
    
    Connection connect = null;

        Class.forName("com.mysql.jdbc.Driver");
        connect = DriverManager.getConnection("jdbc:mysql://localhost/week10", "Sohyunxxi", "1234");

        // SQL 만들기
        String sql = "DELETE FROM event WHERE user_idx = ? AND event_idx=? ";
        PreparedStatement query = connect.prepareStatement(sql);
        query.setInt(1, idx);
        query.setInt(2, event_idx);


        // query 전송
        query.executeUpdate();
        response.sendRedirect("../jsp/mainCalendar.jsp");
   
%>