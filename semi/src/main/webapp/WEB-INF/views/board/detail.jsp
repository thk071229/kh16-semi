<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt"%>

<style>
	#board-like {
	cursor : pointer;
	}
	
	#board-like:hover {
	color : #EEEEEE;
	}
	#reply-emo {
		margin-left:10px;
	}
	.reply-list-wrapper {
	padding:10px;
	display:flex;
	}
	.reply-writer-profile {
	width:100px;
	height:100px;
	padding:10px;
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
	}
	.reply-edited-wrapper {
	display:inline-flex;
	}
	.reply-writer {
	margin-top : 0;
	margin-bottom: 0;
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
	/* 뱃지 스타일 */
	.badge {
		padding:0.25em 0.25em;
        color:#6cb7f4;
        border:2px solid #6cb7f4;
        border-radius:20px;
	}
	
	hr {
		border: none;
    	height: 0.5px;
    	background-color: #ccc;
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
				$("#board-like-count").text(response.count);
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
		$("#board-like").on("click", function(){
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
	});
</script>
<!-- 댓글 처리 ajax -->
<script type="text/javascript">
	$(function(){
		var params = new URLSearchParams(location.search);
		var boardNo = params.get("boardNo");
		stateCheck();//댓글 상태여부 호출
		loadList();//최초 목록 호출
		
		//댓글 달렸는지 확인 후 댓글 수 변경
		//댓글이 없어도 확인 가능해야하니까 data로 boardNo 값을 받는다
		function stateCheck(){
			$.ajax({
				url:"/rest/reply/check",
				method:"POST",
				data:{boardNo : boardNo},
				success:function(response){
					$("#reply-count").text(response.count);
				}
			});
		}
			
		//목록 불러오는 함수(callback 함수)
		function loadList(){
			//목록 조회 ajax
			$.ajax({
				url:"/rest/reply/list",
				method:"POST",
				data:{replyTarget : boardNo},
				success:function(response){
					//댓글이 달리지 않은 경우 아무것도 하지 않음
					if(response.length == 0){
						return;
					}
					//댓글 영역 청소
					$(".reply-list-wrapper").empty();
					//댓글 화면 생성
					for(var i = 0; i < response.length; i ++){//response = List<ReplyListVO>
						var reply = response[i];
						
						//템플릿 불러와서
						var origin = $("#reply-view-template").text();
						//html로 재해석
						var html = $.parseHTML(origin);//HTML로 재해석
						$(html).find(".reply-writer-profile").prop("src", "/member/profile?memberId="+reply.replyWriter);
						$(html).find(".reply-writer").text(reply.replyWriter);//작성자 교체
						
						//작성자가 게시글 작성자 본인이라면
						if(reply.writer == true){
							//badge 스타일 추가
							$(html).find(".reply-writer").append("<span class='badge ms-10'>작성자</span>");
						}
						
						$(html).find(".reply-content").text(reply.replyContent);//댓글 내용 교체
						
						//var wtime = moment(reply.replyWtime).format("YYYY-MM-DD HH:mm:ss");//wtime의 표시형태만 변경
						var wtime = moment(reply.replyWtime).fromNow();//상대적 시각
						$(html).find(".reply-time").text(wtime);//작성 시각 교체
						
						$(html).find(".fa-trash").attr("data-pk", reply.replyNo);//삭제 버튼에 PK 설정
						$(html).find(".fa-edit").attr("data-pk", reply.replyNo);//수정 버튼에 PK 설정
						
						//댓글 작성자 본인이 아닌 경우 버튼 영역 삭제(안보이게)
						if(reply.owner == false){
							$(html).find(".button-wrapper").remove();
						}
						
						$(".reply-list-wrapper").append(html); //댓글 목록 영역에 추가
					}
				}
			});
		}//loadList 함수 종료
		
		//삭제 버튼 이벤트
		$(".reply-list-wrapper").on("click", ".fa-trash", function(){
			var choice = window.confirm("정말 삭제하시겠습니까?");
			if(choice == false) return;
			
			var replyNo = $(this).data("pk");
			
			$.ajax({
				url:"/rest/reply/delete",
				method:"POST",
				data:{ replyNo : replyNo },
				success:function(response){
					stateCheck();
					loadList(); //목록 전체 갱신
				}
			});
		});
		//수정 버튼 이벤트(목록에서 edit 버튼 눌렀을때)
		$(".reply-list-wrapper").on("click", ".fa-edit", function(){
			var origin = $("#reply-edit-template").text();//수정 화면 템플릿 불러오기
			var html = $.parseHTML(origin);//HTML로 재해석
			
			var replyNo = $(this).data("pk"); //this == fa-edit 버튼
			var replyContent = $(this).closest(".reply-wrapper").find(".reply-content").text();
			
			$(html).find(".fa-check").attr("data-pk", replyNo);
			$(html).find(".reply-editor").val(replyContent);//textarea에 글자 설정
			
			$(".reply-wrapper").show();//댓글 영역 표시
			$(".reply-edit-wrapper").remove();//기존에 만들어진 편집용 화면 지우고
			$(this).closest(".reply-wrapper").hide().after(html);//버튼이 속한 영역 뒤에 html 추가
			
		});
		//수정 취소 버튼 이벤트
		$(".reply-list-wrapper").on("click", ".fa-xmark", function(){
			$(this).closest(".reply-edit-wrapper").prev(".reply-wrapper").show();//보기 영역 표시
			$(this).closest(".reply-edit-wrapper").hide().remove();//수정 영역 제거
		});
		
		//수정 완료 버튼 이벤트
		$(".reply-list-wrapper").on("click", ".fa-check", function(){
			var replyNo = $(this).data("pk");
			var replyContent = $(this).closest(".reply-edit-wrapper")
								.find(".reply-editor").val();//reply-editor에 적혀있는 값을 content로 저장
			
			$.ajax({
				url:"/rest/reply/edit",
				method:"POST",
				data:{replyNo : replyNo, replyContent : replyContent},
				success:function(response){
					loadList();
				}
			});
		});
		
		//댓글 등록 버튼 이벤트
		$(".reply-btn-write").on("click", function(){
			var content = $(".reply-input").val();
			//아무것도 작성되지 않았을 경우 차단
			if(content.trim().length == 0) return;
			
			$.ajax({
				url:"/rest/reply/write",
				method:"POST",
				data:{replyTarget:boardNo, replyContent:content},
				success:function(response){
					stateCheck();
					loadList();//등록 성공 시 목록 갱신
					$(".reply-input").val("");//입력창의 내용 삭제
				}
			});
		});
	});
</script>
<!-- 댓글 표시용 템플릿 -->
<script type="text/template" id = "reply-view-template">
	<div class="reply-wrapper">
		<div class="reply-profile-wrapper">
			<img class="reply-writer-profile">
		</div>
		<div class="reply-body-wrapper">
			<h3 class="reply-writer">작성자</h3>
			<pre class="reply-content">내용</pre>
			<div class="reply-edited-wrapper">
				<div class="reply-time">yyyy-MM-dd HH:mm:ss</div>
				<%-- 수정되었을때에만 표시되도록 추후 처리 --%>
				<span class="reply-edited">(수정됨)</span>
			</div>
			<div class="button-wrapper">
				<i class = "fa-solid fa-edit fa-2x gray"></i>
				<i class = "fa-solid fa-trash fa-2x gray"></i>
			</div>
	</div>
</script>
<!-- 댓글 수정용 템플릿 -->
<script type="text/template" id="reply-edit-template">
		<div class = "reply-edit-wrapper">
		<textarea class="reply-editor field w-100" rows = "4" style = "resize:none;"></textarea>
		<div class= "button-wrapper">
			<i class="fa-solid fa-xmark fa-2x gray"></i>
			<i class="fa-solid fa-check fa-2x gray"></i>
		</div>
</script>

<div class="container w-700">
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
	<div class="cell">
		<a href="list?clubNo=${boardDto.boardClub}">목록으로</a>
	<!-- 모임 회원/게시글 작성자/모임장/관리자일때 보여줄 버튼 -->
	<c:choose>
	<c:when test="${isClubMember && sessionScope.loginId == boardDto.boardWriter}">
			<a href="edit?boardNo=${boardDto.boardNo}">수정하기</a>
			<a href="delete?boardNo=${boardDto.boardNo}">삭제하기</a>
			<a href="write?clubNo=${boardDto.boardClub}">새 글 등록</a>
	</c:when>
	<c:when test="${isClubMember}">
		<div class="cell">
			<a href="write?clubNo=${boardDto.boardClub}">새 글 등록</a>
		</div>
	</c:when>
	<c:when test = "${sessionScope.loginId == clubLeader}">
		<a href="delete?boardNo=${boardDto.boardNo}">삭제하기</a>
	</c:when>
	<c:when test = "${sessionScope.loginLevel == '관리자'}">
		<a href="delete?boardNo=${boardDto.boardNo}">삭제하기</a>
	</c:when>
	</c:choose>
</div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>