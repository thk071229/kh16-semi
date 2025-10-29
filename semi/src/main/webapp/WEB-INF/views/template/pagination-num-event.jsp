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


<%-- 이벤트용--%>
<c:if test="${eventPageVO != null && eventPageVO.dataCount > 0}">
<div class="pagination">
    <c:if test="${not eventPageVO.firstBlock}">
        <a href="?eventPage=${eventPageVO.prevPage}&regionDepth1=${eventPageVO.regionDepth1}&regionDepth2=${eventPageVO.regionDepth2}">◀◀</a>
    </c:if>
    <c:if test="${eventPageVO.page > 1}">
        <a href="?eventPage=${eventPageVO.page-1}&regionDepth1=${eventPageVO.regionDepth1}&regionDepth2=${eventPageVO.regionDepth2}">◁</a>
    </c:if>
    <c:forEach var="i" begin="${eventPageVO.blockStart}" end="${eventPageVO.blockFinish}">
        <c:choose>
            <c:when test="${eventPageVO.page == i}">
                <a class="on">${i}</a>
            </c:when>
            <c:otherwise>
                <a href="?eventPage=${i}&regionDepth1=${eventPageVO.regionDepth1}&regionDepth2=${eventPageVO.regionDepth2}">${i}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>
    <c:if test="${eventPageVO.page < eventPageVO.totalPage}">
        <a href="?eventPage=${eventPageVO.page+1}&regionDepth1=${eventPageVO.regionDepth1}&regionDepth2=${eventPageVO.regionDepth2}">▷</a>
    </c:if>
    <c:if test="${not eventPageVO.lastBlock}">
        <a href="?eventPage=${eventPageVO.nextPage}&regionDepth1=${eventPageVO.regionDepth1}&regionDepth2=${eventPageVO.regionDepth2}">▶▶</a>
    </c:if>
</div>
</c:if>




