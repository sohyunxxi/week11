<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%
    request.setCharacterEncoding("utf-8");

    ResultSet rs = null;
    String message ="";
    String redirectPage="";

    String name = request.getParameter("name");
    String tel = request.getParameter("tel");

    // 데이터베이스 통신 코드

    //Connector 파일 불러오기
    Class.forName("com.mysql.jdbc.Driver");

    // 데이터베이스 연결
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/week10","Sohyunxxi","1234");

    // SQL 만들기
    String sql = "SELECT id FROM user WHERE tel=? AND name=?";
    PreparedStatement query = connect.prepareStatement(sql);

    if (name == null && tel == null || (name.equals("") && tel.equals(""))) {
        out.println("<p>이름과 전화번호를 입력해주세요.</p>");
    } else if (name != null && !name.matches("^[a-zA-Z가-힣]{2,50}$")) {
        out.println("<p>이름은 한글과 영어로 2자부터 50자 사이로 입력해주세요.</p>");
    } else if (tel != null && !tel.matches("^[0-9]{11}$")) {
        out.println("<p>전화번호는 숫자로만 11자 입력해주세요.</p>");
    } else {
        // query 전송
        query.setString(1, tel);
        query.setString(2, name);  
        rs = query.executeQuery();
        
        if (rs.next()) {
            // id 변수 선언 및 값 할당
            String id = rs.getString("id");
            message = "아이디 : " + id;
            redirectPage = "../jsp/login.jsp";
        } else { // 아이디 예외처리 -> 전화번호는 숫자만, 이름은 한글 영어 50자까지
            message = "계정이 존재하지 않습니다!";
            redirectPage = "../jsp/login.jsp";
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
    <script src="../js/makeAccount.js"></script>
</body>