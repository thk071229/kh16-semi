<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container w-450">
<form action="editCategory" method="post">
    
    <div class="cell center">
    	<h1 style="color: var(--subtle);">선호 카테고리 수정</h1>
    </div>
    	<div class="cell center">
		<div class="cell center">
			<label>관심 카테고리</label>
		</div>
		<div class="cell center mt-20">
    	<select class="search-input" name="categoryNo">
        	<c:forEach items="${categoryList}" var="categoryDto" >
            	<option value="${categoryDto.categoryNo}"
		            <c:if test="${categoryDto.categoryNo == selectedCategoryNo}">selected</c:if>>
		            ${categoryDto.categoryName}
       			</option>
        	</c:forEach>
    	</select>
    	</div>
	</div>
	<div class="cell center mt-30">
		<button class="btn btn-primary" type="submit">수정하기</button>
	</div>
</form>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>