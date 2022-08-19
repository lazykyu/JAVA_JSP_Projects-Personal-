<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.io.File"%>
<%@page import="java.awt.Graphics2D"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="javax.media.jai.JAI"%>
<%@page import="javax.media.jai.RenderedOp"%>
<%@page import="java.awt.image.renderable.ParameterBlock"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
<title>Insert title here</title>
</head>
<body>
	
	<%
		request.setCharacterEncoding("UTF-8");
		BoardBean bBean = new BoardBean();
		
		String imagePath = request.getRealPath("/upload");
		int size =10*1024*1024;
		
		String filename ="";
		String originalfilename = "";
		try{
		MultipartRequest multi = new MultipartRequest(
				request,
				imagePath,
				size,
				"UTF-8",
				new DefaultFileRenamePolicy()
				);
		
		Enumeration files = multi.getFileNames();
		
		String file = (String)files.nextElement();
		filename = multi.getFilesystemName(file);
		originalfilename = multi.getOriginalFileName(file);
		
		bBean.setNum(Integer.parseInt(multi.getParameter("num")));
		bBean.setId(multi.getParameter("id"));
		bBean.setPasswd(multi.getParameter("passwd"));
		bBean.setSubject(multi.getParameter("subject"));
		bBean.setImage(filename);
		bBean.setContent(multi.getParameter("content"));
		bBean.setRe_ref(Integer.parseInt(multi.getParameter("re_ref")));
		bBean.setRe_lev(Integer.parseInt(multi.getParameter("re_lev")));
		bBean.setRe_seq(Integer.parseInt(multi.getParameter("re_seq")));
		
		} catch(Exception e){
			System.out.println("galleryWriter.jsp파일의  MultipartRequest에서 오류발생: "+e);
		}
		// 답글을 작성한 사람의 IP주소를 저장
		bBean.setIp(request.getRemoteAddr());
		
		if(filename != null){
			ParameterBlock pb = new ParameterBlock();
			pb.add(imagePath +"/"+filename);
			RenderedOp rOp=JAI.create("fileload", pb);
			
			BufferedImage bi = rOp.getAsBufferedImage();
			BufferedImage thumb = new BufferedImage(50,50,BufferedImage.TYPE_INT_RGB);
			Graphics2D g = thumb.createGraphics();
			g.drawImage(bi, 0, 0,50, 50, null);
			File file = new File(imagePath+"/sm_"+filename);
			ImageIO.write(thumb, "jpg",file);
		}
		BoardDAO bdao = new BoardDAO();
		int check=bdao.reInsertBoard(bBean);
		
		if(check == 1){		
	%>
			<script type="text/javascript">
				window.alert("입력 성공");
				location.href = board.jsp;	 		
			</script>	
	<%
		}else {
	%>			
		<script type="text/javascript">
			alert("비밀번호 틀림");
			history.back();
		</script>  	
	<%
		}
	%>

</body>
</html>