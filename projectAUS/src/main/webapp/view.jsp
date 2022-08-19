<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ page import="java.io.PrintWriter" %>
	<%@ page import="board.BoardBean" %>
	<%@ page import="board.BoardDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" ,initial-scale="1">
<!-- 최소화된 최신 CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가테마 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 최소화된 최신 자바스크립트 -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="css/OnlyFor-bottombar.css"/>
	
<title>Insert title here</title>
</head>
<body>
	<% 
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		int boardIDX = 0;
		if(request.getParameter("boardIDX") != null) {
			boardIDX = Integer.parseInt(request.getParameter("boardIDX"));
		}
		if (boardIDX == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다')");
			script.println("location.href = 'board.jsp'");
			script.println("</script>");
		}
		BoardBean board = new BoardDAO().getBoard(boardIDX);
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">Relief Fund for
				Australia's Bushfire</a>
		</div>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">호주는 지금..</a></li>
				<li class="active"><a href="board.jsp">현상황</a></li>
			</ul>
			<%

			if(userID == null){					
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
		</div>
	</nav>
	<h1 style="text-align: center;">언론 기사 발췌</h1>
	<div class="container">
		<div class="row">
				<table class="table table-striped"
					style="text-align: center; border: 1px solid #dddddd; padding-top: 150px;">
					<thead>
					<tr>
						<th colspan="3" style="background-color: #eeeeee;  text-align: center;">글 보기</th>
					</tr>
					</thead>
					<tbody>
						<tr>
							<td style="width: 20%;">제  목</td>
							<td colspan="2"><%= board.getBoardTitle().replaceAll(" " , "&nbsp;").replace("<","&lt;").replaceAll(">", "&gt;")%></td>
						</tr>
						<tr>
							<td>작성자</td>
							<td colspan="2"><%= board.getUserID() %></td>
						</tr>
						<tr>
							<td>작성일자</td>
							<td colspan="2"><%= board.getBoardDate() %></td>
						</tr>
						<tr>
							<td>글 내용</td>
							<td colspan="2" style="min-height:200px; text-align: left;"><%= board.getBoardContent().replaceAll(" " , "&nbsp;").replaceAll("<","&lt;").replaceAll(">", "&gt;").replaceAll("\n","<br>")%></td>
						</tr>
					
						

					</tbody> 
					</table>
					<a href="board.jsp" class="btn btn-primary">목록</a>
					<%
						if(userID != null && userID.equals(board.getUserID()))	{
							
					%>
						<a href="update.jsp?boardIDX=<%= boardIDX %>" class="btn btn-primary">수정</a>
						<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?boardIDX=<%= boardIDX %>" class="btn btn-primary">삭제</a>
					<%
						}
					%>
		</div>
	</div>



</body>
</html>