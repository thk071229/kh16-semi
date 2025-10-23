<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib  prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<div class="container w-600">
        <form action="edit" method="post" autocomplete="off" enctype="multipart/form-data">
            <input type="hidden" name="clubNo" value="${clubDto.clubNo}">
            
            <div class="cell center">
                <h1 class="mt-20">모임 정보 수정</h1>
            </div>

            <div class="cell">
                <input class="input w-100" type="text" name="clubName" value="${clubDto.clubName}">
            </div>

            <div class="cell">
                <textarea class="w-100" name="clubIntroduce" rows="5" placeholder="모임 소개">${clubDto.clubIntroduce}</textarea>
            </div>

            <div class="cell">
                <input class="input w-100" name="regionName" value="${clubList.regionName}" readonly>
            </div>

            <div class="cell">
                <select class="input w-100" name="clubOpen">
                    <option value="">-- 가입승인 여부 (Y:승인, N:바로가입) --</option>
                    <%-- JSTL을 사용해 현재 값(clubDto.clubOpen)과 일치하면 selected 속성 추가 --%>
                    <option value="Y" ${clubDto.clubOpen == 'Y' ? 'selected' : ''}>소모임장 승인 후 가입 (Y)</option>
                    <option value="N" ${clubDto.clubOpen == 'N' ? 'selected' : ''}>누구나 바로 가입 (N)</option>
                </select>
            </div>
	
            <div class="cell">
                <select class="input w-100" name="clubCategory">
                <option value="">-- 카테고리를 선택하세요 --</option>
                <c:forEach var="category" items="${categoryList}">
                    <option value="${category.categoryNo}" ${clubDto.clubCategory == category.categoryNo ? 'selected' : ''}>
                        ${category.categoryName}
                    </option>
                </c:forEach>
                </select>
            </div>
            
            <%-- 대표사진 수정 추가 --%>
            <div class="cell">
                <label>현재 대표 사진</label>
                <div style="margin-top: 10px;">
                    <c:choose>
                        <c:when test="${clubDto.clubProfile != null}">
                            <img src="/attachment/download?attachmentNo=${clubDto.clubProfile}" width="300">
                        </c:when>
                        <c:otherwise>
                            <img src="/images/error/no-image.png" width="300">
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            
            <div class="cell">
                <label>대표 사진 변경 (선택)</label>
                <input class="input w-100" type="file" name="attach" accept="image/*">
                <small>※ 새 파일을 첨부하지 않으면 기존 사진이 유지됩니다.</small>
            </div>

            <div class="cell">
                <button type="submit" class="btn btn-primary w-100">수정하기</button>
            </div>
            
        </form>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>

