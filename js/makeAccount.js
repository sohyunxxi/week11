function checkIdDuplicate() {
    var idInput = document.getElementById('idBox');
    var idValue = idInput.value.trim();
    var idRegex = /^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{4,12}$/;

    if (idValue === '') {
        alert('아이디를 입력하세요.');
    } else if (!idRegex.test(idValue)) {
        alert('아이디는 영어와 숫자를 포함하여 4자리 이상 12자리 이하로 설정해주세요.');
    } else {
        var xhr = new XMLHttpRequest(); //XMLHttpRequest 객체를 생성, 비동기통신인데 서버랑 클라이언트 간 데이터 교환 담당
        xhr.open('POST', 'checkIdDuplicate.jsp', false); // false로 설정해서 동기적으로 통신
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');//폼 데이터를 URL 인코딩하여 전송
        xhr.send('id=' + idValue);//서버로 데이터를 보내기

        // 응답값 확인 및 처리
        var isDuplicate = xhr.responseText.trim() === 'true';
        if (isDuplicate) {
            alert('이미 사용 중인 아이디입니다.');
        } else {
            // 아이디 사용 가능한 경우 모달 창 열기
            modalOpen('아이디 사용 가능합니다!');
        }
    }
}



function modalOpen(response) {
    var modalText = document.getElementById('modalText');
    var useIdButton = document.getElementById('useIdButton');
    var modal = document.getElementById('myModal');
    var idInput = document.getElementById('idBox');
    var checkButton = document.getElementById('checkButton');

    if (response === 'true') {
        modalText.textContent = '해당 아이디는 중복입니다. 다른 아이디를 사용해 주세요.';
        useIdButton.style.display = 'none';
        idInput.disabled = true; // 아이디 입력 상자를 비활성화
        checkButton.style.display = 'none'; // 중복 확인 버튼을 숨김
    } else {
        modalText.textContent = '해당 아이디는 사용이 가능합니다.';
        useIdButton.style.display = 'inline-block';
    }

    // Show the modal
    modal.style.display = 'block';
}

function useIdEvent() {
    // 아이디 입력 상자 숨기기
    var idInput = document.getElementById('idBox');
    var idDuplicationCheck = document.getElementById('idDuplicationCheck');
    console.log(idInput.value);

    idInput.setAttribute('type', 'hidden');

    // 중복 확인 버튼 숨기기
    var checkButton = document.getElementById('checkButton');
    checkButton.style.display = 'none';

    // 모달 창 닫기
    closeModal();

    //  숨긴 input 값을 활용
    var temp = idInput.value;
    var div = document.createElement("div");
    // div.id = "idBox";
    var idAppendBox = document.getElementById("idAppendBox");
    idAppendBox.appendChild(div);
    div.innerHTML = temp;
    console.log(idInput.value);
    idDuplicationCheck.value="checked";
}


function closeModal() {
    // 모달 창 닫기
    var modal = document.getElementById('myModal');
    modal.style.display = 'none';
}



function checkNull() {
    var idInput = document.getElementById('idBox');
    var pwInput = document.getElementById('pwBox');

    if (idInput.value.trim() === '' || pwInput.value.trim() === '') {
        alert('아이디와 비밀번호를 입력하세요.');
    } else {
        location.href="../jsp/loginAction.jsp"
    }
}


function searchPw() {
    var idInput = document.getElementById('idBox');
    var name = document.getElementById('nameBox');
    var tel = document.getElementById('pwBox');

    if (idInput.value.trim() === '' || tel.value.trim() === '' || name.value.trim() === '') {
        alert('아이디와 이름, 전화번호를 제대로 입력해 주세요.');
    } else {
        alert('비밀번호는 어쩌구 입니다.');
        location.href = "../jsp/login.jsp";
    }
}

function searchId() {
    var idInput = document.getElementById('idBox');
    var tel = document.getElementById('pwBox');

    if (idInput.value.trim() === '' || tel.value.trim() === '') {
        alert('이름과 전화번호를 입력하세요.');
    } else {
        alert('아이디는 어쩌구 입니다.');
        location.href = "../jsp/login.jsp";
    }
}



