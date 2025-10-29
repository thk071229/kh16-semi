<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
.profile-info {
  flex: 1;
  background: var(--surface);
  border-radius: var(--radius);
  box-shadow: var(--shadow);
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



<div class="container w-600">
	<div class="profile-info">
			<h2>회원 포인트별 아이콘</h2>
	      <table>
	        <tr><th><i class="fa-solid fa-chess-pawn black"></i></th>
	        		<td>10 P</td></tr>
	        <tr><th><i class="fa-solid fa-chess-knight blue"></i></th>
	        		<td>30 P</td></tr>
	        <tr><th><i class="fa-solid fa-chess-rook green"></i></th>
	        		<td>50 P</td></tr>
	        <tr><th><i class="fa-solid fa-chess-queen yellow"></i></th>
	        		<td>100 P</td></tr>
	        <tr><th><i class="fa-solid fa-chess-king red"></i></th>
	        		<td>200 P</td></tr>
	      </table>
	      
	     <h4>▶ 정모 참여 : 1회당 20P 적립</h4>
	     <h4>▶ 게시글 작성 : 1회당 5P 적립</h4>
	     <h4 class="red">▷ 정모 생성권 구매시 500 P 차감</h4>
	 </div>
</div>

  
  
  
  
  <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
  