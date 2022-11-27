<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Admin::Register</title>
	</head>
	<body>
		<header></header>
		<main>
			<section class="register">
				<form action="/OnlineVote/admin/adminRegister.do" method="post">
					<table border="1">
						<tr>
							<td>Name</td>
							<td><input type="text" name="name" placeholder="Enter Name"></td>
						</tr>
						<tr>
							<td>Mobile Number</td>
							<td><input type="text" name="hp" placeholder="Enter Mobile Number"></td>
						</tr>
						<tr>
							<td>ID</td>
							<td><input type="text" name="id" placeholder="Enter ID"></td>
						</tr>
						<tr>
							<td>Password</td>
							<td><input type="text" name="password" placeholder="Enter Password"></td>
						</tr>
					</table>
					<input type="submit" value="register">
				</form>
			</section>
		</main>
		<footer></footer>
	</body>
</html>