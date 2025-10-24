<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
/* category-add.jsp 전용 스타일 */

.page-header {
  text-align: center;
  margin: 30px 0 40px;
  color: var(--ink);
}

/* 폼 전체 */
.form-wrapper {
  max-width: 500px;
  margin: 0 auto;
  background: var(--surface);
  padding: 30px 40px;
  border-radius: var(--radius);
  box-shadow: var(--shadow);
}

/* 입력 라벨 & 필드 */
.form-group {
  display: flex;
  flex-direction: column;
  margin-bottom: 20px;
}

.form-group label {
  font-weight: 600;
  margin-bottom: 8px;
  color: var(--ink);
}

.form-group input[type="text"] {
  border: 1px solid #dcdcdc;
  border-radius: 8px;
  padding: 10px 12px;
  font-size: 15px;
  transition: border-color 0.2s ease, box-shadow 0.2s ease;
}

.form-group input[type="text"]:focus {
  border-color: var(--primary);
  box-shadow: 0 0 0 3px rgba(127,200,169,0.2);
  outline: none;
}

/* 버튼 */
.submit-btn {
  display: block;
  width: 100%;
  background: var(--primary);
  color: #fff;
  font-weight: 600;
  border: none;
  border-radius: 8px;
  padding: 12px;
  font-size: 16px;
  cursor: pointer;
  transition: background 0.2s ease, transform 0.2s ease;
}

.submit-btn:hover {
  background: var(--primary-600);
  transform: translateY(-2px);
}

.submit-btn:active {
  transform: translateY(0);
}
</style>

<form autocomplete="off" action="add" method="post">
  <div class="container">
    
    <div class="cell">
      <h1 class="page-header">카테고리 추가</h1>
    </div>

    <div class="form-wrapper">
      <div class="form-group">
        <label for="categoryName">카테고리 명</label>
        <input type="text" id="categoryName" name="categoryName" placeholder="카테고리 이름을 입력하세요" required>
      </div>
      
      <button type="submit" class="submit-btn">+ 추가하기</button>
    </div>

  </div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
