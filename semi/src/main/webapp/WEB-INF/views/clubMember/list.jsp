<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
    .member-manage-list { list-style: none; padding: 0; margin: 0; }
    .member-manage-item {
        display: flex;
        align-items: center; /* 세로 중앙 정렬 */
        padding: 15px 0;
        border-bottom: 1px solid #eee; /* 구분선 */
    }
    .member-profile-pic {
        width: 50px; height: 50px; border-radius: 50%;
        overflow: hidden; margin-right: 15px;
    }
    .member-profile-pic img { width: 100%; height: 100%; object-fit: cover; }
    .member-details { flex-grow: 1; /* 남은 공간 모두 차지 */ }
    .member-nickname { font-weight: bold; font-size: 16px; margin-bottom: 3px; }
    .member-join-date { color: var(--subtle); font-size: 13px; }
    .member-actions { margin-left: auto; /* 오른쪽 끝으로 밀기 */ white-space: nowrap; /* 버튼 줄바꿈 방지 */ }
    .member-actions .btn-sm { padding: 5px 8px; font-size: 12px; } /* 작은 버튼 */
    .leader-badge { /* 모임장 왕관 아이콘 */
        color: #f0c41a; margin-left: 5px; font-size: 1.1em;
    }
</style>

<div class="container w-700"> 
    <div class="cell mt-30 mb-20">
        <h1 style="margin:0;">모임 멤버 관리</h1>
        <p class="gray">${clubDto.clubName}</p> 
    </div>

    <%-- 모임 멤버 검색 (기능 구현은 별도 필요) --%>
    <div class="cell">
        <input type="search" class="input w-100" placeholder="모임 멤버 검색">
    </div>

    <%-- 모임 멤버 수 --%>
    <div class="cell">
        <p style="font-weight: bold;">모임 멤버 ${memberList.size()}명</p>
    </div>

    <%-- 멤버 목록 --%>
    <ul class="member-manage-list cell">
        <c:forEach var="member" items="${memberList}">
            <li class="member-manage-item">
                <%-- 프로필 사진 --%>
                <div class="member-profile-pic">
                     <img src="/member/profile?memberId=${member.clubMember}"
                          onerror="this.onerror=null; this.src='/images/error/no-image.png';"
                          alt="${member.memberNickname} 프로필">
                </div>
                <%-- 닉네임, 가입일 --%>
                <div class="member-details">
                    <div class="member-nickname">
                        ${member.memberNickname}
                        <%-- 모임장 표시 --%>
                        <c:if test="${clubDto.clubLeader == member.clubMember}">
                            <i class="fa-solid fa-crown leader-badge" title="모임장"></i>
                        </c:if>
                    </div>
                    <div class="member-join-date">
                        <fmt:formatDate value="${member.clubMemberJoin}" pattern="yy.MM.dd 가입"/>
                    </div>
                </div>
                <%-- 관리 버튼 (모임장에게만 + 본인이 아닐 때) --%>
                <c:if test="${loginId == clubDto.clubLeader && loginId != member.clubMember}">
                    <div class="member-actions">
                        <%-- 제명 버튼 폼 --%>
                        <form action="/clubMember/delete" method="post" onsubmit="return confirm('${member.memberNickname}님을 정말 제명하시겠습니까?');" style="display:inline;">
                            <input type="hidden" name="clubNo" value="${clubDto.clubNo}">
                            <input type="hidden" name="memberId" value="${member.clubMember}">
                            <button type="submit" class="btn btn-ghost btn-sm red">제명</button> <%-- 빨간색 + 작은 버튼 --%>
                        </form>
                        <%-- 모임장 위임 버튼 폼 --%>
                        <form action="/clubMember/changeLeader" method="post" onsubmit="return confirm('${member.memberNickname}님에게 모임장을 위임하시겠습니까?\n(회원님은 일반회원이 됩니다)');" style="display:inline;">
                             <input type="hidden" name="clubNo" value="${clubDto.clubNo}">
                             <input type="hidden" name="newLeader" value="${member.clubMember}">
                            <button type="submit" class="btn btn-ghost btn-sm orange ms-5">모임장 위임</button> <%-- 주황색 + 작은 버튼 --%>
                        </form>
                    </div>
                </c:if>
            </li>
        </c:forEach>
    </ul>

	<div class="cell mt-30">
		<a href="/club/home?clubNo=${clubDto.clubNo}" class="btn btn-ghost">모임 홈으로 돌아가기</a>
	</div>

</div> <%-- container 끝 --%>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>

