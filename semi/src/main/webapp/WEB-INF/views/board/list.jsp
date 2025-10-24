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
		padding:10px;
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
		    background-color: #ff4d4f;
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
</style>

<div class="container w-700">
<div class="cell mt-20 mb-20">
	<label class="club-title">${clubDto.clubName} 의 게시판</label>
</div>
<c:forEach var = "boardDto" items = "${boardList}" varStatus = "status">
<div class="cell w-600 mb-20">
<div class="board-list ${status.index < noticeCount ? 'notice' : ''}">
	<div>
		<div class= "writer-profile-wrapper flex-box flex-center">
			<div class="writer-profile">
				<img src = "/member/profile?memberId=${boardDto.boardWriter}" class="member-profile">
			</div>
			<div class="board-info-wrapper flex-box flex-vertical flex-fill">
				<div class="board-writer-nickname flex-box">
					<label>${boardDto.memberNickname}</label>
					<c:if test = "${clubDto.clubLeader == boardDto.boardWriter}">
					<span class="badge2">모임장</span>
					</c:if>
				</div>
				<div class = "board-info gray flex-box">
					<c:choose>
					<c:when test = "${boardDto.boardNotice == 'Y'}">
						<label class="board-type">공지</label>
					</c:when>
					<c:otherwise>
						<label class="board-type">자유게시판</label>
					</c:otherwise>
					</c:choose>
					<div class="write-time ms-20">${boardDto.boardWriteTime}</div>
				</div>
			</div>
		</div>
	</div>
		<!-- 제목 영역 -->
		<div class="board-title inline-flex-box mt-20 mb-20">
			<c:if test = "${boardDto.boardNotice == 'Y'}">
				<span class="badge">공지</span>
			</c:if>
			<a href="detail?boardNo=${boardDto.boardNo}" class="board-title-link">${boardDto.boardTitle}</a>
		</div>
		<!-- 기타 정보 영역 -->
		<div class="board-count mt-20 mb-20">		
				<i class="fa-solid fa-user"></i>
				<span>${boardDto.boardRead}</span>
				<i class="fa-solid fa-heart"></i>
				<span>${boardDto.boardLike}</span>
				<i class="fa-solid fa-comments"></i>
				<span>${boardDto.boardComment}</span>
		</div>
		<hr>
	</div>
</div>
</c:forEach>
<!-- 페이지 내비게이터 영역 -->
<div class="cell center mt-20 mb-20">
<jsp:include page="/WEB-INF/views/template/pagination-num.jsp"></jsp:include>	
</div>

<div class="cell">
	<a href = "write?clubNo=${clubNo}">새 글 등록</a>
	<a href = "/club/home?clubNo=${clubNo}">모임 화면으로</a>
</div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>