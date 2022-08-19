<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<link rel="stylesheet"
	href="//unpkg.com/bootstrap@4/dist/css/bootstrap.min.css">
<script src='//unpkg.com/jquery@3/dist/jquery.min.js'></script>
<script src='//unpkg.com/popper.js@1/dist/umd/popper.min.js'></script>
<script src='//unpkg.com/bootstrap@4/dist/js/bootstrap.min.js'></script>
</head>
<%
	String userEMAIL = (String)session.getAttribute("userEMAIL");
	
	if(userEMAIL == null){
		response.sendRedirect("../login.jsp");
	}
	
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
%>	
<body>

	<article>
		<form action="galleryDeletePro.jsp?pageNum=<%=pageNum%>" method="post">
			<input type="hidden" name="num" value="<%=num%>">
			<table>
				<tr>
					<td>PassWord</td>
					<td><input type="password" name="passwd"></td>
				</tr>
			</table>
			<div id="table_search">
				<input type="submit" value="Delete" class="btn">
				<input type="reset" value="Reset" class="btn">
				<input type="button" value="List" class="btn"
					onclick="location.href='galleryNotice.jsp?pageNum=<%=pageNum%>'">
			</div>			
		</form>
		<div class="clear"></div>	
	</article>		
	<div class="clear"></div>

</body>
</html>