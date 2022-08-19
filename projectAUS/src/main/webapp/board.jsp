<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.io.PrintWriter" %>
    <%@ page import="hboard.hBoardDAO" %>
    <%@ page import="hboard.hBoardBean" %>
    <%@ page import="java.util.ArrayList" %>
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
<style type="text/css">
	a, a:hover {
	color: #;
	text-decoration:  none;}

</style>
</head>
<body>
	<% 
		String userEMAIL = null;
		if(session.getAttribute("userEMAIL") != null){
			userEMAIL = (String) session.getAttribute("userEMAIL");
		}
	
		int pageNumber = 1; 
		if (request.getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
				if(userEMAIL == null){					
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
  				<a href="logoutAction.jsp">LOGOUT</a>
  				<a href="mypage.jsp">My Info</a>
 				<a href="contact.jsp">Contact us</a>
				</div>
			<% 
				}
			%>		
			
			<h1 style="text-align: center;">언론 기사 발췌</h1>
			<div class="container">
			<div class="row">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd; padding-top: 100px;" >
					<thead>
						<tr>
							<th style="background-color; #eeeeee; text-align:center;">No.</th>
							<th style="background-color; #eeeeee; text-align:center;">제   목</th>
							<th style="background-color; #eeeeee; text-align:center;">작성자</th>
							<th style="background-color; #eeeeee; text-align:center;">작성일</th>
							
						</tr>
						</thead>
						<tbody>
							<%
								hBoardDAO boardDAO = new hBoardDAO();
								ArrayList<hBoardBean> list = boardDAO.getList(pageNumber);
								for(int i = 0; i < list.size(); i++){
							
							%>						
						
							<tr>
								<td><%= list.get(i).getBoardIDX() %></td>
								<td><a href="view.jsp?boardIDX=<%= list.get(i).getBoardIDX() %>"><%= list.get(i).getBoardTitle() %></a></td>
								<td><%= list.get(i).getUserID() %></td>
								<td><%= list.get(i).getBoardDate() %></td>
							
							</tr>
							
							<%
								}
							%>
						</tbody>
						</table>
						<%
							if(pageNumber != 1){						
						%>
						
							<a href="board.jsp?pageNumber=<%=pageNumber - 1%>"  class="btn btn-success btn-arraw-left">다음 </a>
						<%  	
							}if(boardDAO.nextPage(pageNumber + 1)) {
						%>	
							<a href="board.jsp?pageNumber=<%=pageNumber + 1%>"  class="btn btn-success btn-arraw-left">이전 </a>
						<%
							}
						%>	
							
						<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
						</div>
					</div>	

</body>
</html>