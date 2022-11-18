<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>bookstore::modify</title>
	</head>
	<body>
		<h3>도서수정</h3>
		
		<a href="../index.jsp">처음으로</a>
		<a href="/Bookstore2/book/list.do">도서목록</a>
		<form action="/Bookstore2/book/modify.do" method="post">
			<table border="1">
				<tr>
					<td>도서번호</td>
					<td><input type="text" name="bookID" value="${book.bookID}" readonly></td>
				</tr>
				<tr>
					<td>도서명</td>
					<td><input type="text" name="bookName" value="${book.bookName}"></td>
				</tr>
				<tr>
					<td>출판사</td>
					<td><input type="text" name="publisher" value="${book.publisher}"></td>
				</tr>
				<tr>
					<td>가격</td>
					<td><input type="text" name="price" value="${book.price}"></td>
				</tr>
				<tr>
					<td colspan="2" align="right"></td>
					<td><input type="submit" value="수정"></td>
				</tr>
			</table>	
		</form>
	</body>
</html>