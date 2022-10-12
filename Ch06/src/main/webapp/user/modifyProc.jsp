<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8");
	String uid = request.getParameter("uid");
	String name = request.getParameter("name");
	String hp = request.getParameter("hp");
	String age = request.getParameter("age");
	
	String host = "jdbc:mysql://127.0.0.1:3306/java1db";
	String user = "root";
	String pass = "1234";
	
	try{
	// 2단계
	Connection conn = DriverManager.getConnection(host, user, pass);
	// 3단계
	String sql = "UPDATE `user3` SET `name` =?, `hp`=?, `age`=?";
		   sql += "WHERE `uid`=?";
	PreparedStatement psmt = conn.prepareStatement(sql);
	psmt.setString(1, name);
	psmt.setString(2, hp);
	psmt.setString(3, age);
	psmt.setString(4, uid);
	// 4단계
	psmt.executeUpdate();
	// 5단계
	
	// 6단계
	psmt.close();
	conn.close();
	
	} catch(Exception e){
		e.printStackTrace();
	}
	response.sendRedirect("./list.jsp");
%>
