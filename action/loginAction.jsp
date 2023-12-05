<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import="java.util.Calendar" %>


<%
    request.setCharacterEncoding("utf-8");
    String idValue = request.getParameter("id");
    String pwValue = request.getParameter("pw");

    ResultSet rs= null;

    //이미 로그인되어있는경우 처리하기
    String id = (String)session.getAttribute("id");
    String name = (String)session.getAttribute("name");
    if(id != null&& name!=null){
%>
    <script>
        alert("이미 로그인하고 있습니다. \n 일정 페이지로 이동합니다.");
        location.href = "../mainCalendar.jsp?idValue=" + '<%=id%>' + "&nameValue=" + '<%=name%>';
    </script>

<%
}
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/week10","Sohyunxxi","1234");
   
    String sql = "SELECT * FROM user WHERE id= ? AND pw = ?";
  
    PreparedStatement query = connect.prepareStatement(sql);
  
    query.setString(1,idValue); 
    query.setString(2,pwValue); 
    
    rs=query.executeQuery();
    if(rs.next()){
        String dbId = rs.getString("id");
        String dbpw = rs.getString("pw");
        int idx = rs.getInt("user_idx");
        String tel = rs.getString("tel");
        String team = rs.getString("department");
        String role = rs.getString("role");
        String name = rs.getString("name");

        if(idValue.equals(dbId)&&pwValue.equals(dbpw)){//db상의 아이디 비밀번호와 입력한 값이 둘 다 같은 경우
            //세션에 저장
            session.setAttribute("userId", idValue);
            session.setAttribute("userPw", pwValue);
            session.setAttribute("idx", idx);
            session.setAttribute("tel", tel);
            session.setAttribute("team", team);
            session.setAttribute("role", role);
            session.setAttribute("userName", name);
            response.sendRedirect("mainCalendar.jsp");
            response.sendRedirect("mainCalendar.jsp");

            
            //date 변수와 Calendar 변수의 차이
            Calendar cal = Calendar.getInstance();

            // 년, 월, 일을 각각 변수에 저장
            int year = cal.get(Calendar.YEAR);
            int month = cal.get(Calendar.MONTH) + 1; // 월은 0부터 시작하므로 1을 더해줍니다.
            int day = cal.get(Calendar.DAY_OF_MONTH);
            session.setAttribute("year", year);
            session.setAttribute("month", month);
            session.setAttribute("day", day);

        } 
        else {
            //로그인 실패
            %>
            <script>
                alert("로그인에 실패하였습니다.다시 시도해 주세요.");
                history.back();
            </script>
        
        <%
        }
    }
    else {
        //사용자가 존재하지 않음
        %>
    <script>
        alert("사용자가 존재하지 않습니다. 서비스를 이용할려면 회원가입을 해주세요.");
        location.href = "login.jsp";
    </script>

<%
    }
%>
