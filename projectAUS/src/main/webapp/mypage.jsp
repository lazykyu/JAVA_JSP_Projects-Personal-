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
		
		
		<div class="container" style="padding-top: 40px;">
			
				<div class="jumbotron" style="padding-top: 20px;">
				<form method="post" action="updatemyinfo.jsp">
					<h3 style="text-align: center;"> My Info</h3><br>
		
					<div class="form-group">
					 <input type="text" class="form-control" name="userEMAIL" value="<%=userBean.getUserEMAIL()%> " disabled> 
					</div><br>
					<div class="form-group">
					 <input type="password" class="form-control" name="userPWD" value="<%=userBean.getUserPWD()%>" disabled> 
					</div><br>
					<div class="form-group">
					 <input type="text" class="form-control"  name="userNAME" value="<%=userBean.getUserNAME()%>" disabled> 
					</div><br>
					<div class="form-group">
					 <input type="text" class="form-control" name="userPOSTCODE" value="<%=userBean.getUserPOSTCODE() %> "disabled> 
					</div><br>
					<div class="form-group">
					 <input type="text" class="form-control" name="userADDRESS" value="<%=userBean.getUserADDRESS() %> "disabled> 
					</div><br>
					<div class="form-group">
					 <input type="text" class="form-control" name="userCPNUM" value="<%=userBean.getUserCPNUM() %> "disabled> 
					</div><br>
					
					<input type="submit" class="btn btn-primary form-control" value="MODIFY">
				
					</form>
			</div>
		</div>
		<div class="col-lg-4"></div>
		</div>

</body>
</html>