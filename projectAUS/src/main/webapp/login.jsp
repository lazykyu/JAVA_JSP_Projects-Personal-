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

<style>
.wrapper {margin: 0 auto;}
</style>

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
 
<h1 class="text-center" style="padding-top: 40px;">LOGIN</h1>
<div class="container pt-3">
  <div class="row justify-content-sm-center">
    <div class="col-sm-6 col-md-4">

      <div class="card border-info text-center">
        <div class="card-header">
          Sign in to continue
        </div>
       <div class="card-body">
        <form class="form-signin" method="post" action="loginAction.jsp">
            <input type="email" class="form-control mb-2" placeholder="Email" required autofocus name="userEMAIL" >
            <br>
            <input type="password" class="form-control mb-2" placeholder="Password" required name="userPWD">
            <br><br>
            <button class="btn btn-lg btn-primary btn-block mb-1" type="submit">Sign in</button>
            <label class="checkbox float-left">
              <input type="checkbox" value="remember-me">
              Remember me
            </label>
            <a href="noticeformayouhito.jsp" class="float-right">Need help?</a>
          </form>
        </div>
      </div>
      
      <a href="join.jsp" class="float-right">Create an account </a>
    </div>
  </div>
</div>
		
		<div class="bottombar">
  		<a href="join.jsp">Join</a>
 		<a href="contact.jsp">Contact us</a>
</div>
		
</body>
</html>