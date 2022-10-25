<%@page import="config.DBCP"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String custID = request.getParameter("custID");
	String name = request.getParameter("name");
	String address = request.getParameter("address");
	String phone = request.getParameter("phone");
	
	try{
		Connection conn = DBCP.getConnection("dbcp_java1_bookstore");
		
		String sql = "update `customer` set `name`=?, `address`=?, `phone`=? where `custID`=?";
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, name);
		psmt.setString(2, address);
		psmt.setString(3, phone);
		psmt.setString(4, custID);
		psmt.executeUpdate();
		
		psmt.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	
	response.sendRedirect("../list.jsp");
%>