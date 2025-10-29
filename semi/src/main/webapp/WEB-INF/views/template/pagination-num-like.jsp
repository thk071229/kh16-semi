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

<%-- 좋아요용--%>
<c:if test="${likePageVO != null && likePageVO.dataCount > 0}">
<div class="pagination">
    <c:if test="${not likePageVO.firstBlock}">
        <a href="?likePage=${likePageVO.prevPage}&regionDepth1=${likePageVO.regionDepth1}&regionDepth2=${likePageVO.regionDepth2}">◀◀</a>
    </c:if>
    <c:if test="${likePageVO.page > 1}">
        <a href="?likePage=${likePageVO.page-1}&regionDepth1=${likePageVO.regionDepth1}&regionDepth2=${likePageVO.regionDepth2}">◁</a>
    </c:if>
    <c:forEach var="i" begin="${likePageVO.blockStart}" end="${likePageVO.blockFinish}">
        <c:choose>
            <c:when test="${likePageVO.page == i}">
                <a class="on">${i}</a>
            </c:when>
            <c:otherwise>
                <a href="?likePage=${i}&regionDepth1=${likePageVO.regionDepth1}&regionDepth2=${likePageVO.regionDepth2}">${i}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>
    <c:if test="${likePageVO.page < likePageVO.totalPage}">
        <a href="?likePage=${likePageVO.page+1}&regionDepth1=${likePageVO.regionDepth1}&regionDepth2=${likePageVO.regionDepth2}">▷</a>
    </c:if>
    <c:if test="${not likePageVO.lastBlock}">
        <a href="?likePage=${likePageVO.nextPage}&regionDepth1=${likePageVO.regionDepth1}&regionDepth2=${likePageVO.regionDepth2}">▶▶</a>
    </c:if>
</div>
</c:if>


