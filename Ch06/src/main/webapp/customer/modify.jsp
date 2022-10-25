<%@page import="config.DBCP"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="bean.CustomerBean"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String custId = request.getParameter("custId");
	
	CustomerBean cb = null;
	
	try{
		Connection conn = DBCP.getDBCP("dbcp_java1db_shop");
		
		String sql = "select * from `customer` where custId =?";
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, custId);
		ResultSet rs = psmt.executeQuery();
		
		if(rs.next()){
			cb = new CustomerBean();
			cb.setCustId(rs.getString(1));
			cb.setName(rs.getString(2));
			cb.setHp(rs.getString(3));
			cb.setAddr(rs.getString(4));
			cb.setRdate(rs.getString(5));
		}
		
		rs.close();
		psmt.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>customer::modify</title>
	</head>
	<body>
		<h3>Edit Customer</h3>
		
		<a href = "./list.jsp">customer list</a>
		
		<form action="./modifyProc.jsp" method="post">
			<table border="1">
				<tr>
					<td>ID</td>
					<td><input type="text" name="custId" readonly value="<%= cb.getCustId() %>"></td>
				</tr>
				<tr>
					<td>Name</td>
					<td><input type="text" name="name" value="<%= cb.getName() %>"></td>
				</tr>
				<tr>
					<td>Contact</td>
					<td><input type="text" name="hp" value="<%=  cb.getHp() %>"></td>
				</tr>
				<tr>
					<td>Address</td>
					<td><input type="text" name="addr" value="<%= cb.getAddr() %>"></td>
				</tr>
				<tr>
					<td>Reg. Date</td>
					<td><input type="text" name="rdate" value="<%= cb.getRdate() %>"></td>
				</tr>
				<tr>
					<td colspan="2" align="right"></td>
					<td><input type="submit" value="submit"></td>
				</tr>
			</table>
		</form>
	</body>
</html>