<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
.member-card {
	align-items: center;
	background-color: var(--surface);
	border-radius: 30px;
	padding: 5px 15px 5px 5px;
	box-shadow: var(--shadow);
	border: 1px solid #eee;
	height: 50px;
	width: 150px;
}

.member-more {
	display: flex;
	justify-content: center; /* 가로 가운데 */
	align-items: center; /* 세로 가운데 */
	background-color: var(--muted);
	border-radius: 30px;
	padding: 5px 15px;
	box-shadow: var(--shadow);
	border: 1px solid #eee;
	height: 100%;
	color: var(--primary-600);
	cursor: pointer;
}
.button-wrapper{
justify-content: flex-end
}
</style>
<!-- 좋아요 js 분리 -->
<script src="${pageContext.request.contextPath}/js/club-home-check.js"></script>
<script src="${pageContext.request.contextPath}/js/club-home-like.js"></script>

<!-- more-button js -->
<script type="text/javascript">
	$(function() {
		var params = new URLSearchParams(location.search);
		var clubNo = params.get("clubNo");
		var size = 5;
		var increase = 5;

		//최초 목록 호출
		loadList();

		//더보기 버튼 이벤트
		$(".btn-more").on("click", function() {
			size += increase;
			console.log("size=" + size);
			loadList();

		});
		//목록 불러오는 함수
		function loadList() {

			$
					.ajax({
						url : contextPath+"/rest/more/clubMember",
						method : "POST",
						data : {
							page : 1,
							size : size,
							clubNo : clubNo,
						},
						success : function(response) {
							console.log(response);
							console.log(size)
							//list가 비어있을 경우 아무것도 하지 않음
							var list = response.list;

							if (list.length == 0) {
								return;
							}

							$(".member-list-wrapper").empty();
							//목록 화면 생성
							for (var i = 0; i < list.length; i++) {
								var member = list[i];

								var origin = $("#member-list-template").text();
								var html = $.parseHTML(origin);

								$(html).find(".member-image").attr(
										"src",contextPath+
										"/member/profile?memberId="
												+ member.clubMember).attr(
										"alt", member.memberNickname + " 프로필");

								$(html).find(".member-nickname").text(
										member.memberNickname);
								if (member.clubMemberRole == '모임장') {
									$(html)
											.find(".member-nickname")
											.append(
													"<i class='fa-solid fa-crown ms-5' style='color: #f0c41a;' title='모임장'></i>")
								}

								$(".member-list-wrapper").append(html);
							}

							//button 실행 조건
							if (response.hasMore == false) {
								$(".btn-more").hide();
							} else {
								$(".btn-more").show();

							}
						}

					});

		}

	});
</script>
<script type="text/template" id="member-list-template">
<div class="member-list flex-box" style="flex-wrap: wrap; gap: 15px;">
	      <div class="member-card flex-box">
		      <div style="width: 40px; height: 40px; border-radius: 50%; overflow: hidden; margin-right: 10px;">
				<img class="member-image" style="width: 100%; height: 100%; object-fit: cover;"
					onerror="this.onerror=null; this.src='/images/error/no-image.png';">
			  </div>
			<div style="font-weight: 600; font-size: 15px;">
				<span class="member-nickname">회원 닉네임</span>
			</div>
			</div>
