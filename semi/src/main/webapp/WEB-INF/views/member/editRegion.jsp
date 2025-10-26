<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div>
<form action="/editRegion" method="post">
	<div>
		<h1 style="color: var(--subtle);">선호 지역 수정</h1>
	</div>
	<c:forEach var="region" items="${regionList}" varStatus="status">
    	<div>
	    <!-- 기존 regionNo를 hidden으로 전달 -->
	    <input type="hidden" name="oldRegionNo" value="${region.regionNo}" />
	    <input type="hidden" name="regions[${status.index}].regionNo" value="${region.regionNo}" />
	    <input type="text" name="regions[${status.index}].regionType" value="${region.regionType}" />
		</div>
		<!-- api 구현 -->
	</c:forEach>
	<div>
    	<button type="submit">수정</button>
	</div>
</form>
</div>