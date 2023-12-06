function showPwEvent() {
    var hidden = document.getElementById('hiddenPW');
    var button = document.getElementById('checkButton');
    hidden.style.display = "block";
    button.style.display = "none";

    // 3초 후에 다시 숨김 처리
    setTimeout(function() {
        hidden.style.display = "none";
        button.style.display = "block";
    }, 3000); // 3000 밀리초(3초) 후에 실행
}

function updateEvent() {
    var pwInput = document.getElementById('pwBox');
    var confirmPwInput = document.getElementById('confirmPwBox');
    var numInput = document.getElementById('telBox'); 
    var teamInputs = document.querySelectorAll('input[name="team"]');
    var companyInputs = document.querySelectorAll('input[name="company"]');

    if (pwInput.value.trim() === '' ||
        confirmPwInput.value.trim() === '' ||
        numInput.value.trim() === '') {
        alert('모든 필수 입력란을 채워주세요.');
    } else {
        if (pwInput.value !== confirmPwInput.value) {
            alert('비밀번호가 일치하지 않습니다.');
        } else if(!(/^[0-9]{11}$/.test(numInput.value.trim()))) {
            alert('전화번호는 숫자로 11자리 입력해 주세요.');
        } else if(!(/^(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[!@#$%^&*(),.?":{}|<>])\S{6,16}$/.test(pwInput.value.trim()))) {
            alert('비밀번호는 영어 숫자 특수기호를 포함한 6자리 이상 16자리 이하로 설정해 주십시오.');
        } else if(!(/^(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[!@#$%^&*(),.?":{}|<>])\S{6,16}$/.test(confirmPwInput.value.trim()))) {
             alert('비밀번호는 영어 숫자 특수기호를 포함한 6자리 이상 16자리 이하로 설정해 주십시오.');
        }else if (!validateRadioSelection(teamInputs) || !validateRadioSelection(companyInputs)) {
            alert('부서명과 직급을 선택해주세요.');
        }else if (!validateRadioSelection(teamInputs) ) {
            alert('부서명을 선택해주세요.');
        }else if (!validateRadioSelection(companyInputs)) {
            alert('직급을 선택해주세요.');
        }
        else{
            document.forms[0].submit();
        }
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


function moveBackEvent() {
    window.history.back();
}

// function deleteEvent() {
//     var returnValue = confirm("정말 탈퇴하시겠습니까?");
//     if (returnValue) {
//         alert("회원을 탈퇴하였습니다.안녕히 가십시오.")
//         location.href = "../jsp/logout.jsp";
//     }
// }
