<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
	.board-title {
		margin-left:5px;
		font-size:25px;
   		align-items: center; /* 세로 중앙 정렬 */
    	gap: 8px; /* 뱃지와 제목 사이 간격 */
	}
	
	.board-info-wrapper > .board-writer-nickname {
		padding:10px;
		font-size:18px;
		font-weight : bold;
	}
		
	#board-like {
	cursor : pointer;
	}
	
	#reply-emo {
		margin-left:10px;
	}
	.reply-list-wrapper {
	padding-top:15px;
	padding-bottom:15px;
	display:flex;
	flex-direction:column;
	}
	.reply-writer-profile {
	width:100px;
	height:100px;
	box-shadow:0 0 1px 1px #EEEEEE;
	border-radius:50%;
	overflow:hidden;
	}
	.reply-wrapper {
	border:1px solid #EEEEEE;
	padding:10px;
	display:flex;
	}
	.reply-profile-wrapper {
	width:100px;
	}
	.reply-body-wrapper {
	flex-grow:1;
	padding:10px;
	font-size:15px;
	}
	.reply-edited-wrapper {
	display:inline-flex;
	font-size:12px;
	}
	.reply-writer {
	margin-top : 0;
	margin-bottom: 0;
	font-size:15px;
	}
	.button-wrapper {
		text-align : right;
	}
	.button-wrapper > i {
		cursor:pointer;
	}
	.button-wrapper > i:hover{
		color : #EEEEEE !important;
	}
	.reply-time {
	margin-top:10px;
	color:gray;
	}
	.reply-edited {
	margin-top:10px;
	color:#0056b3;
	}
	/* 뱃지 스타일 */
	.badge {
		padding:0.2em 0.5em;
        color:#6cb7f4;
        border:1px solid #6cb7f4;
        border-radius:20px;
        font-size:10px;
        margin-left:5px;
	}
	
	hr {
		border: none;
    	height: 0.5px;
    	background-color: #ccc;
	}
	
	.btn-menu {
	 margin-left:10px;
	 height:50px;
	 width:100px;
	}
</style>

<!-- 좋아요 ajax js 로드 -->
<script src="${pageContext.request.contextPath}/js/board-like.js"></script>
<!-- 댓글 ajax js 로드 -->
<script src="${pageContext.request.contextPath}/js/board-reply.js"></script>

<!-- 댓글 표시용 템플릿 -->
<script type="text/template" id = "reply-view-template">
	<div class="reply-wrapper">
		<div class="reply-profile-wrapper">
			<img class="reply-writer-profile">
		</div>
		<div class="reply-body-wrapper">
			<h3 class="reply-writer flex-box">
			작성자
			</h3>
			<div class="reply-edited-wrapper">
				<div class="reply-time">yyyy-MM-dd HH:mm:ss</div>
				<%-- 수정되었을때에만 표시되도록 추후 처리 --%>
				<span class="reply-edited">(수정됨)</span>
			</div>
			<pre class="reply-content">내용</pre>
			<div class="button-wrapper">
				<i class = "fa-solid fa-edit gray"></i>
				<i class = "fa-solid fa-trash gray"></i>
			</div>
	</div>
</script>
<!-- 댓글 수정용 템플릿 -->
<script type="text/template" id="reply-edit-template">
		<div class = "reply-edit-wrapper">
		<textarea class="reply-editor field w-100" rows = "4" style = "resize:none;"></textarea>
		<div class= "button-wrapper">
			<i class="fa-solid fa-xmark gray"></i>
			<i class="fa-solid fa-check gray"></i>
		</div>
</script>

<div class="container w-700">
<div class="cell">
	<div class="board-title inline-flex-box">
	<h3>${boardDto.boardTitle}</h3>
	<c:if test="${boardDto.boardEtime != null}">
		<span class="badge">수정됨</span>
	</c:if>
	</div>
	<hr>
	<div class="board-info-wrapper">
	
	<a href = "${pageContext.request.contextPath}/member/detail?memberId=${boardDto.boardWriter}" class="member-link">
	<span class="board-writer-nickname me-10">
	<i class="fa-solid fa-pen"></i>
	${memberDto.memberNickname}
	</span>
	</a>
	<span class="me-10">
	<i class="fa-solid fa-clock"></i>
	<fmt:formatDate value ="${boardDto.boardWtime}" pattern = "yyyy-MM-dd HH:mm"/>
	</span>
	<span>
	<i class="fa-solid fa-book-open-reader"></i>
	${boardDto.boardRead}
	</span>
	</div>
	<hr>
	<div class="cell"  style = "min-height:200px; vertical-align : top; padding : 10px;">
	${boardDto.boardContent}
	</div>
	<hr>
	<label>
		<i id="board-like" class="fa-regular fa-heart red"></i>
		<span id="board-like-count">${boardDto.boardLike}</span>
	</label>
	<label id = reply-emo><i class="fa-solid fa-comment"></i></label>
	<label id = "reply-count">
		${boardDto.boardComment}
	</label>
	<hr>
</div>
	<!-- 댓글 영역 기본 멘트 -->
	<div class="reply-list-wrapper">
		<h3>아직 등록된 댓글이 없습니다</h3>
	</div>
	<hr>
	<!-- 댓글 작성 영역(추후에 로그인 여부에 따라서 분리) -->
	<%-- 모임 회원에게 보여줄 화면 --%>
	<c:choose>
	<c:when test = "${isClubMember}">
	<div class="reply-write-wrapper mt-30">
		<div class="cell">
			<textarea rows="4" style = "resize:none;" placeholder="댓글 내용 입력" class="field w-100 reply-input"></textarea>
		</div>
		<div class="cell right">
			<button type="button" class="btn reply-btn-write">
				<i class = "fa-solid fa-pen"></i>
				<span>등록</span>
			</button>
		</div>
	</div>
	</c:when>
	<%-- 모임 회원이 아닐때 보여줄 화면 --%>
	<c:when test="${!isClubMember}">
		<div class = "reply-write-wrapper mt-30">
		<div class="cell">
		<textarea class = "field w-100 reply-input" rows="4" style = "resize:none;" 
		placeholder="모임 가입 후 댓글 작성이 가능합니다" disabled></textarea>
		</div>
		</div>
	</c:when>
	</c:choose>
	<!-- 메뉴 영역 -->
	<!-- 누구에게나 보여줄 버튼 -->
	<div class="cell flex-box">
		<a href="list?clubNo=${boardDto.boardClub}" class="btn btn-common btn-menu">목록으로</a>
	<!-- 모임 회원/게시글 작성자/모임장/관리자일때 보여줄 버튼 -->
	<c:choose>
	<c:when test="${sessionScope.loginId == boardDto.boardWriter 
	|| sessionScope.loginId == clubLeader 
	|| sessionScope.loginLevel == '관리자'}">
			<a href="edit?boardNo=${boardDto.boardNo}" class="btn btn-common btn-menu">수정하기</a>
			<a href="delete?boardNo=${boardDto.boardNo}" class="btn btn-common btn-menu">삭제하기</a>
			<a href="write?clubNo=${boardDto.boardClub}" class="btn btn-primary btn-menu">새 글 등록</a>
	</c:when>
	<c:otherwise>
		<a href="write?clubNo=${boardDto.boardClub}" class="btn btn-primary btn-menu">새 글 등록</a>
	</c:otherwise>
	</c:choose>
</div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>