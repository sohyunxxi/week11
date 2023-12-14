<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.io.PrintWriter" %>

<%
    // 간단한 유효성 검사 함수들

    request.setCharacterEncoding("UTF-8");
    String username = request.getParameter("name");
    String idValue = request.getParameter("id");
    String pwValue = request.getParameter("pw");
    String tel = request.getParameter("tel");
    String team = request.getParameter("team");
    String company = request.getParameter("company");

    int accountSet = 0;

    // 백엔드 예외처리 -> 아이디 중복인지 확인하기.
    if   (username == null || idValue == null || pwValue == null || tel == null) {
        out.println("<p>입력값이 부족합니다.</p>");
    } else {
        if (!(username.matches("^[a-zA-Z가-힣]{2,50}$"))) {
            out.println("<p>이름은 2글자 이상 50글자 이내의 한글 또는 영어만 가능합니다.</p>");
        } else if (!(idValue.matches("^[a-zA-Z0-9]{6,12}$"))) {
            out.println("<p>ID는 6글자 이상 12글자 이하의 영어와 숫자로만 가능합니다.</p>");
        } else if (!(pwValue.matches("^(?=.*[a-zA-Z])(?=.*\\d)(?=.*[!@#$%^&*(),.?\":{}|<>])\\S{6,16}$"))) {
            out.println("<p>비밀번호는 6글자 이상 16글자 이하의 영어, 숫자, 특수문자를 포함해야 합니다.</p>");
        } else if (!(tel.matches("^[0-9]+$"))) {
            out.println("<p>전화번호는 숫자만 가능합니다.</p>");
        } else {

            try {
                //Connector 파일 불러오기
                Class.forName("com.mysql.jdbc.Driver");
                // 데이터베이스 연결
                Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/week10", "Sohyunxxi", "1234");

                // SQL 만들기
                String sql = "INSERT INTO user (id, pw, name, tel, department, role) VALUES (?,?,?,?,?,?)";
                PreparedStatement query = connect.prepareStatement(sql);
                query.setString(1, idValue);
                query.setString(2, pwValue);
                query.setString(3, username);
                query.setString(4, tel);
                query.setString(5, team);
                query.setString(6, company);

                // 데이터베이스에 삽입
                accountSet = query.executeUpdate();
                if (accountSet > 0) {
                    // 회원 가입이 성공했을 때만 출력
                    out.println("<p>회원 가입이 완료되었습니다.</p>");
                    out.println("<p>이름: " + username + "</p>");
                    out.println("<p>ID: " + idValue + "</p>");
                    out.println("<p>전화번호: " + tel + "</p>");
                    out.println("<p>팀: " + (team != null ? team : "없음") + "</p>");
                    out.println("<p>회사: " + (company != null ? company : "없음") + "</p>");
                } else {
                    out.println("회원가입에 실패하였습니다. 관리자에게 연락해 주세요.");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("회원가입에 실패하였습니다. 관리자에게 연락해 주세요.");
            }
        }
    }

%>

<body>
    <% if (accountSet < 0) { %>
        <script>
            alert("회원가입에 실패하였습니다. 조건을 다시 잘 확인하고 작성해 주세요.");
            history.back();
        </script>
    <% } else if (accountSet > 0) { %>
        <script>
            alert("회원가입에 성공하였습니다. 로그인을 해 주세요.");
            location.href = "../jsp/login.jsp";
        </script>
    <% } %>
</body>
