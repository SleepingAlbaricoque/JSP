<%@page import="beans.BookBean"%>
<%@page import="config.DBCP"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String bookID = request.getParameter("bookID");
	
	BookBean bb = null;
	
	try{
		Connection conn = DBCP.getConnection("dbcp_java1_bookstore");
		
		String sql = "select * from `book` where `bookID`=?";
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, bookID);
		ResultSet rs = psmt.executeQuery();
		
		if(rs.next()){
			bb = new BookBean();
			bb.setBookID(rs.getInt(1));
			bb.setBookName(rs.getString(2));
			bb.setPublisher(rs.getString(3));
			bb.setPrice(rs.getInt(4));
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
		<title>modify</title>
	</head>
	<body>
		<h3>도서수정</h3>
		
		<a href="/Bookstore/index.jsp">처음으로</a>
		<a href="./list.jsp">도서목록</a>
		
		<form action="./proc/modifyProc.jsp" method="post">
			<table border="1">
				<tr>
					<td>도서번호</td>
					<td><input type="text" name="bookID" readonly value="<%= bb.getBookID() %>"></td>
				</tr>
				<tr>
					<td>도서명</td>
					<td><input type="text" name="bookName" value="<%= bb.getBookName() %>"></td>
				</tr>
				<tr>
					<td>출판사</td>
					<td><input type="text" name="publisher" value="<%= bb.getPublisher() %>"></td>
				</tr>
				<tr>
					<td>가격</td>
					<td><input type="text" name="price" value="<%= bb.getPrice() %>"></td>
				</tr>
				<tr>
					<td colspan="2" align="right"></td>
					<td><input type="submit" value="수정"></td>
				</tr>
			</table>
		</form>
	</body>
</html>