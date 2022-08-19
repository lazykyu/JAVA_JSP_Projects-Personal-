<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	<script type="text/javascript">
		function result() {
			opener.document.fr.id.value = document.nfr.userEMAIL.value;
			window.close();
		}
	
	</script>

</head>
<body>
	<%
		String  userEMAIL =request.getParameter("userEAMIL");
		UserDAO userdao = new UserDAO();
		
		int check = userdao.userEMAILCheck(userEMAIL); 
		
		if(check == 1){
			out.println("사용 중인 이메일입니다");
			
		}else{
			out.println("사용 가능한 이메일입니다");
	%>
		<input type="button" value="사용함" onclick="result()" />
	
	<%		
		}



	%>
	<form action="join_Email_Check.jsp" method="post" name="nfr">
		ID : <input type="text" name="userEMAIL" value="<%=userEMAIL%>">
		<input type="submit" value="EMAIL Check">	
	</form>

</body>
</html>