<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ page import="java.io.PrintWriter" %>
	<%@ page import="hboard.hBoardBean" %>
	<%@ page import="hboard.hBoardDAO" %>
	
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
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 해주세요')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
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
		hBoardBean board = new hBoardDAO().getBoard(boardIDX);
		if(!userID.equals(board.getUserID())) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('수정 권한이 없습니다.')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
	}
			
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
				<li class="active"><a href="board.jsp">현상황</a>
				</li>
			</ul>	
		</div>
	</nav>
	<h1 style="text-align: center;">언론 기사 발췌</h1>
	<div class="container">
		<div class="row">
			<form method="post" action="updateAction.jsp?boardIDX=<%= boardIDX %>">
				<table class="table table-striped"
					style="text-align: center; border: 1px solid #dddddd; padding-top: 150px;">
					<thead>
					<tr>
						<th colspan="2" style="background-color: #eeeeee;  text-align: center;">수정 하기</th>
					</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control" placeholder="글 제목" name="boardTitle" maxlength="40" value="<%= board.getBoardTitle()%>"></td>
						</tr>
						<tr>
							<td><textarea class="form-control" placeholder="글 내용" name="boardContent" maxlength="6072" style="height: 400px;"><%= board.getBoardContent() %></textarea></td>
						</tr>

					</tbody>
					</table>
					<input type="submit" class="btn btn-primary pull-right" value="글수정">
			</form>


		</div>
	</div>



</body>
</html>