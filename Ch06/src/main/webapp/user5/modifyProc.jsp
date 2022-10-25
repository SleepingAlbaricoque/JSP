<%@page import="config.DBCP"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String uid = request.getParameter("uid");
	String name = request.getParameter("name");
	String birth = request.getParameter("birth");
	String gender = request.getParameter("gender");
	String age = request.getParameter("age");
	String address = request.getParameter("address");
	String hp = request.getParameter("hp");
	
	try{
		Connection conn = DBCP.getDBCP("dbcp_java1db");
		
		String sql = "update `user5` set `uid`=?, `birth`=?, `gender`=?, `age`=?, `address`=?, `hp`=?";
			   sql += "where `name`=?";
		
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, uid);
		psmt.setString(2, birth);
		psmt.setString(3, gender);
		psmt.setString(4, age);
		psmt.setString(5, address);
		psmt.setString(6, hp);
		psmt.setString(7, name);
		psmt.executeQuery();
		
		psmt.close();
		conn.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
	response.sendRedirect("./list.jsp");
%>