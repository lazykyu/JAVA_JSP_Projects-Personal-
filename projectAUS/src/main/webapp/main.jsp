<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">

<link rel="stylesheet" href="//unpkg.com/bootstrap@4/dist/css/bootstrap.min.css">
<script src='//unpkg.com/jquery@3/dist/jquery.min.js'></script>
<script src='//unpkg.com/popper.js@1/dist/umd/popper.min.js'></script>
<script src='//unpkg.com/bootstrap@4/dist/js/bootstrap.min.js'></script>
	
<link rel="stylesheet" href="css/OnlyFor-bottombar.css" />




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
  <a class="navbar-brand" href="#">RFFA</a>
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
  <h1 class="display-4"><b>Australian Wildfires Continue</b></h1>
  <p class="lead">이 공간은 현재 산불로 고통받고 있는 호주의 시민, 소방대, 그리고 야생의 많은 동물들을 돕기 위해 만들어진 곳
					입니다. 그들에게 도움을 주세요</p>
  <hr class="my-4">
   <a class="btn btn-outline-primary btn-lg" href="board.jsp" role="button">현지 상황 알아보기</a>
</div>
	
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
		integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
		crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
		integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
		crossorigin="anonymous"></script>
	<script> $('.carousel').carousel({ interval: 2000 }) </script>
	
	<div id="demo" class="carousel slide" data-ride="carousel">
		<div class="carousel-inner">
			<!-- 슬라이드 쇼 -->
			<div class="carousel-item active">
				<!--가로-->
			
				<img class="d-block w-100"
					src="images/1.jpg"
					alt="First slide">
				<div class="carousel-caption d-none d-md-block">
					<p>The Australia flag flies under red skies from the fires on Jan. 4 in Bruthen, Australia.
					Two people are dead and 28 remain missing following bushfires across the East Gippsland area, 
					with Victorian premier Daniel Andrews declaring a state of disaster in the region. 
					Thousands of people remain stranded in the coastal town of Mallacoota and are being evacuated by navy ships to Melbourne.</p>
				</div>
			</div>
			<div class="carousel-item">
				<img class="d-block w-100"
					src="images/2.jpg"
					alt="Second slide">
				<div class="carousel-caption d-none d-md-block">
				<p>Koala rescued from Australia’s wildfire wasteland</p>
				</div>	
			</div>
			<div class="carousel-item">
				<img class="d-block w-100"
					src="images/3.jpg"
					alt="Third slide">
						<div class="carousel-caption d-none d-md-block">
				<p>Australia fires: The thousands of volunteers fighting the flames</p>
				</div>	
			</div>
			
			<div class="carousel-item">
				<img class="d-blocsk w-100"
					src="images/4.jpg"
					alt="Third slide">
					
			</div>
			<!-- / 슬라이드 쇼 끝 -->


			
			<!-- 왼쪽 오른쪽 화살표 버튼 -->
			<a class="carousel-control-prev st" href="#demo" data-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<!-- <span>Previous</span> -->
			</a> <a class="carousel-control-next st" href="#demo" data-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<!-- <span>Next</span> -->
			</a>
			<!-- / 화살표 버튼 끝 -->
		
		</div>
		</div>
		
		
		

		<%
			if (userEMAIL == null) {
		%>

		<div class="bottombar" style="z-index: 9999;">
			<a href="login.jsp">Login</a>
			<a href="join.jsp">Join</a>
			<a href="contact.jsp">Contact us</a>
		</div>
		<%
			} else {
		%>
		<div class="bottombar">
			<a href="logoutAction.jsp">Logout</a>
			<a href="mypage.jsp">MyInfo</a>
			<a href="contact.jsp">Contact us</a>
		</div>
		<%
			}
		%>
	
</body>


</html>