<%@page import="config.DBCP"%>
<%@page import="beans.BookBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<% 
	List<BookBean> books = new ArrayList<>();
	BookBean bb = null;

	try{
		Connection conn = DBCP.getConnection("dbcp_java1_bookstore");
		
		String sql = "select * from `book`";
		PreparedStatement psmt = conn.prepareStatement(sql);
		ResultSet rs = psmt.executeQuery();
		
		while(rs.next()){
			bb = new BookBean();
			bb.setBookID(rs.getInt(1));
			bb.setBookName(rs.getString(2));
			bb.setPublisher(rs.getString(3));
			bb.setPrice(rs.getInt(4));
			books.add(bb);
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
		<title>Insert title here</title>
	</head>
	<body>
		<h3>도서목록</h3>
		
		<a href="/Bookstore/index.jsp">처음으로</a>
		<a href="./register.jsp">도서등록</a>
		
		<table border="1">
			<tr>
				<th>도서번호</th>
				<th>도서명</th>
				<th>출판사</th>
				<th>가격</th>
				<th>관리</th>
			</tr>
			<% for(BookBean book : books) {%>
			<tr>
				<td><%= book.getBookID() %></td>
				<td><%= book.getBookName() %></td>
				<td><%= book.getPublisher() %></td>
				<td><%= book.getPrice() %></td>	
				<td>
					<a href="./modify.jsp?bookID=<%= book.getBookID() %>">수정</a>
					<a href="./delete.jsp?bookID=<%= book.getBookID() %>">삭제</a>
				</td>			
			</tr>
			<% } %>
		</table>
	</body>
</html>