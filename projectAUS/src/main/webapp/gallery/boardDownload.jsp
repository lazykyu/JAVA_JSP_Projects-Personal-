<%@page import="javax.print.attribute.standard.Severity"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.FileInputStream"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
	
		String savePath ="image";
		String fileName = request.getParameter("file_name");
		System.out.println("fileName: "+fileName);
		String sDownloadPath = getServletContext().getRealPath(savePath);
		System.out.println("sDownloadPath: "+sDownloadPath);
		String sFilePath = sDownloadPath+"\\"+fileName;
		System.out.println("sFilePath: "+sFilePath);
		byte[] b = new byte[4096];
		FileInputStream in = new FileInputStream(sFilePath);
		String sMimeType = getServletContext().getMimeType(sFilePath);
		System.out.println("sMimeType>>>"+sMimeType);
		
		if(sMimeType == null)
			sMimeType="application/octet-stream";
				
		response.setContentType(sMimeType);
		String agent = request.getHeader("User-Agent");
		System.out.println("agent: "+agent);
		boolean ieBrowser =(agent.indexOf("MSIE")>-1) || (agent.indexOf("Trident") > -1);
		
		//인터넷 익스프롤러의 경우 공백부분이 '+'문자로 변경되므로 '+'문자를 다시 공백문자(""%20")로 변경해 준다
		if(ieBrowser){			
			fileName = URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+", "%20");			
		}else{
			fileName = new String(fileName.getBytes("UTF-8"),"iso-8859-1");
		}
		
		response.setHeader("Content-Disposition", "attachment;filename="+fileName);
		
		ServletOutputStream out2 = response.getOutputStream();
		int numRead;
		
		while((numRead=in.read(b,0,b.length))!=-1){
			out2.write(b,0,numRead);
		}
		out2.flush();
		out2.close();
		in.close();
	
	%>

</body>
</html>