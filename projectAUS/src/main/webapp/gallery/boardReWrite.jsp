<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet"
	href="//unpkg.com/bootstrap@4/dist/css/bootstrap.min.css">
<script src='//unpkg.com/jquery@3/dist/jquery.min.js'></script>
<script src='//unpkg.com/popper.js@1/dist/umd/popper.min.js'></script>
<script src='//unpkg.com/bootstrap@4/dist/js/bootstrap.min.js'></script>

<link rel="stylesheet" href="css/OnlyFor-bottombar.css" />

<%
			String userID = (String)session.getAttribute("userID");
		
			if(userID==null){
				response.sendRedirect("../login.jsp");
			}	
			
			
			int num = Integer.parseInt(request.getParameter("num")); //주글번호
			
			int re_ref = Integer.parseInt(request.getParameter("re_ref"));//주글그룹값
			int re_lev = Integer.parseInt(request.getParameter("re_lev"));//주글 들여쓰기 정도값
			int re_seq = Integer.parseInt(request.getParameter("re_seq"));//주글 순서			
		%>
<body>
	
		
		<article>
			<h1>Gallery ReWriter</h1>
			<form action="galleryReWritePro.jsp" method="post" enctype="multipart/form-data">
				<%--주글에 대한 정보 전달 --%>
				<input type="hidden" name ="num" value="<%=num%>">
				<input type="hidden" name ="re_ref" value="<%=re_ref%>">
				<input type="hidden" name ="re_lev" value="<%=re_lev%>">
				<input type="hidden" name ="re_seq" value="<%=re_seq%>">
				
				
				<table id="notice">
					<tr>
						<td>Id</td>
						<td><input type="text" name="id" value="<%=id%>"></td>
					</tr>
					<tr>
						<td>PassWord</td>
						<td><input type="password" name="passwd"></td>
					</tr>
					<tr>
						<td>Subject</td>
						<td><input type="text" name="subject" value="[Comment]"></td>
					</tr>
					<tr>
						<td>Image Upload</td>
						<td><input type="file" name="image"></td>
					</tr>
					<tr>
						<td>Content</td>
						<td><textarea rows="13" cols="40" name="content"></textarea></td>
					</tr>				
				</table>
				<div id="table_search">
					<input type="submit" value="Submit" class="btn">
					<input type="reset" value="Reset" class="btn">
					<input type="button" value="List" class="btn"
						   onclick="location.href = 'galleryNotice.jsp'">
				</div>			
			</form>
			<div class="clear"></div>		
		</article>
		<div class="clear"></div>
		


</body>
</html>