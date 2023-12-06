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
    String sessionTel = (String)session.getAttribute("tel");

    if (sessionName==null){
        response.sendRedirect("login.jsp");
    }

    String u_Pw = request.getParameter("pw");
    String u_confirmPw = request.getParameter("confirmPw");
    String u_Tel = request.getParameter("tel");
    String u_Role = request.getParameter("company");
    String u_Team = request.getParameter("team");
    int accountSet = 0;
//예외처리 하기
if   ( u_Pw == null || u_confirmPw == null||u_Tel == null||u_Role == null || u_Team == null) {
    out.println("<p>입력값이 부족합니다.</p>");
} else {
    // 여기서 추가적인 유효성 검사를 수행합니다.
    if (!(u_Pw.matches("^(?=.*[a-zA-Z])(?=.*\\d)(?=.*[!@#$%^&*(),.?\":{}|<>])\\S{6,16}$"))) {
        out.println("<p>비밀번호는 6글자 이상 16글자 이하의 영어, 숫자, 특수문자를 포함해야 합니다.</p>");
    } else if (!(u_confirmPw.matches("^(?=.*[a-zA-Z])(?=.*\\d)(?=.*[!@#$%^&*(),.?\":{}|<>])\\S{6,16}$"))) {
        out.println("<p>비밀번호는 6글자 이상 16글자 이하의 영어, 숫자, 특수문자를 포함해야 합니다.</p>");
    } else if (!(u_Tel.matches("^[0-9]+$"))) {
        out.println("<p>전화번호는 숫자만 가능합니다.</p>");
    } else {

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

        response.sendRedirect("../jsp/showInfo.jsp");
    }
}
%>

