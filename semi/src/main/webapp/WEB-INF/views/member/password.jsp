<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script type="text/javascript">
$(function(){
	//상태객체
	var state ={
			memberPwValid: false,
			memberPwCheckValid: false,
			ok: function() {
				return this.memberPwValid && this.memberPwCheckValid;
			}
	}
	
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
	$("#current-password-show").on("click", function(){
	    togglePassword($(this), "[name=currentPw]");
	});
	$("#new-password-show").on("click", function(){
	    togglePassword($(this), "[name=memberPw], #password-check");
	});

	function togglePassword($icon, selector){
	    if($icon.hasClass("fa-eye-slash")) {
	        $icon.removeClass("fa-eye-slash").addClass("fa-eye");
	        $(selector).prop("type", "text");
	    }
	    else {
	        $icon.removeClass("fa-eye").addClass("fa-eye-slash");
	        $(selector).prop("type", "password");
	    }
	}
   
    $(".check-form").on("submit", function(){
    	 $("[name=currentPw]").trigger("blur");
         $("#password-check").trigger("blur");
         return state.ok();
    });
});

</script>


<form action="password" method="post" class="check-form">
<div class="container w-300">
     
     <div class="cell center">
     	<h2 style="color: var(--subtle);">비밀번호 변경</h2>
     </div>
     
     <div class="cell center">
			<label>
				기존 비밀번호
				<i class="fa-solid fa-asterisk warn"></i>
		     	<i class="fa-solid fa-eye-slash" id="current-password-show"></i>
			</label>
			<input type="password" name="currentPw"  class="search-input w-100" placeholder="기존 비밀번호" required>
	</div>
	
	<c:if test="${param.error != null}">
		<div class="cell center">
			<h3 style="color:#e17055;">비밀번호가 일치하지 않습니다</h3>
		</div>
	</c:if>

     <div class="cell center">
	     <label>
	     	신규 비밀번호 
		     <i class="fa-solid fa-asterisk warn"></i>
		     <i class="fa-solid fa-eye-slash" id="new-password-show"></i>
	     </label>
         <input type="password" name="memberPw" class="search-input w-100" placeholder="신규 비밀번호">
         <div class="success-feedback">비밀번호가 올바른 형식입니다</div>
         <div class="fail-feedback">알파벳 대/소문자, 숫자, 특수문자를 반드시 포함하여 8 ~16자로 작성하세요</div>
         </div>
	<div class="cell center">
         <label>비밀번호 확인 <i class="fa-solid fa-asterisk warn"></i></label>
         <input type="password" id="password-check" class="search-input w-100" placeholder="신규 비밀번호 확인">
         <div class="success-feedback">비밀번호가 일치합니다</div>
         <div class="fail-feedback">비밀번호가 일치하지 않습니다</div>
     </div> 

	<div class="cell center">
			<button type="submit" class="btn btn-accent mt-30 w-100">변경하기</button>
	</div>
	
</div>
</form>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>