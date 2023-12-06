<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.Calendar" %>

<%
    request.setCharacterEncoding("utf-8");
    String name = (String)session.getAttribute("userName");
    String id = (String)session.getAttribute("userId");
    String pw = (String)session.getAttribute("userPw");
    String role = (String)session.getAttribute("role");
    String team =(String)session.getAttribute("team");
    String tel = (String)session.getAttribute("tel");
    int idx = (Integer)session.getAttribute("idx");
    int year = (Integer)session.getAttribute("year");
    int month = (Integer)session.getAttribute("month");
    int day = (Integer)session.getAttribute("day");

    if (name == null || id == null || pw == null || role == null || team == null || tel == null || idx <= 0 || String.valueOf(idx).trim().isEmpty()) {      
        response.sendRedirect("login.jsp");
    }
    else{
        int eventYear = (request.getParameter("yearHidden")  != null) ? Integer.parseInt(request.getParameter("yearHidden")) : year;
        int eventMonth = (request.getParameter("selectedMonth") != null) ? Integer.parseInt(request.getParameter("selectedMonth")) : month;
        session.setAttribute("year", eventYear);
        session.setAttribute("month", eventMonth);

        response.sendRedirect("mainCalendar.jsp");

    }
    //버튼에다가도 폼 만들어서 클릭한 버튼이면 거기에 input hidden 만들어서 월 값 넘기기
    //
%>
