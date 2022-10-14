<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>customer::register</title>
	</head>
	<body>
		<h3>customer registration</h3>
		
		<a href = "./list.jsp">customer list</a>
		
		<form action="./registerProc.jsp" method="post">
			<table border="1">
				<tr>
					<td>ID</td>
					<td><input type="text" name="custId" placeholder="insert ID"></td>
				</tr>
				<tr>
					<td>Name</td>
					<td><input type="text" name="name" placeholder="insert name"></td>
				</tr>
				<tr>
					<td>Contact</td>
					<td><input type="text" name="hp" placeholder="insert phone #"></td>
				</tr>
				<tr>
					<td>Address</td>
					<td><input type="text" name="addr" placeholder="insert address"></td>
				</tr>
				<tr>
					<td>Reg. Date</td>
					<td><input type="text" name="rdate" placeholder="insert registration date"></td>
				</tr>
				<tr>
					<td colspan="2" align="right"></td>
					<td><input type="submit" value="submit"></td>
				</tr>
			</table>
		</form>
	</body>
</html>