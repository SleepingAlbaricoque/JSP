<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="beans.OrderBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="config.SQL"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="config.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	OrderBean ob = null;
	List<OrderBean> orders = new ArrayList<>();

	try{
		Connection conn = DBCP.getConnection();
		PreparedStatement psmt = conn.prepareStatement(SQL.SELECT_ORDERS);
		ResultSet rs = psmt.executeQuery();
		
		while(rs.next()){
			ob = new OrderBean();
			ob.setOrderNo(rs.getInt(1));
			ob.setCustomer(rs.getString(4));
			ob.setProduct(rs.getString(5));
			ob.setOrderCount(rs.getInt(2));
			ob.setOrderDate(rs.getString(3));
			orders.add(ob);
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
		<title>Shop::order</title>
	</head>
	<body>
		<h3>주문목록</h3>
		
		<a href="./customer.jsp">고객목록</a>
		<a href="./product.jsp">상품목록</a>
		
		<table border="1">
			<tr>
				<th>주문번호</th>
				<th>주문자</th>
				<th>주문상품</th>
				<th>주문수량</th>
				<th>주문일</th>
			</tr>
			<% for(OrderBean order : orders){ %>
			<tr>
				<td><%= order.getOrderNo() %></td>
				<td><%= order.getCustomer() %></td>
				<td><%= order.getProduct() %></td>
				<td><%= order.getOrderCount() %></td>
				<td><%= order.getOrderDate() %></td>
			</tr>
			<% } %>
		</table>
	</body>
</html>