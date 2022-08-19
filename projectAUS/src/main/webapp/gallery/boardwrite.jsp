<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
		if(session.getAttribute("userEMAIL") != null){
			userEMAIL = (String) session.getAttribute("userEMAIL");
		}
		
	%>
	<%
		if(userEMAIL == null){					
	%>
		
	<div class="bottombar">
				<a href="login.jsp">Login</a> <a href="join.jsp">Join</a> <a
					href="contact.jsp">Contact us</a>
			</div>

			<%
				} else {
			%>
			<div class="bottombar">
			 <a href="logoutAction.jsp">LOGOUT</a>
				<a href="mypage.jsp">My Info</a>
				<a href="contact.jsp">Contact us</a>
			</div>
			<%
				}
			%>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="main.jsp">RFFA</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active"><a class="nav-link"
					href="notice.jsp">우리 단체는 <span class="sr-only">(current)</span></a>
				</li>
				<li class="nav-item active"><a class="nav-link"
					href="board.jsp">현지 소식 <span class="sr-only">(current)</span></a></li>
				<li class="nav-item active"><a class="nav-link"
					href="donate.jsp">후원 하기 <span class="sr-only">(current)</span></a>
				</li>
			</ul>
			<form class="form-inline my-2 my-lg-0">
				<input class="form-control mr-sm-2" type="search"
					placeholder="Search" aria-label="Search">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
			</form>
		</div>
	</nav>
<article>
<form action="boardwritepro.jsp" method="post" enctype="multipart/form-data">
<table class="table">
    <tr>
      <th scope="col">아이디</th>
      <td><input type="text" name="id" value="<%=userEMAIL%>" readonly></td>
    </tr>
    <tr>
      <th scope="col">PassWord</th>
      <td><input type="password" name="passwd"></td>
	</tr>
	<tr>
	<th scope="col">Subject</th>
	<td><input type="text" name="subject"></td>
	</tr>
    <tr>
	<th scope="col">Image Upload</th>
	<td><input type="file" name="image"></td>
	</tr>
  <tr>
	<th scope="col">Content</th>
	<td><textarea rows="13" cols="40" name="content"></textarea></td>
	</tr>	
  </table>
  <div id="table_search">
					<input type="submit" value="Submit" class="btn">
					<input type="reset" value="Reset" class="btn">
					<input type="button" value="List" class="btn"
						   onclick="location.href = 'board.jsp'">
				</div>	
				</form>		
				<div class="clear"></div>
</article>



</body>
</html>