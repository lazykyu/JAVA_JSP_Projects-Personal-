<%@ page import="fileud.FileDAO" %>
<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>

<%
	request.setCharacterEncoding("UTF-8");
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">

	
<link rel="stylesheet" href="//unpkg.com/bootstrap@4/dist/css/bootstrap.min.css">
<script src='//unpkg.com/jquery@3/dist/jquery.min.js'></script>
<script src='//unpkg.com/popper.js@1/dist/umd/popper.min.js'></script>
<script src='//unpkg.com/bootstrap@4/dist/js/bootstrap.min.js'></script>
	
<link rel="stylesheet" href="css/OnlyFor-bottombar.css" />



<title>Insert title here</title>
</head>
<body>
<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
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
		<%
			String directory = application.getRealPath("/upload/");
					int maxSize = 1024 * 1024 * 100;
					String encoding = "UTF-8";
					
					MultipartRequest multipartRequest
					= new MultipartRequest(request, directory, maxSize, encoding,
							new DefaultFileRenamePolicy());
			
					String fileName = multipartRequest.getOriginalFileName("fileud");
			String fileRealName = multipartRequest.getFilesystemName("fileud");
			
			new FileDAO().upload(fileName, fileRealName);
			out.write("파일명: " + fileName + "<br>");
			out.write("실제 파일명: " + fileRealName + "<br>");
		%>
		
		
			
			
			<%
			if(userID == null){
		%>
		<div class="bottombar">
  		<a href="login.jsp">Login</a>
  		<a href="join.jsp">Join</a>
 		<a href="contact.jsp">Contact us</a>
</div>
		<%
			}else{
		%>
		<div class="bottombar">
  		<a href="logoutAction.jsp">Logout</a>
  		<a href="mypage.jsp">My Info</a>
 		<a href="contact.jsp">Contact us</a>
</div>
		<%
			}
		%>

</body>
</html>