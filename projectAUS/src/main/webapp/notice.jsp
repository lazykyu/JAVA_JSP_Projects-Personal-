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


<div class="jumbotron jumbotron-fluid">
  <div class="container">
    <h1 class="display-4">Rescue Fund For Australia </h1>
    <p class="lead">Australian Bushfires are sweeping the continent of Australia. 
    Historically high temperatures across Australia are rewriting climate history, 
    and therefore creating “Catastrophic” bushfire conditions. Many are horrified by the images of devastation, 
    caused by the Australian Bushfires that are burning in every State.
	
	People want to send more than just “Thoughts and Prayers”.</p>
	 <div align="center"><a class="btn btn-outline-primary btn-lg"  href="donate.jsp" role="button">DONATE NOW</a></div>
  </div>
</div>

	<p align="center"> About Us
About IIE Scholar Rescue FundBack to top
Around the world, scholars have long suffered harassment, detention, torture, and other forms of persecution as a result of their work. In the worst cases, scholars pay with their lives for their dedication to their academic work and freedom of thought. The Institute of International Education (IIE), an independent not-for-profit organization, has participated in the rescue of persecuted scholars since its founding in 1919. In 2002, IIE launched the Scholar Rescue Fund (IIE-SRF) to formalize its commitment to protecting the lives, voices, and ideas of scholars around the globe.

OUR HISTORY
IIE's history of scholar rescue dates back to 1919.
Learn more »
IIE-SRF is the only global program that arranges and funds fellowships for threatened and displaced scholars at partnering higher education institutions worldwide. 
IIE-SRF selects outstanding professors, researchers, and public intellectuals for fellowship support and arranges visiting academic positions with partnering institutions of higher learning and research. Our fellowships enable scholars to pursue their academic work in safety and to continue to share their knowledge with students, colleagues, and the community. If conditions in the scholars’ home countries improve, scholars may return after their fellowships to make meaningful contributions to their national academies and civil society. If safe return is not possible, scholars may use the fellowship period to identify longer-term opportunities.

Since 2002, IIE-SRF has provided life-saving support to 844 scholars from 59 countries in partnership with over 400 host institutions in 46 countries around the world.
In addition to assisting individual scholars, IIE-SRF has implemented special initiatives to respond to large-scale crises affecting national academies. For example, in 2007, IIE-SRF launched the Iraq Scholar Rescue Project that supported more than 300 of Iraq’s most senior and threatened academics to continue their work, primarily in the Middle East and North Africa. Since the 2011 outbreak of conflict in Syria, the program has awarded fellowships to over 100 Syrian scholars. For our work, the program was awarded the Middle East Studies Association (MESA)’s 2013 Academic Freedom Award.

“With one suitcase and hundreds of questions and concerns, we were supported by the Scholar Rescue Fund to find answers, be settled, develop ideas, start to work, and reach our goals." - Dr. Arash Alaei, IIE-SRF alumnus and recipient (along with Dr. Kamiar Alaei) of IIE-SRF’s 2018 Outstanding Scholar Award </p>

<p align="center"> <h1 align="center">DONATE NOW TO SEND AID FOR THE AUSTRALIAN BUSHFIRES</h1></p>


		<%
			if (userEMAIL == null) {
		%>

		<div class="bottombar">
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