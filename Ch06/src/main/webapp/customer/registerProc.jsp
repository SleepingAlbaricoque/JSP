<%@page import="config.DBCP"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String custId = request.getParameter("custId");
	String name = request.getParameter("name");
	String hp = request.getParameter("hp");
	String addr = request.getParameter("addr");
	String rdate = request.getParameter("rdate");
	
	try{
		Connection conn = DBCP.getDBCP("dbcp_java1_shop");
		
		String sql = "insert into `customer` values (?,?,?,?,?)";
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, custId);
		psmt.setString(2, name);
		psmt.setString(3, hp);
		psmt.setString(4, addr);
		psmt.setString(5, rdate);
		psmt.executeUpdate();
		
		psmt.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	
	response.sendRedirect("./list.jsp");
%>