function checkNoInput() {
    var nameInput = document.getElementById('nameBox');
    var idInput = document.getElementById('idBox');
    var pwInput = document.getElementById('pwBox');
    var confirmPwInput = document.getElementById('comfirmPwBox');
    var numInput = document.getElementById('numBox');
    var teamInputs = document.querySelectorAll('input[name="team"]');
    var companyInputs = document.querySelectorAll('input[name="company"]');
    var idDuplicationCheck = document.getElementById('idDuplicationCheck');

    var phoneNumberRegex = /^\d+$/;  // 숫자만 허용하는 정규표현식
    var idRegex = /^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{4,12}$/;  // 영어와 숫자를 포함하고, 4자리 이상 12자리 이하
    var nameRegex = /^[a-zA-Z가-힣]*{2,35}$/;

    
    if (nameInput.value.trim() === '' ||
        idInput.value.trim() === '' ||
        pwInput.value.trim() === '' ||
        confirmPwInput.value.trim() === '' ||
        numInput.value.trim() === '') {
        alert('모든 필수 입력란을 채워주세요.');
    } else if (!nameRegex.test(nameInput.value)) {
        validationMessage.textContent = '영어 또는 한글만 2자리 이상 35자리 이하로 입력 가능합니다.';
        nameInput.focus();
    } else if (!idRegex.test(idInput.value.trim())) {
        alert('아이디는 영어와 숫자를 포함하여 4자리 이상 12자리 이하로 설정해주세요.');
        idInput.focus();
    } else if (!/^(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[!@#$%^&*(),.?":{}|<>])\S{6,16}$/.test(pwInput.value.trim())) {
        alert('비밀번호는 6~16자리이며, 숫자, 영어, 특수문자가 각각 하나 이상 포함되어야 합니다.');
    } else if (pwInput.value.trim() !== confirmPwInput.value.trim()) {
        alert('비밀번호와 확인 비밀번호가 일치하지 않습니다. 다시 입력해 주세요.');
        pwInput.focus();
    } else if (!phoneNumberRegex.test(numInput.value.trim())) { 
        alert('전화번호는 숫자만 입력해주세요.');
        numInput.focus();
    } else if (!validateRadioSelection(teamInputs) || !validateRadioSelection(companyInputs)) {
        alert('부서명과 직급을 선택해주세요.');
    } else if(idDuplicationCheck.value=="unchecked"){
        alert('아이디 중복확인을 해주세요.');
        idInput.focus();
    } else  {
        // 모든 조건이 충족되었을 때 form을 submit
        document.forms[0].submit();
    }
}

function validateRadioSelection(radioInputs) {
    for (var i = 0; i < radioInputs.length; i++) {
        if (radioInputs[i].checked) {
            return true;
        }
    }
    return false;
}


  
    var teamInputs = document.querySelectorAll('input[name="team"]');
    var companyInputs = document.querySelectorAll('input[name="company"]');
    var idDuplicationCheck = document.getElementById('idDuplicationCheck');

function checkNameEvent(){
    var nameInput = document.getElementById('nameBox'); 
    var name= document.getElementById('nameInputMessage '); 
    var nameRegex = /^[a-zA-Z가-힣]*{2,35}$/;  
    if (!nameRegex.test(nameInput.value.trim())) {
        name.textContent = '이름은 한글이나 영어로 2자리 이상 35자리 이하로 설정해주세요..';
    } else {
        name.textContent = '';
    }
}
function checkIdEvent(){
    var idInput = document.getElementById('idBox');
    var idInputMessage = document.getElementById('idInputMessage');
    var idRegex = /^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{4,12}$/;
    if (!idRegex.test(idInput.value.trim())) {
        idInputMessage.textContent = '아이디는 영어와 숫자를 포함하여 4자리 이상 12자리 이하로 설정해주세요.';
    } else {
       idInputMessage.textContent = '';
    }
}

function checkPwMatchEvent() {
    var password = document.getElementById('pwBox').value;
    var confirmPassword = document.getElementById('confirmPwBox').value;
    var mismatchMessage = document.getElementById('passwordMismatch');
    var confirmMismatchMessage = document.getElementById('confirmPasswordMismatch');


    if (password !== confirmPassword) {
        mismatchMessage.textContent = '비밀번호가 일치하지 않습니다.';
    } else {
        if((!/^(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[!@#$%^&*(),.?":{}|<>])\S{6,16}$/.test(password.value.trim()))) {
        mismatchMessage.textContent = '비밀번호는 6~16자리이며, 숫자, 영어, 특수문자가 각각 하나 이상 포함되어야 합니다.';
        }
        else if((!/^(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[!@#$%^&*(),.?":{}|<>])\S{6,16}$/.test(confirmPassword.value.trim()))) {
            confirmMismatchMessage.textContent = '비밀번호는 6~16자리이며, 숫자, 영어, 특수문자가 각각 하나 이상 포함되어야 합니다.';
        }
        else{
            mismatchMessage.textContent='';
            confirmMismatchMessage.textContent='';
        }
    }
}

function checkTelEvent(){
    var numInput = document.getElementById('numBox');
    var phoneNumberRegex = /^\d+$/; 
    var tel = document.getElementById('telMismatch');
    if (!phoneNumberRegex.test(numInput.value.trim())) {
        tel.textContent = '전화번호는 숫자만 입력해주세요.';
    } else {
       tel.textContent = '';
    }
}

function selectTeam(value) {
    var team = value;
    console.log('Selected Team:', team);
}