<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<h2>카테고리별 회원 수</h2>
<ul>
    <c:forEach var="item" items="${list1}">
        <li>${item.title}: ${item.value}</li>
    </c:forEach>
</ul>

<h2>지역별 회원 수</h2>
<ul>
    <c:forEach var="item" items="${list2}">
        <li>${item.title}: ${item.value}</li>
    </c:forEach>
</ul>

<h2>연령대별 비율</h2>
<ul>
    <c:forEach var="item" items="${list3}">
        <li>${item.title}: ${item.value}</li>
    </c:forEach>
</ul>

<h2>성별 비율</h2>
<ul>
    <c:forEach var="item" items="${list4}">
        <li>${item.title}: ${item.value}</li>
    </c:forEach>
</ul>
    