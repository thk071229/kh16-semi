<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
.profile-info {
  flex: 1;
  background: var(--surface);
  border-radius: var(--radius);
  box-shadow: var(--shadow);
  padding: 20px;
}
.profile-info table {
  width: 100%;
  border-collapse: collapse;
}
.profile-info th, .profile-info td {
  border: 1px solid #dcdcdc;
  padding: 8px;
  text-align: center;
}
.profile-info th {
  background: var(--muted);
  color: var(--ink);
  font-weight: 600;
}
</style>



<div class="container w-1000">
	<div class="profile-info">
	<textarea class="terms-box" rows="30"readonly>
[서비스 이름] 위치기반서비스 이용약관

제1조 (목적) 본 약관은 [서비스 이름](이하 '회사'라 함)이 제공하는 위치기반서비스(이하 '서비스'라 함)를 이용함에 있어 '회사'와 회원의 권리, 의무 및 책임사항, 기타 필요한 사항을 규정함을 목적으로 합니다.

제2조 (수집하는 개인위치정보의 항목 및 수집 방법) ① 회사는 서비스 제공을 위해 아래와 같은 개인위치정보를 수집합니다.

GPS(위성항법장치), Wi-Fi(무선랜), Cell ID(기지국) 등을 통해 수집되는 단말기의 위치정보 (좌표값: 위도, 경도) ② 위치정보 수집 방법:

서비스 실행 시 또는 '위치 공유' 기능 사용 시 단말기에서 자동으로 수집

제3조 (개인위치정보의 이용 목적) 회사는 수집한 개인위치정보를 다음의 목적을 위해 이용합니다.

현재 위치를 활용한 콘텐츠 제공 (예: 주변 장소 검색, 날씨 정보)

사용자의 위치를 포함한 게시물 작성 및 공유 기능 (예: '체크인' 기능)

위치 정보를 활용한 맞춤형 광고 및 이벤트 정보 제공 (선택적 동의 시)

서비스 이용 통계 및 부정이용 방지

제4조 (개인위치정보의 보유기간 및 이용기간) 회사는 위치정보 수집 및 이용 목적이 달성된 때, 또는 회원이 동의를 철회한 때에는 수집된 개인위치정보를 지체 없이 파기합니다. 단, 「위치정보의 보호 및 이용 등에 관한 법률」 제16조 제2항에 따라 위치정보 이용·제공사실 확인자료는 해당 서비스 이용 내역과 함께 1년간 보관할 수 있습니다.

제5조 (개인위치정보주체의 권리) ① 회원은 언제든지 개인위치정보의 수집·이용·제공에 대한 동의의 전부 또는 일부를 철회할 수 있습니다. ② 회원은 '회사'에 대하여 자신의 개인위치정보의 수집, 이용 또는 제공의 일시적인 중지를 요구할 수 있습니다. ③ 제1항 및 제2항에 따른 권리 행사는 '마이페이지 > 회원정보 수정' 또는 '애플리케이션 설정' 메뉴를 통해 직접 수행하거나 고객센터를 통해 요청할 수 있습니다.

제6조 (위치정보관리책임자) 회사는 위치정보를 적절히 관리·보호하고, 개인위치정보주체의 불만을 원활히 처리할 수 있도록 실질적인 책임을 질 수 있는 위치정보관리책임자를 지정해 운영합니다.

▶ 위치정보관리책임자 (개인정보 보호책임자가 겸임 가능) 성명: [담당자 이름] 직책: [담당자 직책] 연락처: [전화번호], [이메일]

제7조 (고지의 의무) 본 약관의 내용 추가, 삭제 및 수정이 있을 시에는 개정 최소 7일 전부터 홈페이지의 '공지사항'을 통해 고지할 것입니다.

공고일자: [시행일자 예: 2025년 10월 24일]

시행일자: [시행일자 예: 2025년 10월 24일]
        	</textarea>

	 </div>
</div>

  
  
  
  
  <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
  