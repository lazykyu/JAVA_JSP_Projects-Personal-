<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width",initial-scale="1">
	<link rel="stylesheet" href="//unpkg.com/bootstrap@4/dist/css/bootstrap.min.css">
<script src='//unpkg.com/jquery@3/dist/jquery.min.js'></script>
<script src='//unpkg.com/popper.js@1/dist/umd/popper.min.js'></script>
<script src='//unpkg.com/bootstrap@4/dist/js/bootstrap.min.js'></script>
	
<link rel="stylesheet" href="css/OnlyFor-bottombar.css" />

		<script type="text/javascript">
		function joinUs() {
			if(document.fr.userEMAIL.value == ""){
				alert("이메일을 입력해주세요.");
				document.fr.userEMAIL.focus();
				return;
			}			
			var fed = document.fr.userEMAIL.value;
			window.open("join_Email_Check.jsp?userEMAIL="+fid,"","width=300,height=50");			
		}		
	
	</script>
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-Latest.js"></script>
	
<title>Insert title here</title>

<script>
		var userEMAIL_Check= false;
		var passwd_Check = false;
						
		
		function checkPass() {
			if($("#pass").val() != "") {
				if($("#passwd").val() != $("#passwd2").val()) {
					$("#passCheck").css("color", "red");
					$("#passCheck").text("비밀번호가 다릅니다.");
					pass_Check = false;
				} else {
					$("#passCheck").css("color", "green");
					$("#passCheck").text("비밀번호가 동일합니다.");
					pass_Check = true;
				}
			} else {
				$("#passCheck").html("&nbsp;");
			}
		}
		
	 	function postCode() {
	 		new daum.Postcode({
	 			oncomplete:function(data) { 				
	 				$('[name=userPOSTCODE]').val(data.zonecode);
	 				$('[name=userADDRESS]').val(data.address);
	 			}
	 		}).open();
	 	}
	</script>

</head>
<body>
  <nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="main.jsp">RFFA</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

<div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
    	<li class="nav-item active">
        <a class="nav-link" href="notice.jsp">우리 단체는 <span class="sr-only">(current)</span></a>
      </li>
     <li class="nav-item active">
        <a class="nav-link" href="board.jsp">현지 소식 <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item active">
        <a class="nav-link" href="donate.jsp">후원 하기 <span class="sr-only">(current)</span></a>
      </li>
    </ul>
    <form class="form-inline my-2 my-lg-0">
      <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
    </form>
  </div>
</nav>
	
	<h1 class="text-center" style="padding-top: 40px;">JOINJ US</h1>
<div class="container pt-3">
  <div class="row justify-content-sm-center">
    <div class="col-sm-6 col-md-4">
		 <div class="card border-info text-center">
        <div class="card-header">
          Join us
        </div>
       <div class="card-body">
        <form class="form-signin" method="post" action="joinAction.jsp">
            <input type="email"  class="form-control mb-2" placeholder="Email" required name="userEMAIL" maxlength="30" id="userEMAIL" class="userEMAIL">
            <input type="button" value="EMAIL Check" class="dup" onclick="joinUs()"><br>
          	<br>
            <input type="password" class="form-control mb-2" placeholder="Password" required name="userPWD" maxlength="15">
            <br>
             <input type="text" class="form-control mb-2" placeholder="Name" required name="userNAME" maxlength="20">
            <br>
             <input type="text" class="form-control mb-2" placeholder="Zip Code" id ="postcode" required name="userPOSTCODE" maxlength="10">
             <input type="button" onclick="postCode()" class="dup" value="Find ZipCode"><br>
            <br>
             <input type="text" class="form-control mb-2" placeholder="Address" required name="userADDRESS" maxlength="100">
            <br>
             <input type="tel" class="form-control mb-2" placeholder="C.P" required name="userCPNUM" maxlength="14" >
            <br>
            
            
            <button class="btn btn-lg btn-primary btn-block mb-1" type="submit">DONE</button>
            <button class="btn btn-lg btn-primary btn-block mb-1" type="reset">CANCEL</button>
          
            
            <a href="noticeformayouhito.jsp" class="float-right">Need help?</a>
          </form>
        </div>
      </div>
 
    </div>
  </div>
</div>
		
		<div class="bottombar">
  		<a href="login.jsp">Login</a>
 		<a href="contact.jsp">Contact us</a>
</div>
		
</body>
</html>