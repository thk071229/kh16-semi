<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
.profile-info {
  flex: 1;
  background: var(--surface);
  padding: 20px;
}
.profile-info table {
  width: 100%;
  border-collapse: collapse;
}
.profile-info th, .profile-info td {
  border: 1px solid #dcdcdc;
  padding: 8px;
  text-align: center;
}
.profile-info th {
  background: var(--muted);
  color: var(--ink);
  font-weight: 600;
}
</style>



<div class="container w-1000">
	<div class="profile-info">
		<h2>소소란?</h2>
		<p>SOSO는 이용자들이 부담없이 소소한 만남이나 교류를 통해
다양한 경험을 소비하고 친밀감을 형성할 수 있는 편리한 환경을 제공하고자 만들게 된 사이트입니다.</p>
<br><p>
따뜻하고 편안한 느낌의 봄 파스텔 계열 색감으로 사용자와의 거리감을 좁히고
시장조사의 결과에 따라 기술적, 서비스적으로 발전시킨 기능을 추가하였습니다.
		</p>
	 </div>
</div>

  
  
  
  
  <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
  