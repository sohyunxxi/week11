<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Timestamp" %>

<%
    request.setCharacterEncoding("utf-8");
    String name = (String)session.getAttribute("userName");
    String id = (String)session.getAttribute("userId");
    String pw = (String)session.getAttribute("userPw");
    String role = (String)session.getAttribute("role");
    String team = (String)session.getAttribute("team");
    String tel = (String)session.getAttribute("tel");
    int idx = (Integer)session.getAttribute("idx");
    
    if (name == null) {
        response.sendRedirect("../jsp/login.jsp");
    }

    try {
        String eventContent = request.getParameter("planText");
        String startTime = request.getParameter("planTime");
        String startDate = request.getParameter("hiddenDate");

        out.println("eventContent: " + eventContent);
        out.println("startTime: " + startTime);
        out.println("startDate: " + startDate);

        Class.forName("com.mysql.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/week10", "Sohyunxxi", "1234");

        String sql = "INSERT INTO event (user_idx, event_content, start_time) VALUES (?, ?, ?)";
        PreparedStatement query = connect.prepareStatement(sql);

        query.setInt(1, idx);
        query.setString(2, eventContent);
        Timestamp timestamp = Timestamp.valueOf(startDate + " " + startTime + ":00");
        query.setTimestamp(3, timestamp);

        int result = query.executeUpdate();

        if (result > 0) {
      %>
      <script>
        // 브라우저의 뒤로 가기 동작을 트리거
        window.close();

    </script><%
            } else {
            out.println("Insert failed");
        }
    } catch (SQLException e) {
        e.printStackTrace();  // 또는 로그에 출력
        out.println("Error: " + e.getMessage());
    }
%>