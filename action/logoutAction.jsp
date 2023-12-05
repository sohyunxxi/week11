<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%
    session.invalidate(); // 세션 무효화 (로그아웃)
    response.sendRedirect("../jsp/login.jsp");
    
%>

