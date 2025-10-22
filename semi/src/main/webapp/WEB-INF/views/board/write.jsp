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
<form action = "write" method = "post" autocomplete="off">
	<input type = "hidden" name = "clubNo" value = "${clubNo}">
	<label>
	<input type = "checkbox" name = "boardNotice" value = "Y">
	<span>공지사항으로 등록</span>
	</label>
	<br>
	<input type = "text" name = "boardTitle" placeholder = "제목을 입력하세요" class="field w-100">
	<br>
	<textarea name = "boardContent" rows="5" placeholder = "내용을 입력하세요" class="summernote-editor"></textarea>
	<br>
	<button type = "submit">등록</button>
</form>
</div>
<div class ="cell">
  <a href="list?clubNo=${clubNo}">목록으로</a>
</div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>