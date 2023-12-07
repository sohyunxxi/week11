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

    ArrayList<String> nameList= new ArrayList<String>();
    ArrayList<String> idList= new ArrayList<String>();
    ArrayList<Integer> idxTeamList= new ArrayList<Integer>();
    ArrayList<String> timeList = new ArrayList<>();
    ArrayList<String> dayList = new ArrayList<>();

    ArrayList<String> eventList = new ArrayList<>();
    ArrayList<Integer> eventIdx = new ArrayList<>();
    ArrayList<Integer> monthCountList = new ArrayList<>();    
    ArrayList<Integer> eventCountList = new ArrayList<>();

    int showTeamIdx;    
    String showTeamName="";
    String teamIdxParam = request.getParameter("teamIdx");
    String teamNameParam = request.getParameter("teamName");
    
    if (teamIdxParam != null && !teamIdxParam.isEmpty() && !"null".equals(teamIdxParam)) {
        showTeamIdx = Integer.parseInt(teamIdxParam);
        Class.forName("com.mysql.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/week10","Sohyunxxi","1234");
        String sql = "SELECT name FROM user WHERE user_idx=?";
        PreparedStatement query = connect.prepareStatement(sql);
        query.setInt(1, showTeamIdx);
        ResultSet result = query.executeQuery();

        if(result.next()){
            showTeamName=result.getString(1);
        }
    }else{
        showTeamIdx=0;
    }
       
    if (name == null || id == null || pw == null || role == null || team == null || tel == null || idx <= 0 || String.valueOf(idx).trim().isEmpty()) {      
        response.sendRedirect("login.jsp");
    }else{
        Class.forName("com.mysql.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/week10","Sohyunxxi","1234");
        if ("팀장".equals(role)){
            // 팀장인 경우 팀원들의 정보 가져오기
            String sql = "SELECT user_idx, id, name FROM user WHERE department= ? AND role = '팀원'";
            PreparedStatement query = connect.prepareStatement(sql);
            query.setString(1, team);
            ResultSet result = query.executeQuery();

            while (result.next()) { // next가 가능할 때까지 반복문을 돌린다.
                int t_idx = result.getInt(1); // user_idx
                String t_id = result.getString(2); // username
                String t_name = result.getString(3); // name
                idxTeamList.add(t_idx);
                nameList.add("\"" + t_name + "\"");
                idList.add("\"" + t_id + "\"");
            }
        }

        if(showTeamIdx>0){      

            //해당 달에 해당하는 이벤트만 가져오기
            String eventSql = "SELECT event_idx, start_time, event_content FROM event WHERE user_idx = ? AND YEAR(start_time) = ? AND MONTH(start_time) = ? " +
            "ORDER BY start_time ASC";

            PreparedStatement eventQuery = connect.prepareStatement(eventSql);
            eventQuery.setInt(1, showTeamIdx);
            eventQuery.setInt(2, year);
            eventQuery.setInt(3, month); 
    
            ResultSet eventRs = eventQuery.executeQuery();
    
            while (eventRs.next()) {
                int e_eventIdx = eventRs.getInt(1);
                LocalDateTime e_time = eventRs.getObject(2, LocalDateTime.class);
                
                // 년, 월, 일 추출
                int listYear = e_time.getYear();
                int listMonth = e_time.getMonthValue();
                int listDay = e_time.getDayOfMonth();
            
                String formattedTimeDay = String.format("%04d-%02d-%02d", listYear, listMonth, listDay);
                String formattedTime = String.format("%02d:%02d", e_time.getHour(), e_time.getMinute());
                String e_eventContent = eventRs.getString(3);
    
                eventIdx.add(e_eventIdx);  // event_idx를 ArrayList<Integer>에 저장
                timeList.add("\"" + formattedTime + "\"");
                dayList.add("\"" + formattedTimeDay + "\"");
                eventList.add("\"" + e_eventContent + "\"");
        
            }   
        }else{
            
            //해당 달에 해당하는 이벤트만 가져오기
            String eventSql = "SELECT event_idx, start_time, event_content FROM event WHERE user_idx = ? AND YEAR(start_time) = ? AND MONTH(start_time) = ? " +
            "ORDER BY start_time ASC";

            PreparedStatement eventQuery = connect.prepareStatement(eventSql);
            eventQuery.setInt(1, idx);
            eventQuery.setInt(2, year);
            eventQuery.setInt(3, month); 
    
            ResultSet eventRs = eventQuery.executeQuery();
    
            while (eventRs.next()) {
                int e_eventIdx = eventRs.getInt(1);
                LocalDateTime e_time = eventRs.getObject(2, LocalDateTime.class);
                
                // 년, 월, 일 추출
                int listYear = e_time.getYear();
                int listMonth = e_time.getMonthValue();
                int listDay = e_time.getDayOfMonth();
            
                String formattedTimeDay = String.format("%04d-%02d-%02d", listYear, listMonth, listDay);
                String formattedTime = String.format("%02d:%02d", e_time.getHour(), e_time.getMinute());
                String e_eventContent = eventRs.getString(3);
    
                eventIdx.add(e_eventIdx);  // event_idx를 ArrayList<Integer>에 저장
                timeList.add("\"" + formattedTime + "\"");
                dayList.add("\"" + formattedTimeDay + "\"");
                eventList.add("\"" + e_eventContent + "\"");
                }   
            }

        if(showTeamIdx>1){
            String sql = "SELECT DAY(start_time) AS event_day, COUNT(*) AS event_count FROM event WHERE YEAR(start_time) = ?"
            +" AND MONTH(start_time) = ? AND user_idx =? GROUP BY DAY(start_time) ORDER BY event_day";
            PreparedStatement Query = connect.prepareStatement(sql);
            Query.setInt(1, year);
            Query.setInt(2, month);
            Query.setInt(3, showTeamIdx);
            ResultSet rs = Query.executeQuery();

            while (rs.next()) {
            int monthCount = rs.getInt(1);
            int eventCount = rs.getInt(2); 
            monthCountList.add(monthCount);
            eventCountList.add(eventCount);
            }

        } else{
            String sql = "SELECT DAY(start_time) AS event_day, COUNT(*) AS event_count FROM event WHERE YEAR(start_time) = ?"
            +" AND MONTH(start_time) = ? AND user_idx =? GROUP BY DAY(start_time) ORDER BY event_day";
            PreparedStatement Query = connect.prepareStatement(sql);
            Query.setInt(1, year);
            Query.setInt(2, month);
            Query.setInt(3, idx);
            ResultSet rs = Query.executeQuery();

            while (rs.next()) {
            int monthCount = rs.getInt(1);
            int eventCount = rs.getInt(2); 
            monthCountList.add(monthCount);
            eventCountList.add(eventCount);
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
        <form action="updateDate.jsp">
            <div id="yearBox">
                <button onclick="previousYearEvent()" class="yearButton"><img class="yearImage" src="../image/year_left.png"></button>
                    <h1 id="year" name="year"><%=year %></h1>
                    <input type="hidden" id="yearHidden" name="yearHidden" value="<%=year %>">
                <button onclick="nextYearEvent()" class="yearButton"><img class="yearImage" src="../image/year_right.png"></button>
            </div>
        </form>
        <form action="updateDate.jsp">
            <div id="months">
                <button class="monthButton" value="1" onclick="daysOfMonthEvent(this)">1</button>
                <button class="monthButton" value="2" onclick="daysOfMonthEvent(this)">2</button>
                <button class="monthButton" value="3" onclick="daysOfMonthEvent(this)">3</button>
                <button class="monthButton" value="4" onclick="daysOfMonthEvent(this)">4</button>
                <button class="monthButton" value="5" onclick="daysOfMonthEvent(this)">5</button>
                <button class="monthButton" value="6" onclick="daysOfMonthEvent(this)">6</button>
                <button class="monthButton" value="7" onclick="daysOfMonthEvent(this)">7</button>
                <button class="monthButton" value="8" onclick="daysOfMonthEvent(this)">8</button>
                <button class="monthButton" value="9" onclick="daysOfMonthEvent(this)">9</button>
                <button class="monthButton" value="10" onclick="daysOfMonthEvent(this)">10</button>
                <button class="monthButton" value="11" onclick="daysOfMonthEvent(this)">11</button>
                <button class="monthButton" value="12" onclick="daysOfMonthEvent(this)">12</button>
            </div>
        </form>
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
            <div id="onlyLeader">
                <span id="readingTeamInfo1">현재 </span>
                <span id="readingTeamInfo2"></span>
                <span id="readingTeamInfo3"> 팀원의 캘린더를 열람하고 있습니다.</span>  
            </div>
            <div id="buttonBox">
                <button class="navButton"><a class="noColor" href="showInfo.jsp">내 정보</a></button>
                <button class="navButton"><a class="noColor" href="../action/logoutAction.jsp">로그아웃</a></button>
            </div>
            <hr class="lineColor" id="insertNext">
            <span id="teamList">팀원 목록</span>
            <hr class="lineColor">
            <div id="peopleBox">    
            </div>
            <button type="button" id="showOnlyLeader" onclick="removeTeamIdx(<%=showTeamIdx%>)"> 내 일정으로 돌아가기 </button>
        </div>
    </nav>

    <main>
    </main>
    <div id="blackBox">
    </div>

<script>
    //팀IDX가 있을때, 컬러 바꾸기
    
    var day = 0;
    var selectedButton = null;
    var selectedMonth = <%=month%>;
    var eventDateMatch = "";
    var idList = <%=idList%>;
    var nameList = <%=nameList%>;
    var idxTeamList = <%=idxTeamList%>;
    var role = "<%=role%>";
    var modalCompareDate="";
    var showTeamIdx=<%=showTeamIdx%>;
    var showTeamName="<%=showTeamName%>";
    var showMonthCount=<%=monthCountList%>;    
    var showEventCount=<%=eventCountList%>;
    var idx=<%=idx%>;

    // 팀원 목록을 동적으로 생성하여 추가
    var teamList = document.getElementById("insertNext");
    console.log(idList);
    console.log(nameList);
    console.log(role);
    console.log("팀원: "+showTeamIdx);
    console.log(showMonthCount);
    console.log(showEventCount);

    var teamList = document.getElementById("insertNext");
    console.log(idList);
    console.log(nameList);
    console.log(role);
    console.log(showTeamIdx);

    if (showTeamIdx >= 1) {
        var readingTeamInfo2 = document.getElementById("readingTeamInfo2");
        readingTeamInfo2.innerText = showTeamName;
       
    }
    
    else{
        var onlyLeader=document.getElementById("onlyLeader");
        onlyLeader.style.display="none";
    }

    var peopleBox = document.getElementById("peopleBox");
    //팀장인 경우에만
    if(role == "팀장"){
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
            button.setAttribute('onclick', 'changeUser(' + inputIdx.value + ', \'' + nameList[i] + '\')');
            }
    }
    else{
        var showOnlyLeader =document.getElementById("showOnlyLeader");
        showOnlyLeader.style.display="none";
    }

    function changeUser(num,name){

        location.href="mainCalendar.jsp?teamIdx="+num+"&teamName="+name;
    }

    function daysOfMonthEvent(button) {
        if (button.value == 2) {
            day = 28;
        }
        else if (button.value == 1 || button.value == 3 || button.value == 5 || button.value == 7 || button.value == 8 || button.value == 10 || button.value == 12) {
            day = 31;
        }
        else {
            day = 30;
        }
        changeButtonColor(button);
    }

    function removeTeamIdx(num) {
        var name = "";
        console.log("Removing team info: " + num);

        // 숨기고 싶은 span 요소들을 ID를 사용하여 가져옴
        var readingTeamInfo1 = document.getElementById("readingTeamInfo1");
        var readingTeamInfo2 = document.getElementById("readingTeamInfo2");
        var readingTeamInfo3 = document.getElementById("readingTeamInfo3");

        // 디버깅을 위한 로그 출력
        console.log("Info 1: " + readingTeamInfo1);
        console.log("Info 2: " + readingTeamInfo2);
        console.log("Info 3: " + readingTeamInfo3);

        // 숨김 처리
        if (readingTeamInfo1 && readingTeamInfo2 && readingTeamInfo3) {
            readingTeamInfo1.style.display = "none";
            readingTeamInfo2.style.display = "none";
            readingTeamInfo3.style.display = "none";
            console.log("Elements hidden successfully.");
        } else {
            console.log("Some elements not found.");
        }
        location.href = "mainCalendar.jsp";
    }

    function changeButtonColor(button) {

        if (selectedButton && selectedButton.tagName === 'BUTTON') {
            selectedButton.removeAttribute("id");
            selectedButton.removeAttribute("name");
        }

        button.name = "selectedMonth";
        button.id = "selected";

        selectedButton = button;
        selectedMonth = button.value;
        console.log(selectedMonth);
        console.log(button.value);

        updateMonthOnServer(selectedMonth);
        makeCalendar(day);
    }

    function updateMonthOnServer(month) {
    // 폼 생성
        sessionStorage.setItem("month",month);
        console.log("달: "+ <%=month%>);
        //location.href="mainCalendar.jsp";
    }

    function presentMonth() {//백엔드에서 처리하기
        var month = <%=month%>;
        // 아래와 같이 수정하여 버튼 객체를 만들어서 전달
        var button = document.querySelector('.monthButton[value="' + month + '"]');
        daysOfMonthEvent(button);
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
                yearHidden.value = (numHidden - 1).toString().padStart(4, '0');
            }
        }
        updateYearOnServer(yearHidden.value);
    }

    function nextYearEvent() {
        var year = document.getElementById('year');
        var yearHidden = document.getElementById('yearHidden');
        if (year) {
            var num = parseInt(year.textContent);
            var numHidden = parseInt(yearHidden.value);
            if (num < 9999) {
                year.innerText = (num + 1).toString().padStart(4, '0');
                yearHidden.value = (numHidden + 1).toString().padStart(4, '0');
            }
        }
        updateYearOnServer(yearHidden.value);
    }

    function updateYearOnServer(year) {
        sessionStorage.setItem("year",year);
        console.log(<%=year%>);
        location.href="mainCalendar.jsp";  
    }

    function makeCalendar(day) {
        var calendarBox = document.getElementsByTagName("main")[0];
        calendarBox.innerHTML = "";
        var days = document.createElement("div");
        days.id = "dayBox";
        calendarBox.appendChild(days);
        days.innerHTML = "";
        for (var i = 0; i < day; i++) {
            var dayBox = document.createElement("div");
            dayBox.className = "calendarDay";
            dayBox.setAttribute("onclick", "openModalEvent("+ <%=year%>+"," + selectedMonth + "," + (i + 1) + ")");
            dayBox.textContent = i + 1;
            days.appendChild(dayBox);
            for(var j=0;j<=showMonthCount.length;j++){
                if(i+1==showMonthCount[j]){
                var count=document.createElement("span");
                count.className="countFont";
                if(showEventCount>8){
                    count.innerText="+9";
                }
                else{
                    count.innerText=showEventCount[j];
                    dayBox.appendChild(count);
                }
                }
            }
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

    function openModalEvent(selectYear, selectedMonth, selectDay) {
        // 새 창 열기
        var modalWindow = window.open('', '_blank', 'width=600, height=400, resizable=yes');
        // 모달 내용 생성
        var modalContent = `
        <div id="modal">
            <div id="innerModal">         
                <div id="innerDiv" ></div>
                <input type="hidden" id="eventDate" name="eventDate" value="날짜">
                <span id="planCount"></span>
                <hr>
                <span>일정 리스트</span>
                <hr>
                <div id="planBox">
                </div>
                <hr>
                <form action="../action/insertPlanAction.jsp" id="insertPlanForm">
                    <h3>일정 추가</h3>
                    <hr>
                    <div id="modalTimeBox">
                        <span>일정 시간</span>
                        <input type="time" id="planTime" name="planTime">
                    </div>
                    <div id="planInputBox">
                        <span>일정 내용</span>
                        <input type="text" id="planText" name="planText" placeholder = '최대 50자까지 적을 수 있습니다. '>
                        <input type="hidden" id="hiddenDate" name="hiddenDate">
                    </div>
                    <button id="planButton" type="button">등록</button>
                </form>
            </div>

        </div>
        `;
        modalWindow.document.body.innerHTML = modalContent;

        var spanElement = modalWindow.document.createElement('span');
        var modalDate = selectYear + "년 " +selectedMonth + '월 ' + selectDay + '일'
        spanElement.textContent = selectYear + "년 " +selectedMonth + '월 ' + selectDay + '일 일정';
        modalWindow.document.getElementById('innerDiv').appendChild(spanElement);
      
        doAdditionalWork(selectYear, selectedMonth, selectDay,modalWindow);
    }

    function updatePlanEvent(modalWindow) {
        var eventSpan = modalWindow.document.getElementById("spanContent");
        var timeSpan = modalWindow.document.getElementById("spanTime");
        var editButton = modalWindow.document.getElementById("updateButton");
        var currentEvent = eventSpan.innerText;
        var eventIdx = modalWindow.document.getElementById("eventIdxInput").value;
        var planInput= modalWindow.document.createElement('input');
        var timeInput= modalWindow.document.createElement('input');

        if (editButton.textContent === '수정') {
            planInput.classList = 'planInput';
            planInput.placeholder = '최대 50자까지 적을 수 있습니다. ';
            planInput.maxLength = '50';
            planInput.value = currentEvent;
            timeInput.type="time";
            timeInput.id="timeInput";
            timeInput.value = timeSpan.innerText;
            planInput.name = "planInputName";
            var planAppendBox = modalWindow.document.getElementById("spanContentInfo");
            var timeAppendBox = modalWindow.document.getElementById("spanTimeInfo");
            planAppendBox.appendChild(planInput);
            timeAppendBox.appendChild(timeInput);
            timeSpan.style.display='none';
            eventSpan.style.display = 'none';
            editButton.textContent = '저장';
            console.log(modalCompareDate);
        } else {
            // 수정한 값을 updatePlanAction에 넘김.
            planInput = modalWindow.document.querySelector('.planInput');
            timeInput = modalWindow.document.getElementById('timeInput');

            if(planInput.value==null||planInput.value==""){
                alert("일정을 작성해 주세요!");
            }
            else{
                editButton.textContent = '수정';
                eventSpan.style.display = 'block';
                timeSpan.style.display = 'block';

                eventSpan.textContent = planInput.value; // 수정한 값을 span에 저장
                timeSpan.textContent = timeInput.value; // 수정한 값을 span에 저장

                planInput.remove(); // input 엘리먼트 제거
                timeInput.remove();
                location.href = '../action/updatePlanAction.jsp?eventIdx=' + eventIdx + '&planContext=' + planInput.value+'&planTime='+timeInput.value+'&planDate='+modalCompareDate;

            }
        }
    }

    function deletePlanEvent(modalWindow) {
        var eventIdx = modalWindow.document.getElementById("eventIdxInput").value;
        location.href = '../action/deletePlanAction.jsp?eventIdx=' + eventIdx;
    }

    function doAdditionalWork(selectYear,selectedMonth,selectDay,modalWindow) {
        const formattedMonth = String(selectedMonth).padStart(2, '0');
        const formattedDay = String(selectDay).padStart(2, '0');
        console.log(formattedDay,formattedMonth);
        var matchingIndices = [];
        modalCompareDate = 2023+"-"+formattedMonth+"-"+formattedDay;
        console.log(selectDay);
        console.log(modalCompareDate);
        var dayList = <%=dayList%>;
        for (var i = 0; i < dayList.length; i++) {
                console.log(modalCompareDate == dayList[i]);
                if (modalCompareDate == dayList[i]) {
                    matchingIndices.push(i);
                }
        }
        console.log(matchingIndices);  
        var timeList = <%=timeList%>;
        console.log(timeList);
        var eventList = <%=eventList%>;
        var eventIdx = <%=eventIdx%>;
            
        for (var i = 0; i < matchingIndices.length; i++) {
            console.log(matchingIndices);
            var div = document.createElement("div");                
            var spanContent = document.createElement("span");
            var spanContentInfo = document.createElement("span");
            var spanTime = document.createElement("span");
            var hidden = document.createElement("input");
            if(showTeamIdx==0){
                var spanTimeInfo = document.createElement("span");
                var updateButton = document.createElement("button");
                var deleteButton = document.createElement("button");
                updateButton.onclick = function() { updatePlanEvent(modalWindow); };
                deleteButton.onclick = function() {deletePlanEvent(modalWindow);};
                updateButton.id="updateButton";
                deleteButton.id="deleteButton";
                updateButton.innerText="수정";
                deleteButton.innerText="삭제";
               
           
            }
            spanTime.id="spanTime";
            spanContent.id="spanContent";
            spanTimeInfo.innerText =  "일정시간";
            spanContentInfo.innerText = "일정내용";
            spanTimeInfo.id =  "spanTimeInfo";
            spanContentInfo.id = "spanContentInfo";
            hidden.type = "hidden";
            hidden.name = "eventIdx"; // name 속성 추가
            hidden.value = eventIdx[matchingIndices[i]]; // 특정 인덱스 사용
            hidden.id = "eventIdxInput"; 
            spanTime.innerText =  timeList[matchingIndices[i]] 
            spanContent.innerText = eventList[matchingIndices[i]];
            div.appendChild(spanTimeInfo);
            div.appendChild(spanTime);
            div.appendChild(spanContentInfo);
            div.appendChild(spanContent);
            div.appendChild(updateButton);
            div.appendChild(deleteButton);
            div.appendChild(hidden);
            var planBox =  modalWindow.document.getElementById("planBox");
            planBox.appendChild(div);
        }
        var planButton = modalWindow.document.getElementById("planButton");
        planButton.onclick = function() {checkInsertPlanEvent(modalWindow);};
            var hiddenDate=modalWindow.document.getElementById("hiddenDate");
            hiddenDate.value=modalCompareDate;
            console.log(dayList);
        if(showTeamIdx!=idx){
            var form = modalWindow.document.getElementById("insertPlanForm");
            form.style.display="none";
        }

    }

    function checkInsertPlanEvent(modalWindow) {
        // 입력값 가져오기
        var planText = modalWindow.document.getElementById("planText").value;
        var planTime = modalWindow.document.getElementById("planTime").value;
        // 필요한 경우 여기에 추가적인 입력값 확인을 할 수 있습니다.
        // 조건을 만족하지 않으면 알림을 띄우고 submit을 중지
        if (!planText || !planTime) {
            alert("일정 내용과 시간을 모두 입력해주세요.");
        }
        else {
        // 모든 조건을 만족하면 form을 submit
        var form = modalWindow.document.getElementById("insertPlanForm");
        form.submit();
        }
        // 모든 조건을 만족하면 submit을 계속 진행
    }

</script>

</body>
</html>

