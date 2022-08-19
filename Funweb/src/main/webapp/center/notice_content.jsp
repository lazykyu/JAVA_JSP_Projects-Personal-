<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
// idx, pageNum 가져오기
int idx = Integer.parseInt(request.getParameter("idx"));
// String pageNum = request.getParameter("pageNum");

// if(pageNum == null) {
// 	pageNum = "1";
// }

BoardDAO dao = new BoardDAO();

// BoardDAO 객체의 updateReadcount() 메서드를 호출하여 게시물 조회수 증가
// => 파라미터 : 글번호(idx), 리턴타입 : void
// => readcount = readcount + 1
dao.updateReadcount(idx);

// BoardDAO 객체의 selectBoard() 메서드를 호출하여 게시물 1개 정보 조회
// => 파라미터 : 글번호(idx), 리턴타입 : BoardDTO(board)
BoardDTO board = dao.selectBoard(idx);
// -------------------------------------------------------------------------------
// 주의! 현재 페이지의 자바 코드에서 생성한 변수를
// EL 또는 JSTL 태그에서 사용하려면 pageContext 객체 등의 영역 객체의 
// setAttribute() 메서드를 호출하여 저장한 후 저장된 속성명을 통해 접근 가능하다!
pageContext.setAttribute("board", board); // 현재 페이지에서만 유효한 pageContext 객체에 저장
// => EL 또는 JSTL 등에서 속성명 "board" 를 지정하여 사용 가능해진다!
// -------------------------------------------------------------------------------
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/notice_content.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top.jsp" />
		<!-- 헤더 들어가는곳 -->

		<!-- 본문들어가는 곳 -->
		<!-- 본문 메인 이미지 -->
		<div id="sub_img_center"></div>
		<!-- 왼쪽 메뉴 -->
		<nav id="sub_menu">
			<ul>
				<li><a href="./notice.jsp">Notice</a></li>
				<li><a href="#">Public News</a></li>
				<li><a href="./driver.jsp">Driver Download</a></li>
				<li><a href="#">Service Policy</a></li>
			</ul>
		</nav>
		<!-- 본문 내용 -->

		<article>
			<h1>Notice Content</h1>
			<table id="notice">
				<tr>
					<td>글번호</td>
<%-- 					<td><%=board.getIdx() %></td> --%>
					<%-- EL 을 사용하여 BoardDTO 객체(board)의 멤버변수 idx 에 접근 시 --%>
					<%-- 1) Getter 를 호출하는 코드를 지정 --%>
<%-- 					<td>${board.getIdx() }</td> --%>
					<%-- 2) 내부적으로 Getter 를 호출하지만 변수명을 지정(*) --%>
					<td>${board.idx }</td>
					<td>글쓴이</td>
					<td>${board.name }</td>
				</tr>
				<tr>
					<td>작성일</td>
					<td>${board.date }</td>
					<td>조회수</td>
					<td>${board.readcount }</td>
				</tr>
				<tr>
					<td>제목</td>
					<td colspan="3">${board.subject }</td>
				</tr>
				<tr>
					<td>내용</td>
					<td colspan="3">${board.content }</td>
				</tr>
			</table>
			<div id="table_search">
				<input type="button" value="글수정" class="btn" onclick="location.href='notice_update.jsp?idx=<%=idx%>&pageNum=${param.pageNum}'"> 
				<input type="button" value="글삭제" class="btn" onclick="location.href='notice_delete.jsp?idx=<%=idx%>&pageNum=${param.pageNum}'"> 
				<input type="button" value="글목록" class="btn" onclick="location.href='notice.jsp?pageNum=${param.pageNum}'">
			</div>

			<div class="clear"></div>
		</article>

		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>


