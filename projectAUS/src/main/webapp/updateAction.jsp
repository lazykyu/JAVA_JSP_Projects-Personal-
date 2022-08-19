<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="hboard.hBoardDAO" %>
<%@ page import="hboard.hBoardBean " %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>


  
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	
	<%
		String userID = null;
		if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");	
		}
		if (userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.')");
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
		}else {
			if(request.getParameter("boardTitle") == null || request.getParameter("boardContent") == null || 
					request.getParameter("boardTitle").equals("")  || request.getParameter("boardContent").equals("")) {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('입력되지 않은 부분이 있습니다.')");
						script.println("history.back()");
						script.println("</script>");
					}else {
						hBoardDAO boardDAO = new hBoardDAO();
						int result = boardDAO.update(boardIDX, request.getParameter("boardTitle"),request.getParameter("boardContent"));
						if (result == -1 ){
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("alert('글 수정이 실패 했습니다.')");
							script.println("history.back()");
							script.println("</script>");
							
				}
				else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'board.jsp'");
				script.println("</script>");
			}
				
			}
		
		
	
			
		}
	%>
	
</body>
</html>