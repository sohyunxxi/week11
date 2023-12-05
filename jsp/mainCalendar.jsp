<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.sql.Timestamp" %>

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

    int eventYear=Integer.parseInt(request.getParameter("eventYear"));
    int eventMonth=Integer.parseInt(request.getParameter("eventYear"));
    int eventDay=Integer.parseInt(request.getParameter("eventYear"));

    ArrayList<String> nameList= new ArrayList<String>();
    ArrayList<String> idList= new ArrayList<String>();
    ArrayList<Integer> idxTeamList= new ArrayList<Integer>();
    ArrayList<String> timeList = new ArrayList<>();
    ArrayList<String> dayList = new ArrayList<>();

    ArrayList<String> eventList = new ArrayList<>();
    ArrayList<Integer> eventIdx = new ArrayList<>();

    int showTeamIdx=0;

    if (name == null || id == null || pw == null || role == null || team == null || tel == null || idx == null || idx.equals("") || !(idx instanceof Integer) ||
        year == null || month == null || day == null || !(year instanceof Integer) || !(month instanceof Integer) || !(day instanceof Integer)){
            
        response.sendRedirect("login.jsp");
    }
    else{
        Class.forName("com.mysql.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/week10","Sohyunxxi","1234");

        if(role=="팀장"){ //팀장인 경우 팀원들의 정보 가져오기
            String sql = "SELECT user_idx, id, name FROM user WHERE department= ? AND role = '팀원'";
            PreparedStatement query = connect.prepareStatement(sql);
        
            query.setString(1,team);
        
            ResultSet rs= null;
            rs=query.executeQuery();
            ResultSet result = query.executeQuery();
        
            while(result.next()){ // next가 가능할 때까지 반복문을 돌린다.
                int t_idx = Integer.parseInt(result.getString(1));
                String t_id=result.getString(2);// 첫번째 컬럼
                String t_name=result.getString(3);// 두번째 컬럼
                idxTeamList.add(t_idx);
                nameList.add("\""+t_name +"\"");
                idList.add("\""+t_id+"\"");
            }
        }
    
        if(eventYear==!= null && !eventYear.isEmpty()||eventMonth==!= null && !eventMoneth.isEmpty()||eventDay==!= null && !eventDay.isEmpty()){
            eventYear=year;
            eventMonth=month;
            eventDay=day;

            //해당 달에 해당하는 이벤트만 가져오기
            String eventSql = ""SELECT event_idx, start_time, event_content FROM event WHERE user_idx = ? AND YEAR(start_time) = ? AND MONTH(start_time) = ? " +
            "ORDER BY start_time ASC";

            PreparedStatement eventQuery = connect.prepareStatement(eventSql);
            eventQuery.setInt(1, year);
            eventQuery.setInt(1, month); 
    
            ResultSet eventRs = eventQuery.executeQuery();
    
            while (eventRs.next()) {
                int e_eventIdx = eventRs.getInt(1);
                LocalDateTime e_time = eventRs.getObject(2, LocalDateTime.class);
                
                // 년, 월, 일 추출
                int year = e_time.getYear();
                int month = e_time.getMonthValue();
                int day = e_time.getDayOfMonth();
            
                String formattedTimeDay = String.format("%04d-%02d-%02d", year, month, day);
                String formattedTime = String.format("%02d:%02d", e_time.getHour(), e_time.getMinute());
                String e_eventContent = eventRs.getString(3);
    
                eventIdx.add(e_eventIdx);  // event_idx를 ArrayList<Integer>에 저장
                timeList.add("\"" + formattedTime + "\"");
                dayList.add("\"" + formattedTimeDay + "\"");
    
                eventList.add("\"" + e_eventContent + "\"");
            }
    
        }
        else{
            //해당 달에 해당하는 이벤트만 가져오기
            String eventSql = ""SELECT event_idx, start_time, event_content FROM event " +
            "WHERE user_idx = ? AND YEAR(start_time) = ? AND MONTH(start_time) = ? " +
            "ORDER BY start_time ASC";
            PreparedStatement eventQuery = connect.prepareStatement(eventSql);
            eventQuery.setInt(1, eventYear);
            eventQuery.setInt(1, eventMonth);
        
        
            ResultSet eventRs = eventQuery.executeQuery();
        
            while (eventRs.next()) {
                int e_eventIdx = eventRs.getInt(1);
                LocalDateTime e_time = eventRs.getObject(2, LocalDateTime.class);
                
                // 년, 월, 일 추출
                int year = e_time.getYear();
                int month = e_time.getMonthValue();
                int day = e_time.getDayOfMonth();
            
                String formattedTimeDay = String.format("%04d-%02d-%02d", year, month, day);
                String formattedTime = String.format("%02d:%02d", e_time.getHour(), e_time.getMinute());
                String e_eventContent = eventRs.getString(3);
        
                eventIdx.add(e_eventIdx);  // event_idx를 ArrayList<Integer>에 저장
                timeList.add("\"" + formattedTime + "\"");
                dayList.add("\"" + formattedTimeDay + "\"");
                eventList.add("\"" + e_eventContent + "\"");
            }
        
        }
    }
    
    
    

    
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>메인페이지</title>
    <link type="text/css" rel="stylesheet" href="../css/mainCalendar.css">
    <link type="text/css" rel="stylesheet" href="../css/element.css">

