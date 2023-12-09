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
    Integer idx = (Integer)session.getAttribute("idx");
    Integer year = (Integer)session.getAttribute("year");
    Integer month = (Integer)session.getAttribute("month");
    Integer day = (Integer)session.getAttribute("day");

    
    if (name == null || id == null || pw == null || role == null || team == null || tel == null || idx ==null)
    {
        %>
        <script>
        alert("로그인 상태가 아닙니다. 서비스를 이용할려면 로그인 해 주세요.");
        window.location.href = "login.jsp"; // 아이디랑 비밀번호 넘기기? idx 넘기기?
        </script>
        <%
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
