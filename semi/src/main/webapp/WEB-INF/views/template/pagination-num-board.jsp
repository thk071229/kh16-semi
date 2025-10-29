<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
.pagination {
	text-align: center;
}
.pagination > a {
	font-weight: 700;
    text-decoration: none;
    color: #64B698;
    border: none;
    padding: 0.5em;
    font-size: 16px;
    display: inline-block;
    min-width: 2.5em;
}
 
.pagination > a:hover {
    box-shadow: 0 0 0 2px #FFD6A5;
    border-radius: 5px;
}

.pagination > a.active {
    box-shadow: 0 0 0 2px #FFBF86;
    border-radius: 5px;
    color: #64B698;
}

</style>




<%-- 게시글용--%>
<c:if test="${boardPageVO != null && boardPageVO.dataCount > 0}">
<div class="pagination">
    <c:if test="${not boardPageVO.firstBlock}">
        <a href="?boardPage=${boardPageVO.prevPage}&regionDepth1=${boardPageVO.regionDepth1}&regionDepth2=${boardPageVO.regionDepth2}">◀◀</a>
    </c:if>
    <c:if test="${boardPageVO.page > 1}">
        <a href="?boardPage=${boardPageVO.page-1}&regionDepth1=${boardPageVO.regionDepth1}&regionDepth2=${boardPageVO.regionDepth2}">◁</a>
    </c:if>
    <c:forEach var="i" begin="${boardPageVO.blockStart}" end="${boardPageVO.blockFinish}">
        <c:choose>
            <c:when test="${boardPageVO.page == i}">
                <a class="on">${i}</a>
            </c:when>
            <c:otherwise>
                <a href="?boardPage=${i}&regionDepth1=${boardPageVO.regionDepth1}&regionDepth2=${boardPageVO.regionDepth2}">${i}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>
    <c:if test="${boardPageVO.page < boardPageVO.totalPage}">
        <a href="?boardPage=${boardPageVO.page+1}&regionDepth1=${boardPageVO.regionDepth1}&regionDepth2=${boardPageVO.regionDepth2}">▷</a>
    </c:if>
    <c:if test="${not boardPageVO.lastBlock}">
        <a href="?boardPage=${boardPageVO.nextPage}&regionDepth1=${boardPageVO.regionDepth1}&regionDepth2=${boardPageVO.regionDepth2}">▶▶</a>
    </c:if>
</div>
</c:if>

