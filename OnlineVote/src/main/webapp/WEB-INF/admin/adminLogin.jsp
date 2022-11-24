<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>admin login</title>
	</head>
	<body>
		<form action="/OnlineVote/admin/adminLogin.do">
			<table border="1">
				<tr>
					<td>id</td>
					<td><input type="text" name="id" placeholder="Enter ID"></td>
				</tr>
				<tr>
					<td>password</td>
					<td><input type="password" name="pass" placeholder="Enter Password"></td>
				</tr>
				<tr>
					<td colspan="2" align="right"><input type="submit" value="Log In"></td>
				</tr>
				<tr>
					<td colspan="2" align="center"><a href="/admin/register.do">Register here</a></td>
				</tr>
			</table>
		</form>
	</body>
</html>