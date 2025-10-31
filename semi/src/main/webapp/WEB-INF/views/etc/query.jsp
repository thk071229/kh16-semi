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
			<h2>자주하는 질문</h2>
	      <table>
	      	<tr><th>소모임을 생성하려면?</th>
	        		<td> 500 활동 포인트 혹은 상품권 결제로 생성권한을 얻으실 수 있습니다 </td></tr>
	        <tr><th>소모임에 가입하려면?</th>
	        		<td> 소모임 홈에서 가입을 누르시면 됩니다 </td></tr>
	        <tr><th> 추천모임에는 어떤 게 뜨나요?</th>
	        		<td> 설정페이지에서 설정한 지역과 일치하는 소모임 목록을 보실 수 있습니다 </td></tr>
	        <tr><th> 추천모임이 안떠요</th>
	        		<td> 마이페이지 - 관심지역을 설정해주세요 </td></tr>
	      </table>
	 </div>
</div>

  
  
  
  
  <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
  