</head>

<body onload="presentMonth()">
    <header>
        <div id="yearBox">
            <button onclick="previousYearEvent()" class="yearButton">
                <img class="yearImage" src="../image/year_left.png">
            </button>
                <form action="makeEvent.jsp">
                    <h1 id="year" name="year"><%=year %></h1>
                    <input type="hidden" id="yearHidden" name="year" value="2023">
                </form>
            <button onclick="nextYearEvent()" class="yearButton"><img class="yearImage" src="../image/year_right.png"></button>
        </div>
            <div id="months">
                <button class="monthButton" value="1" onclick="daysOfMonth(this)">1</button>
                <button class="monthButton" value="2" onclick="daysOfMonth(this)">2</button>
                <button class="monthButton" value="3" onclick="daysOfMonth(this)">3</button>
                <button class="monthButton" value="4" onclick="daysOfMonth(this)">4</button>
                <button class="monthButton" value="5" onclick="daysOfMonth(this)">5</button>
                <button class="monthButton" value="6" onclick="daysOfMonth(this)">6</button>
                <button class="monthButton" value="7" onclick="daysOfMonth(this)">7</button>
                <button class="monthButton" value="8" onclick="daysOfMonth(this)">8</button>
                <button class="monthButton" value="9" onclick="daysOfMonth(this)">9</button>
                <button class="monthButton" value="10" onclick="daysOfMonth(this)">10</button>
                <button class="monthButton" value="11" onclick="daysOfMonth(this)">11</button>
                <button class="monthButton" value="12" onclick="daysOfMonth(this)">12</button>
            </div>
    </header>
    <hr id="divideLine">
    <nav>
        <div id="navShortMenu">
            <img class="menuIcon" src="../image/shortMenu.png" onclick="showHidden()">
        </div>

        <div id="hidden">
            <img id="cancelMenuIcon" src="../image/close.png" onclick="closeMenu()">
            <h2><%=name %> 님</h2>
            <span class="userInfoFont">ID : <%=id %> </span>
            <span class="userInfoFont">부서명 : <%=team%> </span>
            <span class="userInfoFont">전화번호 : <%=tel %> </span>
            <div id="buttonBox">
                <button class="navButton"><a class="noColor" href="showInfo.jsp">내 정보</a></button>
                <button class="navButton"><a class="noColor" href="logout.jsp">로그아웃</a></button>
            </div>
            <hr class="lineColor" id="insertNext">
            <span id="teamList">팀원 목록</span>
            <hr class="lineColor">
            <div id="peopleBox">
                
            </div>

        </div>
    </nav>

    <main>

    </main>

    <!-- <div id="modal">

        <div id="innerModal">
            <span class="close" onclick="closeModalEvent()">&times;</span>
            <form action="makeEvent.jsp">
                <h2 id="modalDate" >모달 날짜 나오는곳</h2>
                <input type="hidden" id="eventDate" name="eventDate" value="날짜">
            <span id="planCount"></span>
            <hr>
            <hr>
            <div id="planBox">
              
            </div>
            <hr>
            <h3>일정 추가</h3>
            <hr>
           
                <div id="modalTimeBox">
                    <span>일정 시간</span>
                    <div class="modalTime">
                        <div class="modalButtons">
                            <button type="button" onclick="timeFront('hour')"><img class="modalButtonPic" src="../image/upButton.png"></button>
                            <button type="button" onclick="timeBack('hour')"><img class="modalButtonPic" src="../image/downButton.png"></button>
                        </div>
                        <span class="modalTimeNum hour">00</span>
                        <input type="hidden" name="hourHidden" class="modalTimeNum" value="00">

                        <span class="modalTimeNum">시</span>
                    </div>
                    <div class="modalTime">
                        <div class="modalButtons">
                            <button type="button" onclick="timeFront('minute')"><img class="modalButtonPic" src="../image/upButton.png"></button>
                            <button type="button" onclick="timeBack('minute')"><img class="modalButtonPic" src="../image/downButton.png"></button>
                        </div>
                        <span class="modalTimeNum minute">00</span>
                        <input type="hidden" name="minuteHidden" class="modalTimeNum" value="00">
                        <span class="modalTimeNum">분</span>
                    </div>
                </div>
                <div id="planInputBox">
                    <span>일정 내용</span>
                    <textarea class="planInput" name="eventContent" placeholder="최대 50자까지 적을 수 있습니다. " cols="55" rows="5" maxlength="50"></textarea>
                </div>
                <button class="modalPlanButton">등록</button>
            </form>
        </div>

    </div> -->

    <div id="blackBox">

    </div>


    <script src="../js/calender.js"></script>
