<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
.grid {
  display: grid !important; /* display 속성 강제 */
  gap: 16px !important; /* 간격 강제 (commons.css와 동일하게) */
  grid-template-columns: repeat(4, 1fr) !important; /* 4열 강제 */
}

/* 카드 최대 너비 설정 (4개가 들어가도록) */
.card {
    max-width: 260px !important; /* 최대 너비 강제 (1100px 컨테이너 기준 계산 값) */
    width: 100% !important;
    display: flex; /* 카드 내부 정렬을 위해 추가 */
    flex-direction: column; /* 카드 내용을 세로로 쌓음 */
}
.card .v-stack { /* 카드 내용 영역이 남은 공간 채우도록 */
    flex-grow: 1;
    display: flex;
    flex-direction: column;
}
.card .btn-ghost { /* 자세히 보기 버튼 하단 정렬 */
    margin-top: auto; /* 위쪽 여백을 최대로 밀어 버튼을 아래로 */
}

.region-name {
  display: inline-block; 
  max-width: 13ch;            /* 글자 단위로 9글자 너비 제한 */
  overflow: hidden;          /* 넘친 글자 숨김 */
  text-overflow: ellipsis;   /* ... 으로 표시 */
  white-space: nowrap;       /* 줄바꿈 방지 */
}
</style>

<div class="container">

	<div class="header"> <%-- 제목과 '더보기' 링크를 위한 레이아웃 --%>
	        <h3>⭐ 내 근처 모임 ⭐</h3>
	</div>
	
	<div class="header"> <%-- 제목과 '더보기' 링크를 위한 레이아웃 --%>
	        <h3>⭐ 내 관심사 모임 ⭐</h3>
	</div>
	
</div>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>