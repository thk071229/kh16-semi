//회원 가입 입력화면에 대한 처리
$(function(){
    //상태 객체
    var state = {
        memberIdValid : false,
        memberPwValid : false,
        memberPwCheckValid : false,
        memberNicknameValid : false,
        memberEmailValid : false,
        // (수정) 연락처 및 주소 관련 항목 제거
        memberBirthValid : true, // 필수 항목이 아니므로 초기값 true
        ok: function(){
            // (수정) 필수 항목만 검사하도록 로직 간소화
            return this.memberIdValid && this.memberPwValid && this.memberPwCheckValid
                    && this.memberNicknameValid && this.memberEmailValid;
        }
    };
    
    //아이디 관련 (이전과 동일)
    $("[name=memberId]").on("blur", function(){
        //[1] 형식 검사를 먼저 수행
        var regex = /^[a-z][a-z0-9]{4,19}$/;
        var valid = regex.test($(this).val());
        if(valid == false) {
            $(this).removeClass("success fail fail2").addClass("fail");
            state.memberIdValid = false;
            return;
        }
        
        //[2] 형식 검사를 통과했다면... (중복 검사)
        var memberId = $("[name=memberId]").val();
        $.ajax({
            url: "http://localhost:8080/rest/member/checkMemberId?memberId="+memberId,
            success: function(response) {
                if(response == true) {
                    $("[name=memberId]").removeClass("success fail fail2").addClass("fail2");
                    state.memberIdValid = false;
                }
                else {
                    $("[name=memberId]").removeClass("success fail fail2").addClass("success");
                    state.memberIdValid = true;
                }
            }
        });
    });

    //비밀번호 관련 (이전과 동일)
    $("[name=memberPw] , #password-check").on("blur", function(){
        $("[name=memberPw] , #password-check").removeClass("success fail");

        //[2] 비밀번호 형식검사
        var regex = /^(?=.*?[A-Z]+)(?=.*?[a-z]+)(?=.*?[0-9]+)(?=.*?[!@#$]+)[A-Za-z0-9!@#$]{8,16}$/;
        var valid = regex.test($("[name=memberPw]").val());
        $("[name=memberPw]").addClass(valid ? "success" : "fail");
        state.memberPwValid = valid;
        //[3] 비밀번호 일치 검사
        if($("[name=memberPw]").val().length > 0) {
            var valid2 = $("[name=memberPw]").val() == $("#password-check").val();
            $("#password-check").addClass(valid2 ? "success" : "fail");
            state.memberPwCheckValid = valid2;
        }
    });
    $("#password-show").on("click", function(){
        if($(this).hasClass("fa-eye-slash")) {
            $(this).removeClass("fa-eye-slash").addClass("fa-eye");
            $("[name=memberPw], #password-check").prop("type", "text");
        }
        else {
            $(this).removeClass("fa-eye").addClass("fa-eye-slash");
            $("[name=memberPw], #password-check").prop("type", "password");
        }
    });

    //닉네임 관련 (이전과 동일)
    $("[name=memberNickname]").on("blur", function(){
        var regex = /^[가-힣0-9]{2,10}$/;
        var valid = regex.test($(this).val());
        if(valid == false) {
            $(this).removeClass("success fail fail2").addClass("fail");
            state.memberNicknameValid = false;
            return;
        }

        var memberNickname = $(this).val();
        $.ajax({
            url:"http://localhost:8080/rest/member/checkMemberNickname?memberNickname="+memberNickname,
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

    //이메일 관련 (이전과 동일)
    $(".btn-cert-send").on("click", function(){
        //재발송인 경우 로직
        if($(this).find("i").hasClass("fa-rotate-right")) {
            $("[name=memberEmail]").removeClass("success fail fail2").val("").prop("readonly", false);
            $(this).find("i").removeClass("fa-rotate-right").addClass("fa-paper-plane");
            $(this).find("span").text("인증번호 보내기");
            state.memberEmailValid = false;
            return;
        }
        //보내기인 경우 (형식 검사 후 AJAX 요청)
        $("[name=memberEmail]").removeClass("success fail fail2");
        var regex = /^(.*?)@(.*?)$/;
        var email = $("[name=memberEmail]").val();
        var valid = regex.test(email);
        if(valid == false) {
            $("[name=memberEmail]").removeClass("success fail fail2").addClass("fail");
            state.memberEmailValid = false;
            return;
        }
        
        // 인증 이메일 발송 요청 AJAX (이전과 동일)
        $.ajax({
            url:"http://localhost:8080/rest/member/certSend",
            method:"post",
            data: { certEmail : email },
            success: function(response) {
                $(".cell-cert-input").show();
            },
            beforeSend:function(){
                $(".btn-cert-send").prop("disabled", true);
                $(".btn-cert-send").find("i").removeClass("fa-paper-plane").addClass("fa-spinner fa-spin");
                $(".btn-cert-send").find("span").text("인증메일 발송중");
            },
            complete:function(){
                $(".btn-cert-send").prop("disabled", false);
                $(".btn-cert-send").find("i").removeClass("fa-spinner fa-spin").addClass("fa-paper-plane");
                $(".btn-cert-send").find("span").text("인증메일 보내기");
            }
        });
    });

    // 인증번호 확인 (이전과 동일)
    $(".btn-cert-check").on("click", function(){
        var certNumber = $(".cert-input").val();
        var regex = /^[0-9]{6}$/;
        var valid = regex.test(certNumber);
        if(valid == false) {
            $(".cert-input").removeClass("success fail fail2").addClass("fail");
            return;
        }

        var certEmail = $("[name=memberEmail]").val();
        $.ajax({
            url:"http://localhost:8080/rest/member/certCheck",
            method:"post",
            data: {certEmail : certEmail , certNumber : certNumber},
            success: function(response) {
                if(response) {
                    $(".cert-input").removeClass("success fail fail2").val("");
                    $(".cell-cert-input").hide();
                    $("[name=memberEmail]").removeClass("success fail fail2").addClass("success").prop("readonly", true);
                    $(".btn-cert-send").find("i").removeClass("fa-paper-plane").addClass("fa-rotate-right");
                    $(".btn-cert-send").find("span").text("인증번호 재발송");
                    state.memberEmailValid = true;
                }
                else {
                    $(".cert-input").removeClass("success fail fail2").addClass("fail2");
                    state.memberEmailValid = false;
                }
            }
        });
    });

    // (삭제) 연락처 관련 로직 제거됨
    // (삭제) 주소 관련 로직 제거됨

	//생년월일 관련 (필수 항목이 아니지만 형식은 검사. 비어있으면 통과)
	$("[name=memberBirth]").on("blur", function(){
	    var value = $(this).val();
	    
	    // [핵심 수정 부분] 값이 비어있는 경우
	    if (value.length === 0) {
	         // class를 모두 제거하여 유효성 검사 표시를 없애고
	         $(this).removeClass("success fail fail2");
	         // 상태를 true로 설정하여 필수 항목이 아님을 보장
	         state.memberBirthValid = true; 
	         return; // 여기서 함수 종료
	    }
	    
	    // 값이 있는 경우: 형식 및 미래 날짜 검사
	    var regex = /^(19[0-9]{2}|20[0-9]{2})-((02-(0[1-9]|1[0-9]|2[0-9]))|((0[469]|11)-(0[1-9]|1[0-9]|2[0-9]|30))|((0[13578]|1[02])-(0[1-9]|1[0-9]|2[0-9]|3[01])))$/;
	    var valid = regex.test(value);
	    
	    if(valid == false) {//날짜 형식에 맞지 않을 때
	        $(this).removeClass("success fail fail2").addClass("fail");
	        state.memberBirthValid = false;
	    }
	    else {//날짜 형식에 맞을 때 (momentjs를 이용해서 미래의 날짜인지를 검사)
	        var current = moment();
	        var inputDate = moment(value);
	        var valid2 = current.isAfter(inputDate); // 미래 날짜 검사

	        $(this).removeClass("success fail fail2").addClass(valid2 ? "success" : "fail2");
	        state.memberBirthValid = valid2;
	    }
	});
	
    //프로필 이미지 관련 (이전과 동일)
    $("[name=attach]").on("input", function(){
        var originUrl = $(".img-preview").prop("src");
        if(originUrl.startsWith("blob:")) {
            URL.revokeObjectURL(originUrl);
            console.log("Revoke URL 실행!");
        }
        
        if(this.files.length == 0) {
            $(".img-preview").prop("src", "/images/error/no-image.png");
        }
        else {
            var imageUrl = URL.createObjectURL(this.files[0]);
            $(".img-preview").prop("src", imageUrl);
        }
    });

    //폼 검사
    $(".check-form").on("submit", function(){
        // (필수 항목에 대해 blur 이벤트를 강제로 발생시켜 최종 상태 업데이트)
        $("[name=memberId]").trigger("blur");
        $("[name=memberPw]").trigger("blur");
        $("#password-check").trigger("blur");
        $("[name=memberNickname]").trigger("blur");
        
        // (선택 항목도 검사를 원한다면)
        // $("[name=memberBirth]").trigger("blur");
        
        // 최종적으로 state.ok() (필수 항목만) 결과에 따라 폼 전송을 결정합니다.
        return state.ok();
    });
});