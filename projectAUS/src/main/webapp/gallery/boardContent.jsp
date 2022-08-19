<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardBean" %>
<%@page import="board.BoardDAO" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="//unpkg.com/bootstrap@4/dist/css/bootstrap.min.css">
<script src='//unpkg.com/jquery@3/dist/jquery.min.js'></script>
<script src='//unpkg.com/popper.js@1/dist/umd/popper.min.js'></script>
<script src='//unpkg.com/bootstrap@4/dist/js/bootstrap.min.js'></script>

<link rel="stylesheet" href="css/OnlyFor-bottombar.css" />

</head>
<%
	request.setCharacterEncoding("UTF-8");

	//notice.jsp페이지에서 글목록 중 하나를 클릭했을 때.. 요청받아 넘어온 num,pageNum 얻기
	int num =Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	BoardDAO dao = new BoardDAO();
	
	//조회수를 1 증가시키는 메소드 호출
	dao.updateReadCount(num);
	
	//DB로부터 하나의 글 정보를 검색해서 얻기
	String DBContent ="";
	BoardBean boardBean = dao.getBoard(num);
		
	if(boardBean.getContent() != null){
		DBContent = boardBean.getContent().replace("\r\n", "<br>");
	}
	
	//DB로부터 하나의 글 정보를 검색해서 가져온 BoardBean객체의 getter메소드를 호출하여 리턴 받기
%>
<body>
	
		<article>
			<h1>Gallery Content</h1>
			<table id="notice">
				<tr>
					<td>Number</td>
					<td><%=boardBean.getNum()%></td>
					<td>Read Count</td>
					<td><%=boardBean.getReadcount() %></td>
				</tr>
				<tr>
					<td>Writer</td>
					<td><%=boardBean.getId() %></td>
					<td>Date</td>
					<td><%=new SimpleDateFormat("yyyy.MM.dd").format(boardBean.getDate()) %></td>
				</tr>
				<tr>
					<td>Subject</td>
					<td colspan="3"><%=boardBean.getSubject() %></td>
				</tr>
				<tr>
					<td>Content</td> 
					<td colspan="3" >	
					<%
						if(boardBean.getImage()!=null && boardBean.getImage()!=""){
					%>				
							<img alt="" src="../upload/<%=boardBean.getImage()%>" style="width: 360px;height:270pxs;">
							<a href="galleryDownload.jsp?file_name=<%=boardBean.getImage()%>"><input type="button" value="Image Download" class="btn"></a><br>
					<%
						}
					%>
					<%=DBContent %></td> 
				</tr>				
			</table>
			
			<div id="table_search">
			<%
				String userEMAIL = (String)session.getAttribute("userEMAIL");
				
				if(userEMAIL != null ){
					if(userEMAIL.equals(boardBean.getId())){
			%>			
						<input type="button" value="Modify" class="btn"				
						onclick="location.href ='galleryUpdate.jsp?num=<%=boardBean.getNum()%>&pageNum=<%=pageNum%>'">
						
						<input type="button" value="Delete" class="btn"				
						onclick="location.href ='galleryDelete.jsp?num=<%=boardBean.getNum()%>&pageNum=<%=pageNum%>'">
			<%		} %>	
				<input type="button" value="Comment" class="btn"	
				onclick="location.href ='galleryReWrite.jsp?num=<%=boardBean.getNum()%>&re_ref=<%=boardBean.getRe_ref()%>&re_lev=<%=boardBean.getRe_lev()%>&re_seq=<%=boardBean.getRe_seq()%>'">
			<%
				}			
			%>
			<input type="button" value="List" class="btn"				
			onclick="location.href ='galleryNotice.jsp?pageNum=<%=pageNum%>'">
			</div>
			<div id="page_control"></div>			
		</article>
		
		<div class="clear"></div>


</body>
</html>