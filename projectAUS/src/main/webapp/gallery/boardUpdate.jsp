<%@page import="board.BoardBean" %>
<%@page import="board.BoardDAO" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<%
			String id = (String)session.getAttribute("id");	
		
			if(id==null){
				response.sendRedirect("../member/login.jsp");
			}		
			
			int num = Integer.parseInt(request.getParameter("num"));
			String pageNum = request.getParameter("pageNum");
						
			BoardDAO dao = new BoardDAO();
			//DB로부터 하나의 글정보를 검색해서 가져오기
			BoardBean boardBean = dao.getBoard(num);
			String DBContent =""; //검색한 글 내용을 저장할 용도의 변수
			
			// 검색한 글의 내용이 있다면 내용들 엔터키 처리
			if(boardBean.getContent() != null){
				DBContent = boardBean.getContent().replace("<br>", "\r\n");
			}
			
		%>

<body>
	
		
		<article>
			<h1>Gallery Update</h1>
			<form action="galleryUpdatePro.jsp?pageNum=<%=pageNum %>" method="post" name="fr" enctype="multipart/form-data">
				<input type="hidden" name="num" value="<%=num%>">
				<table id="notice">
					<tr>
						<td>Id</td>
						<td><input type="text" name="id" value="<%=boardBean.getId()%>" readonly></td>
					</tr>
					<tr>
						<td>PassWord</td>
						<td><input type="password" name="passwd"></td>
					</tr>
					<tr>
						<td>Subject</td>
						<td><input type="text" name="subject" value="<%=boardBean.getSubject()%>"></td>
					</tr>
					<tr>
						<td>Image Upload</td>
						<td><input type="file" name="image" ></td>
					</tr>
					<tr>
						<td>Content</td>
						<td><textarea rows="13" cols="40" name="content"><%=boardBean.getContent() %></textarea></td>
					</tr>				
				</table>
				<div id="table_search">
					<input type="submit" value="Submit" class="btn">
					<input type="reset" value="Reset" class="btn"
						onclick="reset1()">
					<input type="button" value="List" class="btn"
						onclick="location.href = 'galleryNotice.jsp?pageNum=<%=pageNum%>'">
				</div>			
			</form>
			<div class="clear"></div>		
		</article>
		<div class="clear"></div>
		<div id="page_control"></div>
	
	</div>

</body>
</html>