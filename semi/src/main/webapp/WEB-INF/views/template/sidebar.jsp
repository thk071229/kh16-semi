<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
        <style>
        /* 아이디는 해시(#)를 이용하여 선택한다*/
        #hide{
            display:none;
        }
        /* 사이드바 디자인 */
        #toggle{
            display:none;
        }
		.sidebar-in {
            background-color: rgba(254, 255, 254, 0.9);
            position:fixed;
            top:80px;
            left:20px;
            bottom:0;
            z-index:999;
            width: 210px;
			box-shadow: 0 4px 15px rgba(0,0,0,0.3); 
			border-radius : 0.5em;
			
		}
		
        #toggle + .sidebar{
            background-color: rgba(164, 224, 199, 0.9);
            position:fixed;
            top:0;
            left:0;
            bottom:0;
            z-index:999;
            width: 250px;
            /* 사이드바에 애니메이션 효과 적용 */
            transition-property: transform; 
            transition-duration: 0.2s;
            transition-timing-function: ease-out;
        }

        #toggle:checked + .sidebar {
            transform: translate(-95%,0);
        } 
        #toggle ~ .toggle-label{
            font-size:24px;
            width: 1.5em;
            height: 1.5em;
            
            border: 3px solid #51595c;
            border-radius: 0.2em;
            color: #51595c;
            cursor:pointer;

            display:inline-flex;
            justify-content: center;
            align-items: center;
            
            position:fixed;
            top:1em;
            left:1em;
            z-index:1000;
        }
        #toggle ~ .toggle-label:hover {
            border-color:black;
            color:black;
        }
        
        #toggle ~ .toggle-label > .fa-bars,
        #toggle:checked ~ .toggle-label > .fa-xmark
        {
            display:none;
        }

        #toggle ~ .toggle-label > .fa-xmark,
        #toggle:checked ~ .toggle-label > .fa-bars
        {
            display:block;
        }

    </style>
  

<%-------사이드바 -------%>
        <div>
            <input type="checkbox" id="toggle" checked>
                
            <div class="sidebar">
				<c:choose>
					<%-- 비로그인 --%>
				 	<c:when test="${sessionScope.loginId == null}">
						<div class="center">
							<h2>비회원 상태</h2>
						</div>
						<div class="sidebar-in">
							<div class="cell center">
								<a href="/member/login">
								<i class="fa-solid fa-right-to-bracket"></i> <span>로그인</span></a>
							</div>
							<div class="cell center">
									<a href="/member/join">
									<i class="fa-solid fa-user-plus"></i> <span>회원가입</span></a>
							</div>
						</div>
					</c:when>
					<%-- 로그인 상태일때 --%>
					<c:otherwise>
						<div class="sidebar-in">
							<div class="cell center">
								<img src="/member/profile?memberId=${sessionScope.loginId}" width="150" height="150" class="image-profile">
							</div>
							<div class="cell center">
								<h3 class="mb-0">${sessionScope.loginId}</h3>
								<h5 class="mt-0">(${sessionScope.loginLevel})</h5>
							</div>
							<div class="cell center">
								<a href="/member/mypage"> <i class="fa-solid fa-user"></i>
									<span>내 정보 보기</span>
								</a>
							</div>
							<div class="cell center">
								<a href="/member/logout"> <i class="fa-solid fa-user"></i>
									<span>로그아웃</span>
								</a>
							</div>
							<hr><hr>
							<div class="cell ms-30">
								<a href="#"> <i class="fa-solid fa-user"></i>
									<span>기능1</span>
								</a>
							</div>
							<div class="cell ms-30">
								<a href="#"> <i class="fa-solid fa-user"></i>
									<span>기능2</span>
								</a>
							</div>
							<div class="cell ms-30">
								<a href="#"> <i class="fa-solid fa-user"></i>
									<span>기능3</span>
								</a>
							</div>
							<div class="cell ms-30">
								<a href="#"> <i class="fa-solid fa-user"></i>
									<span>기능4</span>
								</a>
							</div>
						</div>
					</c:otherwise>
				</c:choose>
            </div>
            
             <label for="toggle" class="toggle-label">
                    <i class="fa-solid fa-bars"></i>
                    <i class="fa-solid fa-xmark"></i>
                </label>
        </div>
