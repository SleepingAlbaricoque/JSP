<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>login page</title>
	</head>
	<body>
		<form action="/OnlineVote/login.do" method="post">
			<table border="1">
				<tr>
					<td>id</td>
					<td><input type="text" name="id" placeholder="Enter ID"></td>
				</tr>
				<tr>
					<td>password</td>
					<td><input type="password" name="password" placeholder="Enter Password"></td>
				</tr>
				<tr>
					<td colspan="2" align="right"><input type="submit" value="Log In"></td>
				</tr>
				<tr>
					<td colspan="2" align="right"><label><input type="checkbox" name="auto">Remember Me</label></td>
				</tr>
				<tr>
					<td colspan="2" align="center"><a href="/OnlineVote/voter/register.do">Register here</a></td>
				</tr>
			</table>
		</form>
		<span>Click <a href="/OnlineVote/admin/adminLogin.do">here</a> if you're an administrator</span>
	</body>
</html>