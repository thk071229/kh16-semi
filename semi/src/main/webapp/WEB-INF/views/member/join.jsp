<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="/js/multipage.js"></script>
<script src="/js/join.js"></script> </head>

<!-- lightpick cdn -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/css/lightpick.min.css">
<script src="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/lightpick.min.js"></script> 


<script type="text/javascript">
	$(function(){
        //생년월일 설정
        var picker4 = new Lightpick({
            field: document.querySelector(".picker-4"),
            format: "YYYY-MM-DD",
            firstDay: 7,
            maxDate: moment().subtract(1,'day'),
        });
	});
</script>

<form action="join" method="post" enctype="multipart/form-data" autocomplete="off" class="check-form">
	
	<div class="container w-400">

        <div class="page">
            <div class="flex-box">
                <div class="w-100 left"></div>
                <div class="w-100 right">
                    <button type="button" class="btn btn-primary btn-next">
                        <span>다음</span>
                        <i class="fa-solid fa-arrow-right"></i>
                    </button>
                </div>
            </div>
		
		<div class="cell center">
			<h2 style="color: var(--subtle);">회원가입 정보 입력</h2>
		</div>
		
		
            <div class="cell center mt-50">
                <h3 style="color: var(--subtle);">1단계 : 아이디 입력</h3>
            </div>

            <div class="cell center">
                <label>아이디 <i class="fa-solid fa-asterisk warn"></i></label>
                <input type="text" name="memberId" class="search-input w-100">
                <div class="success-feedback">멋진 아이디입니다!</div>
                <div class="fail-feedback">아이디는 알파벳 소문자로 시작하며 숫자를 포함해 8~20자로 작성하세요</div>
                <div class="fail2-feedback">아이디가 이미 사용중입니다</div>
            </div>
        </div>
        
        <div class="page">
            <div class="flex-box">
                <div class="w-100 left">
                    <button type="button" class="btn btn-primary btn-prev">
                        <i class="fa-solid fa-arrow-left"></i>
                        <span>이전</span>
                    </button>
                </div>
                <div class="w-100 right">
                    <button type="button" class="btn btn-primary btn-next">
                        <span>다음</span>
                        <i class="fa-solid fa-arrow-right"></i>
                    </button>
                </div>
            </div>

            <div class="cell center">
                <h3 style="color: var(--subtle);">2단계 : 비밀번호 입력</h3>
            </div>

            <div class="cell center">
                <label>
                    비밀번호 
                    <i class="fa-solid fa-asterisk warn"></i>
                    <i class="fa-solid fa-eye-slash" id="password-show"></i>
                </label>
                <input type="password" name="memberPw" class="search-input w-100">
                <div class="success-feedback">비밀번호가 올바른 형식입니다</div>
                <div class="fail-feedback">알파벳 대/소문자, 숫자, 특수문자를 반드시 포함하여 8 ~16자로 작성하세요</div>
            </div>
            <div class="cell center">
                <label>비밀번호 확인 <i class="fa-solid fa-asterisk warn"></i></label>
                <input type="password" id="password-check" class="search-input w-100">
                <div class="success-feedback">비밀번호가 일치합니다</div>
                <div class="fail-feedback">비밀번호가 일치하지 않습니다</div>
            </div> 
        </div>
        
        <div class="page">
            <div class="flex-box">
                <div class="w-100 left">
                    <button type="button" class="btn btn-primary btn-prev">
                        <i class="fa-solid fa-arrow-left"></i>
                        <span>이전</span>
                    </button>
                </div>
                <div class="w-100 right">
                    <button type="button" class="btn btn-primary btn-next">
                        <span>다음</span>
                        <i class="fa-solid fa-arrow-right"></i>
                    </button>
                </div>
            </div>

            <div class="cell center">
                <h3 style="color: var(--subtle);">3단계 : 닉네임 입력</h3>
            </div>

            <div class="cell center">
                <label>닉네임 <i class="fa-solid fa-asterisk warn"></i></label>
                <input type="text" name="memberNickname" class="search-input w-100">
                <div class="success-feedback">멋진 닉네임입니다!</div>
                <div class="fail-feedback">한글 또는 숫자 2~10글자로 작성하세요</div>
                <div class="fail2-feedback">닉네임이 이미 사용중입니다</div>
            </div>
        </div>
        
        <div class="page">
            <div class="flex-box">
                <div class="w-100 left">
                    <button type="button" class="btn btn-primary btn-prev">
                        <i class="fa-solid fa-arrow-left"></i>
                        <span>이전</span>
                    </button>
                </div>
                <div class="w-100 right">
                    <button type="button" class="btn btn-primary btn-next">
                        <span>다음</span>
                        <i class="fa-solid fa-arrow-right"></i>
                    </button>
                </div>
            </div>
       
		
            <div class="cell center">
                <h3 style="color: var(--subtle);">4단계 : 이메일 입력 및 인증</h3>
            </div>
			<div class="cell center">
			<label>이메일 <i class="fa-solid fa-asterisk warn"></i></label>
                <div class="flex-box flex-vertical center" >
                    
                    <input type="text" inputmode="email" name="memberEmail" class="search-input w-100" 
                    value="${memberDto.memberEmail}" required>
                    
                    <button type="button" class="btn btn-common btn-cert-send mt-20">
                        <i class="fa-solid fa-paper-plane"></i>
                        <span>인증번호 보내기</span>
                    </button>
                    
                    <div class="success-feedback w-100 mt-10">이메일 인증이 완료되었습니다</div>
                    <div class="fail-feedback w-100 mt-10">올바른 이메일 형식이 아닙니다</div>
                    <div class="fail2-feedback w-100 mt-10">이메일 인증이 완료되지 않았습니다</div>
                </div>
            </div>

            <div class="cell center cell-cert-input" style="display: none;">
                <div class="flex-box" style="width:300px; margin: 0 auto; flex-wrap: wrap; align-items: center; justify-content: center; gap: 10px;">
                    <input type="text" inputmode="numeric" class="search-input cert-input" placeholder="인증번호 입력" style="flex-grow: 1; max-width: 170px;">
                    
                    <button type="button" class="btn btn-primary btn-cert-check" style="margin:0;">
                        <i class="fa-solid fa-key"></i>
                        <span>인증번호 확인</span>
                    </button>
                    
                    <div class="fail-feedback w-100 mt-10">인증번호는 숫자 6자리여야 합니다</div>
                    <div class="fail2-feedback w-100 mt-10">인증번호가 일치하지 않습니다</div>
                </div>
            </div>
        </div>
            

        <div class="page">
            <div class="flex-box">
                <div class="w-100 left">
                    <button type="button" class="btn btn-primary btn-prev">
                        <i class="fa-solid fa-arrow-left"></i>
                        <span>이전</span>
                    </button>
                </div>
                <div class="w-100 right">
                    <button type="button" class="btn btn-primary btn-next">
                        <span>다음</span>
                        <i class="fa-solid fa-arrow-right"></i>
                    </button>
                </div>
            </div>

            <div class="cell center">
                <h3 style="color: var(--subtle);">5단계 : 생년월일 및 성별 입력</h3>
            </div>

            <div class="cell center">
                <label>생년월일</label>
                <input type="text" name="memberBirth" class="search-input w-100 picker-4">
                <div class="fail-feedback">올바른 날짜 형식이 아닙니다</div>
                <div class="fail2-feedback">미래의 날짜는 설정할 수 없습니다</div>
            </div>
            <div class="cell center">
            	<label>성별</label>
				<select name="memberGender" class="search-input w-100">
					<option value="남">남</option>
					<option value="여">여</option>
				</select> 
            </div>
        </div>
        
        <div class="page">
            <div class="flex-box">
                <div class="w-100 left">
                    <button type="button" class="btn btn-primary btn-prev">
                        <i class="fa-solid fa-arrow-left"></i>
                        <span>이전</span>
                    </button>
                </div>
                <div class="w-100 right">
                    <button type="submit" class="btn btn-accent">
                        <i class="fa-solid fa-right-to-bracket"></i>
                        <span>회원 가입</span>
                    </button>
                </div>
            </div>

            <div class="cell center">
                <h3 style="color: var(--subtle);">6단계 : 선택 정보 입력 (프로필 이미지)</h3>
            </div>

            <div class="cell center">
                <label>프로필 이미지</label>
                <input type="file" name="attach" class="search-input w-100" accept="image/*">
            </div>
            <div class="cell center">
                <img class="img-preview" src="/images/error/no-image.png" width="200">
            </div>
            </div>
	</div>
</form>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>