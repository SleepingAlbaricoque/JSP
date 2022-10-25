<%@page import="config.DBCP"%>
<%@page import="beans.CustomerBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	List<CustomerBean> customers = new ArrayList<>();
	CustomerBean cb = null;
	
	try{
		Connection conn = DBCP.getConnection("dbcp_java1_bookstore");
		
		String sql = "select * from `customer`";
		PreparedStatement psmt = conn.prepareStatement(sql);
		ResultSet rs = psmt.executeQuery();
		
		while(rs.next()){
			cb = new CustomerBean();
			cb.setCustID(rs.getInt(1));
			cb.setName(rs.getString(2));
			cb.setAddress(rs.getString(3));
			cb.setPhone(rs.getString(4));
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
		<title>고객목록</title>
	</head>
	<body>
		<h3>고객목록</h3>
		
		<a href="../index.jsp">처음으로</a>
		<a href="./register.jsp">고객등록</a>
		
		<table border="1">
			<tr>
				<th>고객번호</th>
				<th>고객명</th>
				<th>주소</th>
				<th>휴대폰</th>
				<th>관리</th>
			</tr>
			<% for(CustomerBean customer : customers) { %>
			<tr>
				<td><%= customer.getCustID() %></td>
				<td><%= customer.getName() %></td>
				<td><%= customer.getAddress() %></td>
				<td><%= customer.getPhone() %></td>
				<td>
					<a href="./modify.jsp?custID=<%= customer.getCustID() %>">수정</a>
					<a href="./delete.jsp?custID=<%= customer.getCustID() %>">삭제</a>
				</td>
			</tr>
			<% } %>
		</table>
	</body>
</html>