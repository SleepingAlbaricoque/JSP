<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="bean.MemberBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<% 
	String host = "jdbc:mysql://127.0.0.1:3306/java1db";
	String user = "root";
	String pass = "1234";
	
	MemberBean mb = null;
	List<MemberBean> users = new ArrayList<>();
	
	try{
	Class.forName("com.mysql.cj.jdbc.Driver");	
		
	Connection conn = DriverManager.getConnection(host, user, pass);
	
	Statement stmt = conn.createStatement();
	
	String sql = "SELECT * FROM `member`";
	ResultSet rs = stmt.executeQuery(sql);
	
	while(rs.next()){
		mb = new MemberBean();
		mb.setUid(rs.getString(1));
		mb.setName(rs.getString(2));
		mb.setHp(rs.getString(3));
		mb.setPos(rs.getString(4));
		mb.setDep(rs.getString(5));
		mb.setrDate(rs.getString(6));
		users.add(mb);
	}
	
	rs.close();
	stmt.close();
	conn.close();
	
	} catch(Exception e){
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>member::list</title>
	</head>
	<body>
		<h3>member 목록</h3>
		<a href="./register.jsp">member 등록하기</a>
		
		<table border="1">
			<tr>
				<th>아이디</th>
				<th>이름</th>
				<th>휴대폰</th>
				<th>직급</th>
				<th>부서번호</th>
				<th>입사일</th>
				<th>관리</th>
			</tr>
			<% for(MemberBean ub : users){ %>
			<tr>
				<td><%= ub.getUid() %></td>
				<td><%=	ub.getName() %></td>
				<td><%= ub.getHp() %></td>
				<td><%= ub.getPos() %></td>
				<td><%= ub.getDep() %></td>
				<td><%= ub.getrDate() %></td>
				<td>
					<a href="./modify.jsp?uid=<%= ub.getUid() %>">수정</a>
					<a href="./delete.jsp?uid=<%= ub.getUid() %>">삭제</a>
				</td>
			</tr>
			<% } %>
		</table>
	</body>
</html>