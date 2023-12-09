<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>

<%
    request.setCharacterEncoding("utf-8");

    ResultSet rs = null;
    String message = "";
    String redirectPage = "";

    String name = request.getParameter("name");
    String id = request.getParameter("id");
    String tel = request.getParameter("tel");
    String pw = request.getParameter("pw");

    // 데이터베이스 통신 코드

    // Connector 파일 불러오기
    Class.forName("com.mysql.jdbc.Driver");

    // 데이터베이스 연결
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/week10", "Sohyunxxi", "1234");

    // SQL 만들기
    String sql = "SELECT pw FROM user WHERE name=? AND id=? AND tel=?";
    PreparedStatement query = connect.prepareStatement(sql);
    
    if (name == null && tel == null && id==null || (name.equals("") && tel.equals("")&& id.equals(""))) {
        out.println("<p>이름과 아이디, 전화번호를 입력해주세요.</p>");
    } else if (name != null && !name.matches("^[a-zA-Z가-힣]{2,50}$")) {
        out.println("<p>이름은 한글과 영어로 2자부터 50자 사이로 입력해주세요.</p>");
    } else if (tel != null && !tel.matches("^[0-9]{11}$")) {
        out.println("<p>전화번호는 숫자로만 11자 입력해주세요.</p>");
    } else if (id != null && !id.matches("^(?=.*[a-zA-Z])(?=.*\\d)[a-zA-Z\\d]{6,12}$")) {
        out.println("<p>아이디는 영문 숫자 조합으로 6자리이상 16자리 이하 입력해주세요. </p>");
    } else {
        // query 전송
        query.setString(1, name);
        query.setString(2, id);
        query.setString(3, tel);
        
        rs = query.executeQuery();
        
        if (rs.next()) {
            pw = rs.getString("pw");
            message = "비밀번호 : " + pw;
            redirectPage = "../jsp/login.jsp";
        } else {
            message = "이름, 아이디, 전화번호가 틀렸거나 계정이 존재하지 않습니다! 다시 입력해 주세요.";
            redirectPage = "../jsp/findPw.jsp";
        }
    }
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <script>
        alert("<%= message %>"); // 메시지 출력
        window.location = "<%= redirectPage %>"; // 해당 페이지로 리디렉트
    </script>
</body>
