<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.BoardDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="board" class="board.BoardBean" scope="page" />
<jsp:setProperty property="boardTitle" name="board" />
<jsp:setProperty property="boardContent" name="board" />

  
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
		} else {
			if(board.getBoardTitle() == null || board.getBoardContent() == null) {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('입력되지 않은 부분이 있습니다.')");
						script.println("history.back()");
						script.println("</script>");
					}else {
						BoardDAO boardDAO = new BoardDAO();
						int result = boardDAO.write(board.getBoardTitle(), userID, board.getBoardContent());
						if (result == -1 ){
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("alert('글작성에 실패 했습니다.')");
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