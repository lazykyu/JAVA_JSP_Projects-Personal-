<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 세션 아이디값을 가져와서 변수에 저장
String id = (String)session.getAttribute("sId");
%>    
<header>
	<!-- login join -->
	<div id="login">
		<%if(id == null) { %>
	  		<a href="../member/login.jsp">login</a> | <a href="../member/join.jsp">join</a>
	  	<%} else { %>
	  		<%-- id 값을 클릭하면 member_info.jsp 페이지로 이동(파라미터로 id 값 전달) --%>
	  		<%=id %> 님 | <a href="../member/logout.jsp">logout</a>
	  	<%} %>
	</div>
    <div class="clear"></div>
    <!-- 로고들어가는 곳 -->
    <div id="logo"><img src="../images/logo.gif"></div>
    <!-- 메뉴들어가는 곳 -->
    <nav id="top_menu">
    	<ul>
    		<li><a href="../main/main.jsp">HOME</a></li>
  	  	 	<li><a href="../company/welcome.jsp">COMPANY</a></li>
  			<li><a href="../company/welcome.jsp">SOLUTIONS</a></li>
	  		<li><a href="../center/notice.jsp">CUSTOMER CENTER</a></li>
	  		<li><a href="../mail/mailForm.jsp">CONTACT US</a></li>
  		</ul>
    </nav>
</header>