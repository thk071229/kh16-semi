<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>	


<!-- --------------------------------------------- -->
<div class="container">
    <div class="cell">
	    <h1>정모 목록</h1>
    </div>
    
    <div class="cell">
    	<table class="table">
    		<tbody>
				<c:forEach var="eventList" items="${eventDto}" varStatus="status">
					<td>
						<a href="detail?eventNo=${eventList.eventNo}">
						${eventList.eventTitle}
					</td>
					<td>${eventList.eventWriter}</td>
					<td>${eventList.eventClub}</td>
				</c:forEach>
    		</tbody>
    	</table>
    </div>
    
    <div class="cell">
	    <a href="#">홈</a>
    </div>

</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>	
  