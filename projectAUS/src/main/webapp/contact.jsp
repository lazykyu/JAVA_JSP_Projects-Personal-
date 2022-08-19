<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width",initial-scale="1">
<link rel="stylesheet" href="//unpkg.com/bootstrap@4/dist/css/bootstrap.min.css">
<script src='//unpkg.com/jquery@3/dist/jquery.min.js'></script>
<script src='//unpkg.com/popper.js@1/dist/umd/popper.min.js'></script>
<script src='//unpkg.com/bootstrap@4/dist/js/bootstrap.min.js'></script>
	
<link rel="stylesheet" href="css/OnlyFor-bottombar.css" />


<title>Insert title here</title>
</head>
<body>
	
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
        <a class="nav-link" href="board.jsp">현지 소식 <span class="sr-only">(current)</span></a>
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
 
<form action="mailSend" method="post">
				<h1>Mail</h1>
				<table id="notice">
					<tr>
						<td>Sender</td>
						<td><input type="text" name="sender" placeholder="보내시는 분" ></td>
					</tr>
					<tr>
						<td>Reaceiver</td>
						<td><input type="text" name="receiver"></td>				
					</tr>
					<tr>
						<td>Subject</td>
						<td><input type="text" name="subject"></td>
					</tr>
					<tr>
						<td>Content</td>
						<td><textarea name="content" cols=40 rows=15></textarea></td>
					</tr>								
				</table>	
				<div id="table_search">
					<input type="submit" value="Send" class="btn">					
				</div>
			</form>
		
		<div class="bottombar">
  		<a href="join.jsp">Join</a>
 		<a href="contact.jsp">Contact us</a>
</div>
		
</body>
</html>