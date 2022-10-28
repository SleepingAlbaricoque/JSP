<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="beans.CustomerBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="config.SQL"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="config.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	CustomerBean cb = null;
	List<CustomerBean> customers = new ArrayList<>();

	try{
		Connection conn = DBCP.getConnection();
		PreparedStatement psmt = conn.prepareStatement(SQL.SELECT_CUSTOMERS);
		ResultSet rs = psmt.executeQuery();
		
		while(rs.next()){
			cb = new CustomerBean();
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
		
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Shop::customer</title>
	</head>
	<body>
		<h3>고객목록</h3>
		
		<a href="./order.jsp">주문목록</a>
		<a href="./product.jsp">상품목록</a>
		
		<table border="1">
			<tr>
				<th>아이디</th>
				<th>이름</th>
				<th>휴대폰</th>
				<th>주소</th>
				<th>가입일</th>
			</tr>
			<% for(CustomerBean customer : customers){ %>
			<tr>
				<td><%= customer.getCustId() %></td>
				<td><%= customer.getName() %></td>
				<td><%= customer.getHp() %></td>
				<td><%= customer.getAddr() %></td>
				<td><%= customer.getRdate() %></td>
			</tr>
			<% } %>
		</table>
	</body>
</html>