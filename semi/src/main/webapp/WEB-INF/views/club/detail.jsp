<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container w-800">
		<div class="cell">
			<div class="flex-box">
				<button type="button" class="btn btn-primary w-25 ">수정</button>
				<button type="button" class="btn btn-primary w-25 ms-20">삭제</button>
			</div>
		</div>
        <div class="cell center">
            <h1>모임 이름</h1>
        </div>

        <div class="cell">
            <h2>모임 소개</h2>
        </div>
        <div class="cell">
            <textarea>club introduce</textarea>
        </div>

        <div class="cell">
            <h2>정모일정</h2>
        </div>
        
        <div class="cell">
            <h2>모임장</h2>
        </div>

        <div class="cell">
            <h2>모인 멤버</h2>
        </div>
        
        <div class="cell">
                <button type="submit" class="btn btn-primary w-100">참여하기</button>
            </div>


    </div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>