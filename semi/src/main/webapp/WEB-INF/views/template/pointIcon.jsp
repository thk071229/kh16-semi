<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<a href="/icon" style="text-decoration: none;">
<c:choose>
	<c:when test="${sidebarData.memberPoint()>200}">
		<i class="fa-solid fa-chess-king red"></i>
	</c:when>
	<c:when test="${sidebarData.memberPoint()>100}">
		<i class="fa-solid fa-chess-queen yellow"></i>
	</c:when>
	<c:when test="${sidebarData.memberPoint()>50}">
		<i class="fa-solid fa-chess-rook green"></i>
	</c:when>
	<c:when test="${sidebarData.memberPoint()>30}">
		<i class="fa-solid fa-chess-knight blue"></i>
	</c:when>
	<c:when test="${sidebarData.memberPoint()>10}">
		<i class="fa-solid fa-chess-pawn black"></i>
	</c:when>
	<c:otherwise>
	</c:otherwise>
</c:choose>
</a>