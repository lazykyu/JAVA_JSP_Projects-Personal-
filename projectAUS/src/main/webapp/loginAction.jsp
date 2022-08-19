<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>


	<%	
	request.setCharacterEncoding("UTF-8");
	String userEMAIL = request.getParameter("userEMAIL");
	String userPWD = request.getParameter("userPWD");
	
	UserDAO userdao= new UserDAO();
	
	int check = userdao.userCheck(userEMAIL, userPWD);
	
	if(check == 1){
		session.setAttribute("userEMAIL", userEMAIL);
		response.sendRedirect("main.jsp");		
	}else if(check == 0){ //아이디 같고 비밀번호 틀림
		%>
		<script>
			alert("비밀번호가 맞지 않습니다!");
			history.go(-1);
		</script>;
		<%		
	} else{ //check =-1   아이디가 없음
		
		%>
		<script>
			alert("아이디가 존재하지 않습니다!");
			history.back();
		
		</script>
		
		<%
	}
	
	%>
	
