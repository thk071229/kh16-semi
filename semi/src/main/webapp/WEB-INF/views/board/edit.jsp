<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!-- summernote 에디터 적용(cdn 및 js 파일, css 파일) -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-lite.min.js"></script>
<link rel  ="stylesheet" type="text/css" href="/summernote/custom-summernote.css">
<script src = "/summernote/custom-summernote.js"></script>   

<div class="container w-700">
<div class="cell">
<form action = "edit" method = "post">
	 <input type = "checkbox" name = "boardNotice" value = "Y" ${boardDto.boardNotice == 'Y' ? 'checked' : ''}>
	 <span>공지사항으로 등록</span>
	 <input type = "hidden" name = "boardNo" value = "${boardDto.boardNo}">
	 <input type = "text" name = "boardTitle" placeholder = "제목을 입력하세요" value = "${boardDto.boardTitle}">
	 <textarea name = "boardContent" rows="5" placeholder = "내용을 입력하세요" class="summernote-editor">${boardDto.boardContent}</textarea>
	 <button type = "submit">수정</button>
</form>
</div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>