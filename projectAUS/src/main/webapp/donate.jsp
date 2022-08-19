<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">

<link rel="stylesheet" href="//unpkg.com/bootstrap@4/dist/css/bootstrap.min.css">
<script src='//unpkg.com/jquery@3/dist/jquery.min.js'></script>
<script src='//unpkg.com/popper.js@1/dist/umd/popper.min.js'></script>
<script src='//unpkg.com/bootstrap@4/dist/js/bootstrap.min.js'></script>
	
<link rel="stylesheet" href="css/OnlyFor-bottombar.css" />


<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<title>Insert title here</title>
</head>
<body>
	
	<%
		String userEMAIL = null;
		if (session.getAttribute("userEMAIL") != null) {
			userEMAIL = (String) session.getAttribute("userEMAIL");
		}
	%>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="main.jsp">RFFA</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
    	<li class="nav-item active">
        <a class="nav-link" href="notice.jsp">우리 단체는 <span class="sr-only">(current)</span></a>
      </li>
     <li class="nav-item active">
        <a class="nav-link" href="../gallery/board.jsp">현지 소식 <span class="sr-only">(current)</span></a>
      </li>
       <li class="nav-item active">
        <a class="nav-link" href="board.jsp">현지 소식2 <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item active">
        <a class="nav-link" href="upload.jsp">자료실 <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item active">
        <a class="nav-link" href="donate.jsp">후원 하기 <span class="sr-only">(current)</span></a>
      </li>
    </ul>
    <form class="form-inline my-2 my-lg-0">
      <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
    </form>
  </div>
</nav>

	<div class="jumbotron" style="background-color: transparent;">
  <h1 class="display-4">후원 결제</h1>
  <p class="lead">현재 점검중으로 카카오페이로만 결제가 가능합니다. 금액또한 현재 1,000KRW 한단위 씩만 가능합니다.</p>
  <hr class="my-4">
  <p>금액 선택 (현재 1000원 외 결제 불가)</p>
  <a class="btn btn-primary btn-lg" href="#" role="button" id="check_module">1,000KRW</a> 
  <a class="btn btn-primary btn-lg" href="#" role="button">3,000KRW</a>
  <a class="btn btn-primary btn-lg" href="#" role="button">5,000KRW</a> 
  <a class="btn btn-primary btn-lg" href="#" role="button">10,000KRW</a>
  
  
</div>
	
	<script>
		$("#check_module").click(function() {
			var IMP = window.IMP; // 생략가능
			IMP.init("imp11426028");
			// 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
			// i'mport 관리자 페이지 -> 내정보 -> 가맹점식별코드
			IMP.request_pay({
				pg : 'kakao', // version 1.1.0부터 지원.
				/*
				 'kakao':카카오페이,
				 html5_inicis':이니시스(웹표준결제)
				 'nice':나이스페이
				 'jtnet':제이티넷
				 'uplus':LG유플러스
				 'danal':다날
				 'payco':페이코
				 'syrup':시럽페이
				 'paypal':페이팔
				 */

				pay_method : 'card',
				/*
				 'samsung':삼성페이,
				 'card':신용카드,
				 'trans':실시간계좌이체,
				 'vbank':가상계좌,
				 'phone':휴대폰소액결제
				 */
				merchant_uid : 'merchant_' + new Date().getTime(),
				/*
				 merchant_uid에 경우
				 https://docs.iamport.kr/implementation/payment
				 위에 url에 따라가시면 넣을 수 있는 방법이 있습니다.
				 참고하세요.
				 나중에 포스팅 해볼게요.
				 */
				name : 'Relief fund for Australia',
				//결제창에서 보여질 이름
				amount : 2000,
				//가격
				buyer_email : 'rffa@donate.com',
				buyer_name : '성민규',
				buyer_tel : '080-8916-1345',
				buyer_addr : 'Hokkido Sapporo-shi chuo-ward 1-15-5 KIBOU B/D 2F',
				buyer_postcode : '211-0005',
				m_redirect_url : 'https://www.yourdomain.com/payments/complete'
			/*
			 모바일 결제시,
			 결제가 끝나고 랜딩되는 URL을 지정
			 (카카오페이, 페이코, 다날의 경우는 필요없음. PC와 마찬가지로 callback함수로 결과가 떨어짐)
			 */
			}, function(rsp) {
				console.log(rsp);
				if (rsp.success) {
					var msg = '결제가 완료되었습니다.';
					msg += '고유ID : ' + rsp.imp_uid;
					msg += '상점 거래ID : ' + rsp.merchant_uid;
					msg += '결제 금액 : ' + rsp.paid_amount;
					msg += '카드 승인번호 : ' + rsp.apply_num;
				} else {
					var msg = '결제에 실패하였습니다.';
					msg += '에러내용 : ' + rsp.error_msg;
				}
				alert(msg);
			});
		});
	</script>






</body>
</html>