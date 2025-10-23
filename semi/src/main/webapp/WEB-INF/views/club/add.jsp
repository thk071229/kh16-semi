<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib  prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container w-600">
        <form action="add" method="post" autocomplete="off" enctype="multipart/form-data">
            
            <div class="cell center">
                <h1 class="mt-20">모임 개설</h1>
            </div>

            <div class="cell">
                <input class="input w-100" type="text" name="clubName" placeholder="모임 이름">
            </div>

            <div class="cell">
                <textarea class="w-100" name="clubIntroduce" rows="5" placeholder="모임 소개"></textarea>
            </div>

            <div class="cell">
                <input class="input w-100" type="text" name="regionName" placeholder="지역 (API로 검색 예정)">
            </div>

            <div class="cell">
                <select class="input w-100" name="clubOpen">
                    <option value="">-- 가입승인 여부 (Y:승인, N:바로가입) --</option>
                    <option value="Y">소모임장 승인 후 가입 (Y)</option>
                    <option value="N">누구나 바로 가입 (N)</option>
                </select>
            </div>
	
            <div class="cell">
                <select class="input w-100" name="clubCategory">
                <option value="">-- 카테고리를 선택하세요 --</option>
                <c:forEach var="category" items="${categoryList}">
                    <option value="${category.categoryNo}">${category.categoryName}</option>
                </c:forEach>
                </select>
            </div>

            <div class="cell">
                <button type="submit" class="btn btn-primary w-100">모임 만들기</button>
            </div>
            <%-- 대표 사진 추가 --%>
            <div class= "cell">
            	<label>대표 사진</label>
            	<input class="input w-100" type="file" name="attach" accept="image/*">
            </div>
            
        </form>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>