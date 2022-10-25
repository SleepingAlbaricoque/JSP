<%@page import="config.DBCP"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String bookID = request.getParameter("bookID");
	
	try{
		Connection conn = DBCP.getConnection("dbcp_java1_bookstore");
		
		String sql = "delete from `book` where `bookID`=?";
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, bookID);
		psmt.executeUpdate();
		
		psmt.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	
	response.sendRedirect("./list.jsp");
%>