<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script type="text/javascript">
	// jQuery가 header.jsp에 포함되어 있다고 가정
	$(function(){
		// 삭제 확인 스크립트
		$(".check-club-delete").on("click", function(e){
			e.preventDefault(); // 기본 링크 이동 방지
			var isConfirm = confirm("정말 삭제하시겠습니까? 모임 관련 모든 정보(게시글, 정모 등)가 삭제됩니다.");
			if(isConfirm){
				window.location.href = $(this).attr("href"); // 확인 시 링크로 이동
			}
		});
	});
</script>

<div class="container w-800"> <%-- 전체 컨텐츠 너비 조절 --%>

		<%-- 메뉴 바 --%>
		<div class="cell">
			<div class="flex-box">
				<h2><a href="/club/home?clubNo=${clubDto.clubNo}" class="btn btn-primary">홈</a></h2> <%-- 현재 페이지 강조 --%>
				<h2><a href="/board/list?clubNo=${clubDto.clubNo}" class="btn btn-ghost ms-20">게시판</a></h2> <%-- boardClub 파라미터 확인 --%>
				<h2><a href="/event/list?clubNo=${clubDto.clubNo}" class="btn btn-ghost ms-20">정모</a></h2>
			</div>
		</div>
		<hr>

		<%-- 모임 제목 및 관리 메뉴 --%>
		<div class="cell">
        	<div class="flex-box" style="align-items: center;"> <%-- 세로 중앙 정렬 추가 --%>
        		<h1 class="flex-fill" style="margin: 0;">${clubDto.clubName}</h1> <%-- 모임 이름 --%>
        		<%-- 모임장 관리 영역 --%>
        		<c:if test="${loginId == clubDto.clubLeader}">
	        		<a href="/club/edit?clubNo=${clubDto.clubNo}" title="모임 정보 수정">
						<i class="fa-solid fa-pen-to-square fa-lg me-10 gray"></i> <%-- 아이콘 크기/색상 조절 --%>
					</a>
					<a href="/club/delete?clubNo=${clubDto.clubNo}" class="check-club-delete" title="모임 삭제">
						<i class="fa-solid fa-trash-can fa-lg gray"></i> <%-- 아이콘 크기/색상 조절 --%>
					</a>
				</c:if>
        	</div>
        </div>

        <%-- 모임 대표 사진 --%>
        <div class="cell center">
			<c:choose>
				<c:when test="${clubDto.clubProfile != null}">
					<img src="/attachment/download?attachmentNo=${clubDto.clubProfile}" style="max-width: 100%; max-height: 350px; border-radius: var(--radius-sm); box-shadow: var(--shadow);" alt="${clubDto.clubName} 대표 사진">
				</c:when>
				<c:otherwise>
					<img src="/images/error/no-image.png" style="width: 200px; height: auto; opacity: 0.5;" alt="기본 이미지"> <%-- 기본 이미지 스타일 --%>
				</c:otherwise>
			</c:choose>
		</div>

        <%-- 모임 소개 --%>
        <div class="cell mt-30">
            <h2>모임 소개</h2>
        </div>
        <div class="cell card" style="background: var(--muted);"> <%-- 카드 스타일 적용 --%>
            <pre style="white-space: pre-wrap; word-wrap: break-word;">${clubDto.clubIntroduce}</pre> <%-- 자동 줄바꿈 --%>
        </div>

        <%-- 정모 일정 (간략 표시 영역) --%>
        <div class="cell mt-30">
            <div class="flex-box">
                <h2 class="flex-fill">최근 정모 일정</h2>
                <a href="/event/list?clubNo=${clubDto.clubNo}" class="link">전체 보기 &gt;</a>
            </div>
             <%-- TODO: 컨트롤러에서 최근 정모 목록(List<EventDto>)을 받아와 표시 --%>
            <div class="cell card">
                <p class="gray">예정된 정모가 없습니다.</p> <%-- 임시 메시지 --%>
            </div>
        </div>

        <%-- 회원 목록 --%>
        <div class="cell mt-30">
        	<div class="flex-box" style="align-items: baseline;"> <%-- 제목과 관리링크 정렬 --%>
	            <h2 class="flex-fill">모인 멤버 (${memberList.size()}명)</h2>
	            <%-- 모임장 관리 링크 --%>
	            <c:if test="${loginId == clubDto.clubLeader}">
		        	<a href="/clubMember/list?clubNo=${clubDto.clubNo}" class="link"> <%-- 링크 스타일 적용 --%>
			        	<i class="fa-solid fa-users me-5"></i>멤버 관리
		        	</a>
	        	</c:if>
        	</div>

        	<%-- 회원 목록 그리드 --%>
        	<div class="flex-box mt-10" style="flex-wrap: wrap; gap: 15px;">
	        	<c:forEach var="member" items="${memberList}">
	        		<div class="member-card flex-box" style="align-items: center; background-color: var(--surface); border-radius: 30px; padding: 5px 15px 5px 5px; box-shadow: var(--shadow); border: 1px solid #eee;">
		        		<%-- 프로필 사진 (회원 ID 사용) --%>
		        		<div style="width: 40px; height: 40px; border-radius: 50%; overflow: hidden; margin-right: 10px;">
		        		    <%-- memberProfileImg 대신 member.clubMember (회원 ID) 사용 --%>
							<img src="/member/profile?memberId=${member.clubMember}" alt="${member.memberNickname} 프로필" style="width: 100%; height: 100%; object-fit: cover;"
							     onerror="this.onerror=null; this.src='/images/error/no-image.png';"> <%-- 이미지 로드 실패 시 기본 이미지 --%>
						</div>
						<%-- 닉네임 + 모임장 아이콘 --%>
						<div style="font-weight: 600; font-size: 15px;">
							<span>${member.memberNickname}</span>
							<c:if test="${clubDto.clubLeader == member.clubMember}">
								<i class="fa-solid fa-crown ms-5" style="color: #f0c41a;" title="모임장"></i>
							</c:if>
						</div>
					</div>
	        	</c:forEach>
        	</div>
        </div>
        <hr class="mt-30 mb-30">

        <%-- 가입/탈퇴 버튼 --%>
        <%-- 1. 로그인 했고, 가입하지 않은 경우 --%>
        <c:if test="${loginId != null && clubMemberDto == null}">
	        <form action="/clubMember/join" method="post" autocomplete="off">
		        <div class="cell">
		        		<input type="hidden" name="clubNo" value="${clubDto.clubNo}">
		                <button type="submit" class="btn btn-primary w-100">이 모임 참여하기</button>
		        </div>
	        </form>
        </c:if>

        <%-- 2. 가입한 회원 (단, 모임장은 아님) --%>
        <c:if test="${clubMemberDto != null}">
	        <c:if test="${loginId != clubDto.clubLeader}">
		        <form action="/clubMember/drop" method="post" autocomplete="off">
			        <div class="cell">
			        		<input type="hidden" name="clubNo" value="${clubDto.clubNo}">
			                <button type="submit" class="btn btn-ghost w-100 red">모임 탈퇴하기</button> <%-- 빨간색 + 고스트 버튼 --%>
			        </div>
		        </form>
	        </c:if>
        </c:if>

		<%-- 3. 로그인하지 않은 경우 --%>
		<c:if test="${loginId == null}">
			<div class="cell center">
				<p class="gray">모임에 참여하려면 <a href="/member/login" class="link">로그인</a>해주세요.</p>
			</div>
		</c:if>

    </div> <%-- container 끝 --%>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>