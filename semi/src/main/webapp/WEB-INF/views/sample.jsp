<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
	.club-title {
		font-size : 40px;
        font-weight : bold;
	}
		
	/*프로필 사진 wrapper 디자인*/
	.writer-profile-wrapper {
		margin-left:5px;
		width : 600px;
	}
	.writer-profile {
		width:50px;
		height:50px;
		padding:10px;
		box-shadow:0 0 1px 1px #EEEEEE;
		border-radius:50%;
		overflow:hidden;
		display:flex;
		justify-content:center;
		align-items:center;
	}
	
	.writer-profile > .member-profile {
		width:50px;
		height:50px;
	}
	
	.board-info-wrapper > .board-writer-nickname {
		padding:5px 10px 0px 10px;
		font-size:18px;
		font-weight : bold;
	}
	
	.board-info-wrapper > .board-info {
		padding:5px 10px;
		font-size:13px;
		flex-direction:row !important;
	}
	
	.board-title {
		margin-left:5px;
		font-size:25px;
   		align-items: center; /* 세로 중앙 정렬 */
    	gap: 8px; /* 뱃지와 제목 사이 간격 */
	}
	
	.board-title-link{
		text-decoration:none;
		color:black;
		text-align:center;
		<%-- transition 속성:애니메이션 효과를 줄 수 있다
		display:inline-block;
		transition-property : color, transform;
		transition-duration : 0.3s;
		transition-timing-function : ease-out;
		--%>
	}
	
	.board-title-link:hover {
		color:rgb(240, 251, 255);
		<%-- transform:scale(1.01); --%>
	}
	
	.board-count {
		display:flex;
		align-items:center;
	}
	
	.board-count > i {
		margin-left:10px;
		margin-right:5px;
	}
	
	.board-count > span {
		margin-right : 5px;
	}
	
	.board-list hr {
		border: none;
    	height: 0.5px;
    	background-color: #ccc;
	}
	
	    /*뱃지(Badge) 스타일*/
       
        /*공지 표시용*/
        .badge {
		    padding: 4px 10px;
		    font-size: 13px;
		    font-weight: 600;
		    color: #fff;
		    background-color: var(--primary);
		    border-radius: 6px;
		    letter-spacing: 0.3px;
		    box-shadow: 0 1px 3px rgba(0,0,0,0.15);
         }
        
        /*모임장 표시용*/
        .badge2 {
        padding-left:10px;
        color:#6cb7f4;
        }
        
        .notice:hover {
        	background-color : #F0F6F4;
        }
        
        .search-select-box {
        border: 1px solid #dcdcdc;
		  border-radius: 8px;
		  padding: 10px 14px;
		  font-size: 15px;
		  transition: border-color 0.2s ease, box-shadow 0.2s ease;
        }
        
        
</style>

<!-- 더보기 ajax js -->
<script src = "/js/sample-ajax.js"></script>
<!-- 게시글 목록 영역 템플릿 (ajax를 통해 변경) -->
<script type="text/template" id= "board-list-template">
			<div class="board-wrapper">
			<div class="board-list">
			<div class= "writer-profile-wrapper flex-box flex-center">
			<div class="writer-profile">
				<img class="member-profile">
			</div>
			<div class="board-info-wrapper flex-box flex-vertical flex-fill">
				<div class="board-writer-nickname flex-box">
					글쓴이
				</div>
				<div class = "board-info gray flex-box">
						<label class="board-notice">공지</label>
						<label class="board-free">자유게시판</label>
					<div class="write-time ms-10">
						작성 시각 영역
					</div>
				</div>
			</div>
			</div>
		<%-- 제목 영역 --%>
		<div class="board-title inline-flex-box mt-20 mb-20">
				<span class="badge">공지</span>
			<a class="board-title-link">게시글 제목</a>
		</div>
		<%-- 기타 정보 영역 --%>
		<div class="board-count mt-20 mb-20">		
				<i class="fa-solid fa-book-open-reader"></i>
				<span class="read-count">조회수</span>
				<i class="fa-solid fa-heart"></i>
				<span class="like-count">좋아요 수</span>
				<i class="fa-solid fa-comments"></i>
				<span class="comment-count">댓글 수</span>
		</div>
		<hr>
	</div>
</div>
</script>

<div class="container w-700">
<div class="cell mt-20 mb-20">
	<label class="club-title">${clubDto.clubName} 의 게시판</label>
</div>

<!--  게시글 목록이 나올 영역 -->
<div class="board-list-wrapper">
	<h2>아직 등록된 게시글이 없습니다</h2>
</div>


<!-- 여기부터는 ajax로 안바뀜 -->
<!-- 더보기 버튼-->
<div class="cell center mt-20 mb-20">
	<button type="button" class="btn btn-common btn-more">게시글 더보기</button>
</div>

 <!-- 검색창 -->
   <div class="cell search center mt-30 mb-50">
      <form action = "list" method = "get" class="search-form w-75">
	<select name="column" class="search-select-box">
		<option value = "board_title" ${pageVO.column == "board_title" ? "selected" : ""}>글 제목</option>
		<option value = "board_writer" ${pageVO.column == "board_writer" ? "selected" : ""}>작성자</option>
		<option value = "member_nickname" ${pageVO.column == "member_nickname" ? "selected" : ""}>닉네임</option>
	</select>
		<input type = "search" name="keyword" placeholder = "검색어 입력"  required value = "${pageVO.keyword}" class="search-input w-100">
		<input type = "hidden" name="clubNo" value = "${clubNo}">
	<button class="btn btn-primary">검색</button>
</form>
</div>
<div class="cell">
	<c:if test = "${sessionScope.loginId != null && isClubMember}">
	<a href = "write?clubNo=${clubNo}" class="btn btn-accent">새 글 등록</a>
	</c:if>
	<a href="${pageContext.request.contextPath}/club/home?clubNo=${clubNo}" class="btn btn-accent">모임 화면으로</a>
</div>

</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>