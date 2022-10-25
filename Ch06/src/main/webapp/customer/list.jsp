<%@page import="config.DBCP"%>
<%@page import="bean.CustomerBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	
	List<CustomerBean> customers = new ArrayList<>();

	try{
		Connection conn = DBCP.getDBCP("dbcp_java1_shop");
		
		String sql = "SELECT * FROM `customer`";
		PreparedStatement psmt = conn.prepareStatement(sql);
		ResultSet rs = psmt.executeQuery();
		
		while(rs.next()){
			CustomerBean cb = new CustomerBean();
			cb.setCustId(rs.getString(1));
			cb.setName(rs.getString(2));
			cb.setHp(rs.getString(3));
			cb.setAddr(rs.getString(4));
			cb.setRdate(rs.getString(5));
			customers.add(cb);
		}
		
		rs.close();
		psmt.close();
		conn.close();
	} catch(Exception e){
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>customer::list</title>
	</head>
	<body>
		<h3>customer list</h3>
		
		<a href="../2_DBCPTest.jsp">처음으로</a>
		<a href="./register.jsp">customer registration</a>
		
		<table border="1">
			<tr>
				<th>ID</th>
				<th>Name</th>
				<th>Contact</th>
				<th>Address</th>
				<th>Reg. Date</th>
			</tr>
			<% for(CustomerBean cb : customers) { %>
			<tr>
				<td><%= cb.getCustId() %></td>
				<td><%= cb.getName() %></td>
				<td><%= cb.getHp() %></td>
				<td><%= cb.getAddr() %></td>
				<td><%= cb.getRdate() %></td>
				<td>
					<a href="./modify.jsp?custId=<%= cb.getCustId() %>">modify</a>
					<a href="./delete.jsp?custId=<%= cb.getCustId() %>">delete</a>
				</td>
			</tr>
			<%} %>
		</table>
	</body>
</html>