</div>
</script>
<div class="container w-1000">
	<%-- 전체 컨텐츠 너비 조절 (w-800 사용) --%>

	<%-- 메뉴 바 --%>
	<div class="cell">
		<div class="flex-box">
			<h2>
				<a href="${pageContext.request.contextPath}/club/home?clubNo=${clubDto.clubNo}"
					class="btn btn-primary">홈</a>
			</h2>
			<%-- 현재 페이지 강조 --%>
			<h2>
				<a href="${pageContext.request.contextPath}/board/list?clubNo=${clubDto.clubNo}"
					class="btn btn-ghost ms-20">게시판</a>
			</h2>
			<h2>
				<a href="${pageContext.request.contextPath}/event/list?clubNo=${clubDto.clubNo}"
					class="btn btn-ghost ms-20">정모</a>
			</h2>
		</div>
	</div>
	<hr>

	<%-- 모임 제목, 관리 메뉴, 좋아요 --%>
	<div class="cell">
		<div class="flex-box" style="align-items: center;">
			<h1 class="flex-fill" style="margin: 0;">${clubDto.clubName}</h1>
			<%-- 모임 이름 --%>

			<%-- 좋아요 버튼 (위치 이동 및 스타일 적용) --%>
			<div class="h-stack ms-20">
				<i id="club-like" class="fa-regular fa-heart red"
					style="font-size: 1.5em; cursor: pointer;"></i> <span
					id="club-like-count" class="ms-10"
					style="font-size: 1.2em; font-weight: 600;">0</span>
			</div>

			<%-- 모임장 관리 영역 --%>
			<c:if test="${loginId == clubDto.clubLeader}">
				<a href="${pageContext.request.contextPath}/club/edit?clubNo=${clubDto.clubNo}" title="모임 정보 수정"
					class="ms-20"> <i class="fa-solid fa-pen-to-square fa-lg gray"></i>
				</a>
				<a href="${pageContext.request.contextPath}/club/delete?clubNo=${clubDto.clubNo}"
					class="check-club-delete ms-10" title="모임 삭제"> <i
					class="fa-solid fa-trash-can fa-lg gray"></i>
				</a>
			</c:if>
		</div>
	</div>

	<%-- 모임 대표 사진 --%>
	<div class="cell center w-100">
		<c:choose>
			<%-- [수정] boardCountVO -> clubDto --%>
			<c:when test="${not empty clubDto.clubProfile}">
				<img src="${pageContext.request.contextPath}/attachment/download?attachmentNo=${clubDto.clubProfile}"
					alt="${clubDto.clubName}"
					onerror="this.onerror=null; this.src='/images/error/no-image.png';"
					style="width:100%; max-height: 350px; object-fit: contain; border-radius: var(--radius-sm); box-shadow: var(--shadow);">
				</c:when>
			<c:otherwise>
				<img src="${pageContext.request.contextPath}/images/error/no-image.png"
					style="width: 200px; height: auto; opacity: 0.5;" alt="기본 이미지">
			</c:otherwise>
		</c:choose>
	</div>

	<%-- 모임 소개 --%>
	<div class="cell mt-30">
		<h2>모임 소개</h2>
	</div>
	<div class="cell card" style="background: var(--muted);">
		<pre
			style="white-space: pre-wrap; word-wrap: break-word; font-family: var(--font-sans);">${clubDto.clubIntroduce}</pre>
	</div>


	<%-- 회원 목록 --%>
	<div class="cell mt-30">

		<div class="header">
			<h2 class="flex-fill" style="margin: 0;">모인 멤버
				(${memberList.size()}명)</h2>
			<c:if test="${loginId == clubDto.clubLeader}">
				<a href="${pageContext.request.contextPath}/clubMember/list?clubNo=${clubDto.clubNo}" class="link">
					<i class="fa-solid fa-users me-5"></i> 멤버관리
				</a>
			</c:if>
		</div>


		<div class="flex-box mt-10 member-list-wrapper center"
			style="flex-wrap: wrap; gap: 15px;">
			<div>비어있음</div>
		</div>

	</div>
	<div class="button-wrapper flex-box">
				<button type="button" class="btn-more member-more right">
					<span style="font-weight: 600; font-size: 15px;">멤버 더보기</span>
				</button>
	</div>
	<hr class="mt-30 mb-30">

	<%-- 가입/탈퇴 버튼 --%>
	<c:if test="${loginId != null && clubMemberDto == null}">
		<form action="${pageContext.request.contextPath}/clubMember/join" method="post" autocomplete="off">
			<div class="cell">
				<input type="hidden" name="clubNo" value="${clubDto.clubNo}">
				<button type="submit" class="btn btn-primary w-100">이 모임
					참여하기</button>
			</div>
		</form>
	</c:if>
	<c:if test="${clubMemberDto != null}">
		<c:if test="${loginId != clubDto.clubLeader}">
			<form action="${pageContext.request.contextPath}/clubMember/drop" method="post" autocomplete="off">
				<div class="cell">
					<input type="hidden" name="clubNo" value="${clubDto.clubNo}">
					<button type="submit" class="btn btn-ghost w-100 red">모임
						탈퇴하기</button>
				</div>
			</form>
		</c:if>
	</c:if>
	<c:if test="${loginId == null}">
		<div class="cell center">
			<p class="gray">
				모임에 참여하려면 <a href="${pageContext.request.contextPath}/member/login" class="link">로그인</a>해주세요.
			</p>
		</div>
	</c:if>

</div>
<%-- container 끝 --%>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>