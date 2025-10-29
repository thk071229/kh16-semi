<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!-- summernote 에디터 적용(cdn 및 js 파일, css 파일) -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-lite.min.js"></script>
<link rel  ="stylesheet" type="text/css" href="/summernote/custom-summernote.css">
<script src = "/summernote/custom-summernote.js"></script>
<script type="text/javascript">
	$(function(){
		var state = {
				boardTitleValid:false,
				boardContentValid:false,
				ok : function(){
					return this.boardTitleValid && this.boardContentValid;
				}
		}
		// 항목검사
        $("[name=boardTitle]").on("blur", function () {
        	var text = $(this).val();
            var encoder = new TextEncoder();
            var encoded = encoder.encode(text);

            var size = encoded.length; 
        	
        	var isOver = size >= 200;
        	
             if(isOver){
              $(this).removeClass("success fail").addClass(isOver ? "fail" : "success");
              $(this).siblings(".fail-feedback").text("제목은 200byte(한글 100자) 까지 입력 가능합니다.");
             }
             var isEmpty = size == 0;
             if(isEmpty){
             	$(this).removeClass("success fail").addClass(isEmpty ? "fail" : "success");
             	$(this).siblings(".fail-feedback").text("제목을 입력해주세요");
             }
             var valid = isOver == false && isEmpty == false;
             $(this).removeClass("success fail").addClass(valid ? "success" : "fail").text("입력 내용을 확인하세요");
            state.boardTitleValid = valid;
        });
     
        $("[name=boardContent]").on("blur", function () {
        	var text = $(this).val();
            var bytes = new TextEncoder().encode(text).length; // 바이트 계산

            var isOver = bytes > 2000;
            var isEmpty = bytes == 0;
            var valid = !isOver && !isEmpty;

            $(this).removeClass("success fail").addClass(valid ? "success" : "fail");

            var $fail = $(this).siblings(".fail-feedback");
            var $success = $(this).siblings(".success-feedback");

            if(isEmpty){
                $fail.text("내용을 입력하세요").show();
                $success.hide();
            } else if(isOver){
                $fail.text(`최대 2000바이트 초과 (${bytes}바이트 입력됨)`).show();
                $success.hide();
                // 화면상 잘라내기
                var trimmed = text.slice(0, 2000); 
                $(this).val(trimmed);
            } else {
                $fail.hide();
            }

            state.boardContentValid = valid;
        	});
        
        // 폼검사
        $(".check-form").on("submit", function () {
            $(this).find("[name]").trigger("blur");    
            return state.ok();
        });

	});
</script>
<style>
	.input{
		height:40px;
	}
	.board-logo{
		font-size : 40px;
        font-weight : bold;
	}
	.board-notice{
		display: inline-block;
		font-size : 13px;
	}
</style>    
<div class="container w-700">
<div class="cell">
<div class="cell board-main mb-10">
<label class="board-logo">게시글 수정</label><br>
<label class="board-notice mt-10">커뮤니티 운영 수칙에 위반되는 글들은 동의없이 삭제될 수 있습니다</label>
</div>
<form action = "edit" method = "post" autocomplete="off" class="check-form">
	<c:if test="${sessionScope.loginId == clubLeader}">
	    <label>
	        <input type="checkbox" name="boardNotice" value="Y">
	        <span>공지사항으로 등록</span>
	    </label>
	</c:if>
	 <input type = "hidden" name = "boardNo" value = "${boardDto.boardNo}">
	 <div class="mb-10">
	 <input type = "text" name = "boardTitle" placeholder = "제목을 입력하세요" value = "${boardDto.boardTitle}" class="input w-100 mt-10">
	  <div class="success-feedback"></div>
      <div class="fail-feedback"></div>
	 </div>
	 <textarea name = "boardContent" rows="5" placeholder = "내용을 입력하세요" class="summernote-editor">${boardDto.boardContent}</textarea>
	 <div class="success-feedback"></div>
      <div class="fail-feedback"></div>
	 <button type = "submit" class="btn btn-primary w-100 mt-10">수정</button>
</form>
</div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>