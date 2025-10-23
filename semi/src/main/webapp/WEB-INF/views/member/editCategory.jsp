<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<div>
<form action="editCategory" method="post">
    
    <div>
    	<h1>선호 카테고리 수정</h1>
    </div>
    	<div class="cell w-50 ">
		<div>
			<label>관심 카테고리</label>
		</div>
		<div class="mt-20">
    	<select class="field" name="categoryNo">
        	<c:forEach items="${categoryList}" var="categoryDto" >
            	<option value="${categoryDto.categoryNo}"
		            <c:if test="${categoryDto.categoryNo == selectedCategoryNo}">selected</c:if>>
		            ${categoryDto.categoryName}
       			</option>
        	</c:forEach>
    	</select>
    	</div>
	</div>
	<div>
		<button type="submit">수정하기</button>
	</div>
    
    <%-- <c:forEach var="category" items="${allCategoryList}">
    	<c:set var="checked" value="false" />
	    <c:forEach var="memberCategory" items="${categoryList}">
	        <c:if test="${memberCategory.categoryNo == category.categoryNo}">
	            <c:set var="checked" value="true"/>
	        </c:if>
	    </c:forEach>
	    <div>
		    <input type="checkbox" name="categoryNos" value="${category.categoryNo}" <c:if test="${checked}">checked</c:if>>
		    ${category.categoryName}
	    </div>
	</c:forEach>
    <div>
    	<button type="submit">수정</button>
    </div> --%>
    
</form>
</div>