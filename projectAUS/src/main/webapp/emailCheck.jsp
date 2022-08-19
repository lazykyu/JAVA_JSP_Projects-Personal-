<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript">
		
		
		function UseEmail(){
			
			// 아이디 유효성 검사 및 ajax로 중복확인 처리
			
				
				var userEMAIL = $("#userEMAIL").val();
												
				$.ajax({
					
					type: "get",
					dataType: "text",
					async: false,
					url: "/projectAUS/user?userEMAIL=" + userEMAIL,
					success: function(data, textStatus) {		
						
							if(data == "usable"){	// 사용할 수 있는 ID
								alert(userEMAIL+"는 사용 가능한 이메일입니다.");
								opener.document.fr.id.value = document.fr.id.value;
								window.close();
								
							}else{					// DB에 존재하는 ID
								$("#check_result").text("이미 사용하고 있는 이메일입니다.");
								
								/* $("#Id_Use").prop("disabled",true);		 */						
							}
						
					},
					error: function(error) {
						alert("통신실패!");
					}
					
				});				
			}
		
	
	</script>

</head>
<body>
	<%
		String  userEMAIL =request.getParameter("userEMAIL");
		
	%>
	<form action="emailCheck.jsp" method="post" name="fr">
		ID : <input type="text" id="id" name="id" value="<%=userEMAIL%>">
		<input type="button" value="Use This EMAIL" onclick="UseEmail();" id="Email_Use"/>
		<div id="check_result"></div>
	</form>

</body>
</html>