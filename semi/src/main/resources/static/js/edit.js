// 회원 정보 수정 입력화면에 대한 처리 (비밀번호 로직 제외 최종 버전)
$(function(){
    // [1] 초기 설정: JSP에서 선언된 전역 변수를 사용 (ORIGINAL_NICKNAME, ORIGINAL_EMAIL)
    // JSP에 <script> 태그로 이 변수들이 선언되어 있어야 합니다.
    const originalNickname = typeof ORIGINAL_NICKNAME !== 'undefined' ? ORIGINAL_NICKNAME : "";
    const originalEmail = typeof ORIGINAL_EMAIL !== 'undefined' ? ORIGINAL_EMAIL : "";

    // [2] 상태 객체 (최소한의 상태만 관리)
    var state = {
        memberNicknameValid : true,    // 기본적으로 통과
        memberEmailValid : true,       // 기본적으로 통과
        memberBirthValid : true,       // 비어 있어도 통과 (true)
        
        ok: function(){
            // 필수 항목인 닉네임과 이메일의 유효성 상태만 확인
            return this.memberNicknameValid && 
                   this.memberEmailValid;
        }
    };
    
    // --- 닉네임 관련 (중복 검사 시 본인 제외) ---
    $("[name=memberNickname]").on("blur", function(){
        const nickname = $(this).val();
        
        // 1. 기존 닉네임과 동일하면 통과
        if (nickname === originalNickname) {
            $(this).removeClass("success fail fail2").addClass("success");
            state.memberNicknameValid = true;
            return;
        }

        // 2. 형식 검사
        var regex = /^[가-힣0-9]{2,10}$/;
        var valid = regex.test(nickname);
        if(valid == false) {
            $(this).removeClass("success fail fail2").addClass("fail");
            state.memberNicknameValid = false;
            return;
        }

        // 3. 중복 검사 (AJAX)
        $.ajax({
            url:"http://localhost:8080/rest/member/checkMemberNickname?memberNickname="+nickname,
            method:"get",
            success:function(response){
                if(response) { 
                    $("[name=memberNickname]").removeClass("success fail fail2").addClass("fail2");
                    state.memberNicknameValid = false;
                }
                else { 
                    $("[name=memberNickname]").removeClass("success fail fail2").addClass("success");
                    state.memberNicknameValid = true;
                }
            }
        });
    });

    // --- 이메일 관련 (기존 이메일은 인증 없이 통과 로직) ---
    $("[name=memberEmail]").on("input", function() {
        if ($(this).val() === originalEmail) {
            // 이메일이 기존 값과 같으면 성공 상태 유지
            $("[name=memberEmail]").removeClass("fail fail2").addClass("success").prop("readonly", true);
            $(".cell-cert-input").hide(); // 인증번호 입력 영역 숨김
            state.memberEmailValid = true;
        } else {
            // 이메일이 변경되었으면 인증 상태 초기화
            $("[name=memberEmail]").removeClass("success fail fail2").prop("readonly", false);
            // 인증 버튼/영역 초기화 로직이 필요
            state.memberEmailValid = false;
        }
    }).trigger("input");

    // 이메일 인증 보내기/확인 로직 (기존 join.js에서 복사하여 여기에 포함시키세요)
    // 이 코드는 이전 답변에 포함되어 있으므로 여기에 생략합니다.
    // ...
    // $(".btn-cert-send").on("click", function(){ ... });
    // $(".btn-cert-check").on("click", function(){ ... });
    // ...


    // --- 생년월일 관련 (비어 있어도 통과) ---
    $("[name=memberBirth]").on("blur", function(){
        var value = $(this).val();
        if (value.length === 0) {
             $(this).removeClass("success fail fail2");
             state.memberBirthValid = true; // 빈 값은 허용 (상태 true 유지)
             return;
        }
        
        // 형식 및 미래 날짜 검사
        var regex = /^(19[0-9]{2}|20[0-9]{2})-((02-(0[1-9]|1[0-9]|2[0-9]))|((0[469]|11)-(0[1-9]|1[0-9]|2[0-9]|30))|((0[13578]|1[02])-(0[1-9]|1[0-9]|2[0-9]|3[01])))$/;
        var valid = regex.test(value);
        if(valid == false) {
            $(this).removeClass("success fail fail2").addClass("fail");
            state.memberBirthValid = false;
        }
        else {
            var current = moment();
            var inputDate = moment(value);
            var valid2 = current.isAfter(inputDate); 
            $(this).removeClass("success fail fail2").addClass(valid2 ? "success" : "fail2");
            state.memberBirthValid = valid2;
        }
    });

    // --- 폼 제출 (비밀번호 확인 로직 제거) ---
    $(".check-form").on("submit", function(e){
        // 1. 모든 항목에 대해 blur 이벤트 강제 발생 (유효성 상태 최종 업데이트)
        $("[name=memberNickname]").trigger("blur");
        $("[name=memberEmail]").trigger("input"); // 이메일은 input으로 대체
        $("[name=memberBirth]").trigger("blur");
        
        // 2. JS 필수 항목 유효성 검사
        if (!state.ok()) {
            e.preventDefault(); 
            alert("입력한 정보에 오류가 있거나 인증이 완료되지 않았습니다.");
            return;
        }

        // 비밀번호 입력 필드의 required 속성을 브라우저가 처리하도록 맡깁니다.
        // 이 필드는 필수이므로 값이 없으면 브라우저가 submit을 막습니다.

        // JS 유효성 검사 통과 시 폼 제출
    });
});