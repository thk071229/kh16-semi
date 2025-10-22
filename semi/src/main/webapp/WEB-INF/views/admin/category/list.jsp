<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container">
	
	<div class="cell">
		<h1>카테고리 관리</h1>
	</div>
	<div>
		<a href="add">신규 카테고리 추가</a>
	</div>
	<div>
		<table border="1" width="700">
			<thead>
				<tr>
					<th>카테고리 번호</th>
					<th>카테고리 이름</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="categoryDto" items="${categoryList}">
				<tr>
					<td>
						${categoryDto.categoryNo}
					</td>
					<td>
						${categoryDto.categoryName}
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

</div>