</body>
<script>
    var day = 0;
    var selectedButton = null;
    var selectedMonth = 0;
    var eventDateMatch = "";

    var idList = <%=idList%>;
    var nameList = <%=nameList%>;
    var idxTeamList = <%=idxTeamList%>;
    var modalCompareDate = "";


    // 팀원 목록을 동적으로 생성하여 추가
    var teamList = document.getElementById("insertNext");
    var peopleBox = document.getElementById("peopleBox");
    //팀장인 경우에만
    if(<%=role%> == "팀장"){
        var teamList = document.createElement("span");
        teamList.innerText = "팀원 목록";

        for (var i = 0; i < idList.length; i++) {
            var button = document.createElement("button");
            var inputIdx = document.createElement("input");
            inputIdx.value=idxTeamList[i];
            inputIdx.name="teamIdx";
            button.className = "navInfo";
            var div = document.createElement("div");
            div.innerText = nameList[i] + " (" + idList[i] + ")";
            button.appendChild(div);
            peopleBox.appendChild(button);
            button.appendChild(inputIdx);
            inputIdx.style.display="none";
            button.setAttribute('onclick', 'changeUser(' + inputIdx.value + ')');

        }
    }
    

    function changeUser(num){
        console.log(num);
        //num은 해당 유저의 idx고, 이 유저의 일정 리스트를 가져오게끔 하고싶음.
        //<%=showTeamIdx%> = num;
    }


    function daysOfMonth(button) {
        if (button.value == 2) {
            day = 28;

        }
        else if (button.value == 1 || button.value == 3 || button.value == 5 || button.value == 7 || button.value == 8 || button.value == 10 || button.value == 12) {
            day = 31;
        }
        else {
            day = 30;
        }
        changeButtonColorEvent(button);


    }

    function changeButtonColorEvent(button) {

        if (selectedButton && selectedButton.tagName === 'BUTTON') {
            selectedButton.removeAttribute("id");
        }

        button.id = "selected";
        <%=eventMonth%> = button.value;

        selectedButton = button;
        selectedMonth = button.value;
        console.log(selectedMonth);
        console.log(button.value);


        makeCalendarEvent(day);
    }

    function presentMonth() {//백엔드에서 처리하기
        var month = <%=eventMonth> + 1;

        // 아래와 같이 수정하여 버튼 객체를 만들어서 전달
        var button = document.querySelector('.monthButton[value="' + month + '"]');
        daysOfMonth(button);

        console.log(month); //배경화면 띄우기
    }

    function previousYearEvent() {//날짜 변경해서 폼태그로 연결하기
        var year = document.getElementById('year');
        var yearHidden = document.getElementById('yearHidden');

        if (year) {
            var num = parseInt(year.textContent);
            var numHidden = parseInt(yearHidden.value);
            if (num > 0) {
                year.innerText = (num - 1).toString().padStart(4, '0');
                <%=eventYear%> = (num - 1).toString().padStart(4, '0');
                yearHidden.value = (numHidden - 1).toString().padStart(4, '0');
            }
        }
    }

    function nextYearEvent() {
        var year = document.getElementById('year');
        var yearHidden = document.getElementById('yearHidden');
        if (year) {
            var num = parseInt(year.textContent);
            var numHidden = parseInt(yearHidden.value);
            if (num < 9999) {
                year.innerText = (num + 1).toString().padStart(4, '0');
                <%=eventYear%> = (num + 1).toString().padStart(4, '0');
                yearHidden.value = (numHidden + 1).toString().padStart(4, '0');
            }
            
        }
    }
    function makeCalendarEvent(day) {//이벤트 빼기
        var calendarBox = document.getElementsByTagName("main")[0];
        calendarBox.innerHTML = "";
        var days = document.createElement("div");
        days.id = "dayBox";
        calendarBox.appendChild(days);
        days.innerHTML = "";
        for (var i = 0; i < day; i++) {
            var dayBox = document.createElement("div");
            dayBox.className = "calendarDay";
            dayBox.setAttribute("onclick", "openModalEvent(" + selectedMonth + "," + (i + 1) + ")");
            dayBox.textContent = i + 1;
            days.appendChild(dayBox);

            if ((i + 1) % 7 == 0) {
                days.appendChild(document.createElement("br"));
            }

        }
    }

    function showHidden() {
        var hidden = document.getElementById('hidden');
        var black = document.getElementById('blackBox');
        hidden.style.right = "0";
        black.style.display = "block";
    }
    function closeMenu() {

        var hidden = document.getElementById('hidden');
        var black = document.getElementById('blackBox');
        hidden.style.right = "-320px";
        black.style.display = "none";
    }
    //event 붙이기
    function closeModalEvent() {
        var planBox = document.getElementById("planBox");

        // 모든 modalPlan 클래스를 가진 요소를 제거
        var modalPlans = planBox.getElementsByClassName("modalPlan");
        while (modalPlans.length > 0) {
            planBox.removeChild(modalPlans[0]);
        }
        var modal = document.getElementById('modal');
        modal.style.display = 'none';



    }
