<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%
    String name = (String)session.getAttribute("userName");
    if(name!=null){ //로그인 되어있는 경우
        session.invalidate(); // 세션 무효화 (로그아웃)
        response.sendRedirect("login.jsp");
    }
    else{ //로그인이 되어있지 않은 경우
        response.sendRedirect("login.jsp");
    }
    
%>

