<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.io.PrintWriter" %>

<%
    request.setCharacterEncoding("UTF-8");
    String username = request.getParameter("name");
    String idValue = request.getParameter("id");
    String pwValue = request.getParameter("pw");
    String tel = request.getParameter("tel");
    String team = request.getParameter("team");
    String company = request.getParameter("company");

    System.out.println(idValue);

    int accountSet = 0;
    //데이터베이스 통신 코드

    //Connector 파일 불러오기
    Class.forName("com.mysql.jdbc.Driver");

    // 데이터베이스 연결
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/week10","Sohyunxxi","1234");
   
    //SQL 만들기
    String sql = "INSERT INTO user (id, pw, name, tel, department, role) VALUES (?,?,?,?,?,?)";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, idValue);
    query.setString(2, pwValue);
    query.setString(3, username);
    query.setString(4, tel);
    query.setString(5, team);
    query.setString(6, company);

    accountSet = query.executeUpdate();
%>
<body>
    
    <% if(accountSet<0) { %>
   <script>
        //alert("회원가입에 실패하였습니다. 조건을 다시 잘 확인하고 작성해 주세요.");
        history.back();
    </script>

<% } else {%>
     <script>
    alert("회원가입에 성공하였습니다. 로그인을 해 주세요.");
    location.href="login.jsp";
    </script>
    <% } %>
</body>

