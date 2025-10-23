<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<%@taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt"%>

<style>
	#board-like {
	cursor : pointer;
	}
	.reply-writer-profile {
	width:100px;
	height:100px;
	padding:10px;
	box-shadow:0 0 1px 1px #EEEEEE;
	border-radius:50%;
	overflow:hidden;
	}
	i {
	cursor : pointer;
	}
	i:hover {
	color : #EEEEEE;
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
	}
	.reply-edited-wrapper {
	display:inline-flex;
	}
	.reply-writer {
	margin-top : 0;
	margin-botton: 0;
	}
	.button-wrapper {
		text-align : right;
	}
	.reply-time {
	margin-top:10px;
	color:gray;
	}
	.reply-edited {
	margin-top:10px;
	color:#0056b3;
	}
</style>

<!-- 좋아요 확인 처리 ajax -->
<script type="text/javascript">
	$(function(){
		//파라미터 읽어오는 코드 추가
		var params = new URLSearchParams(location.search);
		var boardNo = params.get("boardNo");
		
		$.ajax({
			url:"/rest/board/check?boardNo="+boardNo,
			method:"get",
			success:function(response){
				$(#board-like-count).text(response.count);
					if(response.like){//좋아요 설정 했을경우 - 이모지 변경
						$("#board-like").removeClass("fa-solid fa-regular").addClass("fa-solid");
					}
					else{//좋아요 해제 했을 경우 - 이모지 변경
						$("#board-like").removeClass("fa-solid fa-regular").addClass("fa-regular");
					}
			}
		});
		
	});
</script>
<!-- 좋아요 관련 처리 ajax -->
<!-- 추후 if 문으로 세션 정보에 따른 조건 추가(일반 회원일 경우에만 접근 가능하도록) -->
<script type="text/javascript">
	$(function(){
		var params = new URLSearchParams(location.search);
		var boardNo = params.get("boardNo");
		
		//하트에 클릭이벤트를 걸어서 /action 으로 신호 전송
		$.ajax({
			url:"/rest/board/action?boardNo="+boardNo,
			method:"post",
			success:function(response){
				$("#board-like-count").text(response.count);
				if(response.like){//좋아요 설정 시
					$("#board-like").removeClass("fa-solid fa-regular").addClass("fa-solid");
				}
				else{//좋아요 해제 시
					$("#board-like").removeClass("fa-solid fa-regular").addClass("fa-regular");
				}
			}
			
		});
	});
</script>
<!-- 댓글 처리 ajax -->
<!-- 댓글 표시용 템플릿 -->
<script type="text/template" id = "reply-view-template">

</script>
<!-- 댓글 수정용 템플릿 -->
<script type="text/template" id="reply-edit-template">

</script>
<div class="container w-700">
<h1>상세</h1>
<div class="cell">
	<h1>${boardDto.boardTitle}</h1>
	<hr>
	<a href = "/member/detail?memberId=${boardDto.boardWriter}">
	<span>${memberDto.memberNickname}</span>
	</a>
	<span>
	<fmt:formatDate value ="${boardDto.boardWtime}" pattern = "yyyy-MM-dd HH:mm"/>
	</span>
	<span>
	${boardDto.boardRead}
	</span>
	<hr>
	<div class="cell"  style = "min-height:200px; vertical-align : top; padding : 10px;">
	${boardDto.boardContent}
	</div>
	<hr>
	<div class="cell">
	<label>
		<i id="board-like" class="fa-regular fa-heart red"></i>
		<span id="board-like-count">${boardDto.boardLike}</span>
	</label>
	<label>
		댓글 : ${boardDto.boardComment}
	</label>
	</div>
</div>
	
	<div class="reply-list-wrapper">댓글 목록 영역</div>
	<!-- 댓글 작성 영역(추후에 로그인 여부에 따라서 분리) -->
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
	
	<div>
		<a href="list?clubNo=${boardDto.boardClub}">목록으로</a>
		<a href="edit?boardNo=${boardDto.boardNo}">수정하기</a>
		<a href="delete?boardNo=${boardDto.boardNo}">삭제하기</a>
		<a href="write?clubNo=${boardDto.boardClub}">새 글 등록</a>
	</div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>