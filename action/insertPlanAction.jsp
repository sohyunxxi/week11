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
    Integer idx = (Integer)session.getAttribute("idx");
    int teamIdx = 0;
    
    Integer sessionTeamIdx = (Integer)session.getAttribute("teamIdx");
    if (sessionTeamIdx != null) {
        teamIdx = sessionTeamIdx;
    }
    
    if (name == null || id == null || pw == null || role == null || team == null || tel == null || idx ==null)            {
        %>
        <script>
        alert("로그인 상태가 아닙니다. 서비스를 이용할려면 로그인 해 주세요.");
        window.location.href = "../jsp/login.jsp"; // 아이디랑 비밀번호 넘기기? idx 넘기기?
        </script>
        <%
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
        if(teamIdx==0){
            query.setInt(1, idx);
        }
        else{
            %>
            <script>
                alert("다른 사람의 일정을 추가할 수 없습니다.");
            </script><%
            out.println("다른 사람의 일정을 추가할 수 없습니다.");
        }
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
            } 
            else {
                out.println("일정 입력에 실패하였습니다.다시 시도해 보세요.");
        }
    } catch (SQLException e) {
        e.printStackTrace();  // 또는 로그에 출력
        out.println("Error: " + e.getMessage());
    }
%>
