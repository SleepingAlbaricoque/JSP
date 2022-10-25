<%@page import="config.DBCP"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String bookID = request.getParameter("bookID");
	String bookName = request.getParameter("bookName");
	String publisher = request.getParameter("publisher");
	String price = request.getParameter("price");
	
	try{
		Connection conn = DBCP.getConnection("dbcp_java1_bookstore");
		
		String sql = "update `book` set `bookName`=?, `publisher`=?, `price`=? where `bookID`=?";
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, bookName);
		psmt.setString(2, publisher);
		psmt.setString(3, price);
		psmt.setString(4, bookID);
		psmt.executeUpdate();
		
		psmt.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	
	response.sendRedirect("../list.jsp");
%>