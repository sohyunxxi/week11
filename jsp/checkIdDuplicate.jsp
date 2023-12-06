<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>

<%
    request.setCharacterEncoding("UTF-8");
    String idValue = request.getParameter("id");
    ResultSet rs = null;

    // Database connection
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/week10", "Sohyunxxi", "1234");

    String sql = "SELECT * FROM user WHERE id=?";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, idValue);
    rs = query.executeQuery();

    boolean isDuplicate = rs.next();

    response.setContentType("text/plain");
    response.setCharacterEncoding("UTF-8");
    response.getWriter().write(String.valueOf(isDuplicate));
%>

