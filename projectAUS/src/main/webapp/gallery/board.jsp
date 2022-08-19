<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
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

<link rel="stylesheet"
	href="//unpkg.com/bootstrap@4/dist/css/bootstrap.min.css">
<script src='//unpkg.com/jquery@3/dist/jquery.min.js'></script>
<script src='//unpkg.com/popper.js@1/dist/umd/popper.min.js'></script>
<script src='//unpkg.com/bootstrap@4/dist/js/bootstrap.min.js'></script>

<link rel="stylesheet" href="css/OnlyFor-bottombar.css" />


<title>Insert title here</title>

</head>
<body>
	


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



		
		<%
		 
			BoardDAO boardDAO = new BoardDAO();
			
		 	int count = boardDAO.getBoardCount();
		 	
		 	int pageSize = 5; //한 페이지당 보여줄 글 개수 5
		 	String pageNum = request.getParameter("pageNum");
			
		 	if(pageNum == null){
		 		pageNum ="1";
		 	}
		 	int currentPage = Integer.parseInt(pageNum);
		 	int startRow = (currentPage - 1) * pageSize;
		 	
		 	List<BoardBean> list = null;
		 	
			if(count > 0){
				
				list = boardDAO.getBoardList(startRow,pageSize);
			}
		
		
		%>
	
	<article>
			<h1>언론 뉴스 발췌</h1>
			<table id="notice">
				<tr>
					<th class="tno">No.</th>					
					<th class="ttitle">Title</th>
					<th class="twrite">Writer</th>
					<th class="tdate">Date</th>
					<th class="tread">Read</th>
				</tr>

      
      <%
			if(count > 0){
				for(int i=0;i<list.size();i++){
					BoardBean bean = list.get(i); 
		%>
		<tr onclick="location.href ='boardContent.jsp?num=<%=bean.getNum()%>&pageNum=<%=pageNum%>'">
			<td><%=bean.getNum() %></td>			
			<td class="left">
    	<%
					int wid = 0; //답변글에 대한 들여쓰기 값 저장 
					
					if(bean.getRe_lev() > 0){ //답변글에 대한 들여쓰기 값이 0보다 크다면?
						wid = bean.getRe_lev() * 10;					
		%>
			<img src="../images/center/level.gif" width="<%=wid%>" height ="15">
					<img src="../images/center/re.gif">	
		<%
					}
					
					if(bean.getImage()!=null && bean.getImage()!=""){
		%>
		
		<img src="../image/sm_<%=bean.getImage() %>">
		<%
					}
		%>
		<%=bean.getSubject() %>
		</td>
			<td><%=bean.getId() %></td>
			<td><%= new SimpleDateFormat("yyyy/MM/dd").format(bean.getDate())%></td>
			<td><%=bean.getReadcount() %></td>
		</tr> 
		
			<%			
				}
			} else{
		%>
			<tr align="center">
				<td colspan="5">No List</td>
			</tr>
		<%				
			}		
		%>					
			</table> 
			 
		<%
		String userEMAIL =(String)session.getAttribute("userEMAIL");
		if(userEMAIL != null){
	
	%>
		<div id ="table_search">
					<input type="button" value="Write" class="btn" onclick="location.href='boardwrite.jsp'">
				</div>	
						</div>				
		<%					
			}			
		%>
				<div id="table_search">
					<input type="text" name="search" class="input_box">
					<input type="button" value="Search" class="btn">
				</div>
				<div class="clear"></div>
				<div id="page_control">
		<%
		if(count > 0){
			int pageCount = count/pageSize + (count%pageSize ==0 ? 0 : 1);
			
			//한 화면에 표시될 페이지수 설정
			int pageBlock = 2;
			
			//시작  페이지 번호 구하기
			// 1~10 => 1    11~20 => 11    21~30 = >21
			//((아래쪽에 클릭한 페이지 번호/한 화면에 보여줄 페이지 수) -
			//(아래쪽에 클릭한 페이지 번호를 한 화면에 보여줄 페이지수로 나눈 나머지 값))
			// * 하나의 화면에 보여 줄 페이지 수 + 1
			int startPage = ((currentPage/pageBlock)-(currentPage%pageBlock == 0 ? 1 : 0 )) * pageBlock + 1;
			
			int endPage = startPage + pageBlock - 1;
			
			//끝 페이지 번호가 전체 페이지 수보다 클 때..
			if(endPage > pageCount){
				endPage = pageCount;
			}
			//[이전] 시작페이지번호가 한 화면에 보여줄 페이지 수보다 클 때..
			if(startPage > pageBlock){
				%>
				<a href="board.jsp?pageNum=<%=startPage - pageBlock %>">[Prev]</a>		
		<%						
			}
			// [1] [2]...... 페이지번호 나타내기
			for(int i=startPage;i<=endPage;i++){
		%>
				<a href="board.jsp?pageNum=<%=i%>">[<%=i%>]</a>
		<%		
			}
			//[다음] 끝페이지 번호가 전체페이지 수보다 작을떄..
			if(endPage<pageCount){
				%>
				<a href="board.jsp?pageNum=<%=startPage+pageBlock%>">[Next]</a>
				<%
			}				
		}		
	%>			
			}
	</div>			
		</article>
		<div class="clear"></div>
	
	
</body>
</html>