function updatePlanEvent(event) {
    var eventSpan = document.getElementById("eventContent");
    var editButton = document.getElementById("eventUpdateButton");
    var currentEvent = eventSpan.textContent;
    var eventIdx = document.getElementById("eventIdxInput").value;
    var planInput;

    if (editButton.textContent === '수정') {
        planInput = document.createElement('input');
        planInput.classList = 'planInput';
        planInput.placeholder = '최대 50자까지 적을 수 있습니다. ';
        planInput.maxLength = '50';
        planInput.value = currentEvent;
        planInput.name = "planInputName";
        var planAppendBox = document.getElementById("planAppendBox");
        planAppendBox.appendChild(planInput);
        eventSpan.style.display = 'none';
        editButton.textContent = '저장';
    } else {
        // 수정한 값을 updatePlanAction에 넘김.
        planInput = document.querySelector('.planInput');
        location.href = 'updatePlanAction.jsp?eventIdx=' + eventIdx + '&planContext=' + planInput.value;
        editButton.textContent = '수정';
        eventSpan.style.display = 'block';
        eventSpan.textContent = planInput.value; // 수정한 값을 span에 저장
        planInput.remove(); // input 엘리먼트 제거
    }
}



    function deletePlanEvent(event) {
        var eventIdx = document.getElementById("eventIdxInput").value;
        location.href = 'deletePlan.jsp?eventIdx=' + eventIdx;
    }

    function timeBack(unit) {
        var numElement = document.querySelector('.modalTimeNum.' + unit);
        var hiddenInputElement = document.querySelector('input[name=' + unit + 'Hidden]');

        if (numElement && hiddenInputElement) {
            var currentNum = parseInt(numElement.textContent);

            if (currentNum > 0) {
                numElement.textContent = (currentNum - 1).toString().padStart(2, '0');
                hiddenInputElement.value = numElement.textContent;
            }
        }
    }

    function timeFront(unit) {
        var numElement = document.querySelector('.modalTimeNum.' + unit);
        var hiddenInputElement = document.querySelector('input[name=' + unit + 'Hidden]');

        if (numElement && hiddenInputElement) {
            var currentNum = parseInt(numElement.textContent);
            if (unit === 'hour' && currentNum < 23) {
                numElement.textContent = (currentNum + 1).toString().padStart(2, '0');
                hiddenInputElement.value = numElement.textContent;
            } else if (unit === 'minute' && currentNum < 59) {
                numElement.textContent = (currentNum + 1).toString().padStart(2, '0');
                hiddenInputElement.value = numElement.textContent;
            }
        }
    }


    function openModalEvent(selectedMonth, day) {

        var modal = document.getElementById('modal');
        var modalDate = document.getElementById('modalDate');
        var eventDate = document.getElementById('eventDate');

        // 전달받은 날짜를 모달 내부의 텍스트로 설정
        eventDate.value = selectedMonth + "월 " + day + "일 ";
        modalDate.textContent = selectedMonth + "월 " + day + "일 " + "일정";
        console.log(eventDate.value);
        modalCompareDate = eventDate.value;
        console.log(modalCompareDate);


        modal.style.display = 'flex';
        doAdditionalWork();
    }

    function doAdditionalWork() {
        var matchingIndices = [];
        eventDateMatch = modalCompareDate.match(/(\d{1,2})월 (\d{1,2})일/);
        console.log(modalCompareDate);
        console.log(eventDateMatch);
        if (eventDateMatch != null) {
            var modalDay = "2023-" + eventDateMatch[1] + "-" + (eventDateMatch[2] < 10 ? '0' : '') + eventDateMatch[2];

            var dayList = <%=dayList%>;
            console.log(dayList);
            console.log(i, modalDay);
            console.log(i, modalDay == dayList[i]);


            for (var i = 0; i < dayList.length; i++) {
                console.log(modalDay == dayList[i]);
                if (modalDay == dayList[i]) {
                    matchingIndices.push(i);
                }
            }
            console.log(matchingIndices);
            var timeList = <%=timeList%>;
            console.log(timeList);
            var eventList = <%=eventList%>;
            var eventIdx = <%=eventIdx%>;
            var modalDate = document.getElementById("eventDate");
            console.log(modalCompareDate);



            for (var i = 0; i < matchingIndices.length; i++) {
                console.log(matchingIndices);
                {
                    var div = document.createElement("div");
                    var planDiv = document.createElement("div"); // 일정을 나타내는 요소와 modalbuttons를 묶는 div
                    var spanTimeInfo = document.createElement("span");
                    var spanContentInfo = document.createElement("span");
                    var spanTime = document.createElement("span");
                    var spanContent = document.createElement("span");
                    var hidden = document.createElement("input");
                    var updateButton = document.createElement("button");
                    var deleteButton = document.createElement("button");
                    var buttonDiv = document.createElement("div"); // 수정, 삭제 버튼을 감싸는 div

                    spanTime.name="eventTime";
                    spanTime.id="eventTime";

                    spanContent.name="eventContent";
                    spanContent.id="eventContent";

                    hidden.type = "hidden";
                    hidden.name = "eventIdx"; // name 속성 추가
                    spanTimeInfo.className = "planContext";
                    spanContentInfo.className = "planContext";
                    spanTime.className = "planContext";
                    spanContent.className = "planContext";
                    spanTimeInfo.innerText =  "일정시간";
                    spanContentInfo.innerText = "일정내용";
                    spanTime.innerText =  timeList[matchingIndices[i]] 
                    spanContent.innerText = eventList[matchingIndices[i]];
                    hidden.value = eventIdx[matchingIndices[i]]; // 특정 인덱스 사용
                    hidden.id = "eventIdxInput"; 

                    buttonDiv.className = "modalButtons";

                    updateButton.id="eventUpdateButton";
                    updateButton.className = "modalPlanButton";
                    updateButton.type = "button";
                    updateButton.innerText = "수정";
                    updateButton.setAttribute('onclick', 'updatePlanEvent()');
                    

                    deleteButton.className = "modalPlanButton";
                    deleteButton.type = "button";
                    deleteButton.innerText = "삭제";
                    deleteButton.setAttribute('onclick', 'deletePlanEvent()');
                    
                    div.id="planAppendBox";
                    // div에 span, hidden, form 추가
                    div.appendChild(spanTimeInfo);
                    div.appendChild(spanTime);
                    div.appendChild(spanContentInfo);
                    div.appendChild(spanContent);
                   


                    div.appendChild(hidden);

                    // buttonDiv에 버튼 추가
                    buttonDiv.appendChild(updateButton);
                    buttonDiv.appendChild(deleteButton);

                    // planDiv에 div, buttonDiv 추가
                    planDiv.appendChild(div);
                    planDiv.appendChild(buttonDiv);

                    // planDiv에 modalPlan 클래스 추가
                    planDiv.classList.add("modalPlan");

                    // planDiv를 planBox에 추가
                    planBox.appendChild(planDiv);

                    console.log(matchingIndices);
                }


            }

            console.log(dayList);
            console.log(modalDay);

        }

       




    }



</script>
</html>

