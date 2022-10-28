<%@page import="com.google.gson.JsonObject"%>
<%@page import="config.SQL"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="config.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String prodNo= request.getParameter("prodNo");
	String count= request.getParameter("count");
	String customer = request.getParameter("customer");
	
	int result = 0;
	
	try{
		Connection conn = DBCP.getConnection();
		PreparedStatement psmt = conn.prepareStatement(SQL.INSERT_ORDER);
		psmt.setString(1, customer);
		psmt.setString(2, prodNo);
		psmt.setString(3, count);
		result = psmt.executeUpdate(); // 수행 성공하면 1, 실패하면 0 
	
		psmt.close();
		conn.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
	JsonObject json = new JsonObject();
	json.addProperty("result", result);
	
	String jsonData = json.toString();
	out.print(jsonData);
%>