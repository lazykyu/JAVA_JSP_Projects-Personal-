
<%@page import="user.UserDAO" %>
<%@page import="user.UserBean" %>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%
	request.setCharacterEncoding("UTF-8");

	String userEMAIL = request.getParameter("userEMAIL");
	String userPWD = request.getParameter("userPWD");
	String userNAME = request.getParameter("userNAME");
	String userPOSTCODE = request.getParameter("userPOSTCODE");
	String userADDRESS = request.getParameter("userADDRESS");
	String userCPNUM = request.getParameter("userCPNUM");

	
	UserBean userbean = new UserBean();
	

	userbean.setUserEMAIL(userEMAIL);
	userbean.setUserPWD(userPWD);
	userbean.setUserNAME(userNAME);
	userbean.setUserPOSTCODE(userPOSTCODE);
	userbean.setUserADDRESS(userADDRESS);
	userbean.setUserCPNUM(userCPNUM);


	
	UserDAO userdao = new UserDAO();
	userdao.insertUser(userbean);
	response.sendRedirect("login.jsp");
	
%>