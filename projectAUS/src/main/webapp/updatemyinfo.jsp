<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@page import="user.UserBean"%>
	<%@page import="user.UserDAO"%>
	<%
		request.setCharacterEncoding("UTF-8");
		String userEMAIL = (String)session.getAttribute("userEMAIL");
		UserBean userBean = new UserBean();
		UserDAO userdao = new UserDAO();
		
		userBean = userdao.getUser(userEMAIL);
	%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width",initial-scale="1">
	<!-- 최소화된 최신 CSS --> 
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    <!-- 부가테마 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
    <!-- 최소화된 최신 자바스크립트 -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="css/OnlyFor-bottombar.css"/>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-Latest.js"></script>
	
	<script>
	 	function postCode() {
	 		new daum.Postcode({
	 			oncomplete:function(data) { 				
	 				$('[name=userPOSTCODE]').val(data.zonecode);
	 				$('[name=userADDRESS]').val(data.address);			
	 			}
	 		}).open();
	 	}
	</script>
<title>Insert title here</title>

</head>
<body>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
			data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
			aria-expanded="false">
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">Relief Fund for Australia's Bushfire</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1"> 
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">호주는 지금..</a></li>
				<li><a href="board.jsp">현상황</a></li>			
			</ul>
		</div>
		</nav>
		<div class="container" style="padding-top: 40px;">
			<div class="col-lg-4"></div>
			<div class="col-lg-4">
				<div class="jumbotron" style="padding-top: 20px;">
				<form method="post" action="updatemyinfopro.jsp" name="fr">
					<h3 style="text-align: center;"> MODIFY</h3><br>
					
					<div class="form-group">
					 <input type="email" class="form-control" placeholder="EMAIL" name="userEMAIL" maxlength="40" value="<%=userBean.getUserEMAIL()%>" disabled > 
					</div><br>
					<div class="form-group">
					 <input type="password" class="form-control" placeholder="PASSWORD" name="userPWD" maxlength="15" value="<%=userBean.getUserPWD() %>" > 
					</div><br>
					<div class="form-group">
					 <input type="text" class="form-control" placeholder="FULL NAME" name="userNAME" maxlength="20" value="<%=userBean.getUserNAME() %>" > 
					</div><br>
					<div class="form-group">
					<input type="button" onclick="postCode()" class="dup" value="Find ZipCode">
					<input type="text" class="form-control" name="userPOSTCODE" placeholder="ZIP CODE" maxlength="10" value="<%=userBean.getUserPOSTCODE() %>" >
					<input type="text" class="form-control" placeholder="ADDRESS" name="userADDRESS" maxlength="100" value="<%=userBean.getUserADDRESS() %>" > 
					</div><br>
					<div class="form-group">
					 <input type="tel" class="form-control" placeholder="CELL PHONE" name="userCPNUM" maxlength="14" value="<%=userBean.getUserCPNUM() %>" > 
					</div><br>
					
					
					<input type="submit" class="btn btn-primary form-control" value="DONE" onclick="">
				
					</form>
			</div>
		</div>
		<div class="col-lg-4"></div>
		</div>
		
		<div class="bottombar">
  		<a href="logout.jsp">Logout</a>
 		<a href="contact.jsp">Contact us</a>
</div>
		
</body>
</html>