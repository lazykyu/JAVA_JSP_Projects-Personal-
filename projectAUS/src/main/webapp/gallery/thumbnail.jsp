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
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	ServletContext context = request.getServletContext();
	String imagePath =  context.getRealPath("/image");
	int size = 1*1024*1024;
	String filename ="";
	
	try{
		MultipartRequest multi = new MultipartRequest(
				request,
				imagePath,
				size,
				"UTF-8",
				new DefaultFileRenamePolicy());
		
		Enumeration files = multi.getFileNames();
		String file = (String)files.nextElement();
		filename = multi.getFilesystemName(file);
	}catch(Exception e){
		System.out.println("MultipartRequest부분에서 에러 발생: " +e);
	}
	
	ParameterBlock pb = new ParameterBlock();
	pb.add(imagePath +"/"+filename);
	RenderedOp rOp=JAI.create("fileload", pb);
	
	BufferedImage bi = rOp.getAsBufferedImage();
	BufferedImage thumb = new BufferedImage(100,100,BufferedImage.TYPE_INT_RGB);
	Graphics2D g = thumb.createGraphics();
	g.drawImage(bi, 0, 0,100, 100, null);
	File file = new File(imagePath+"/sm_"+filename);
	ImageIO.write(thumb, "jpg",file);
	
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	-원본 이미지-<br>
	<img src="../image/<%=filename%>"><p>
	-썸네일 이미지-<%=imagePath%>/sm_<%=filename%><br>
	<img src="../image/sm_<%=filename%>"><br>
	imagePath:<%=imagePath %> <br>
	
	
</body>
</html>