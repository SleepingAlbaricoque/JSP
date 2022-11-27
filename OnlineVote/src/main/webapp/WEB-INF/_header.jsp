<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<body>
		<header>
			<p>
				You are logged in as <span>${sessUser.name}</span>
				<a href="/OnlineVote/logout.do?id=${sessUser.id}">[Log Out]</a>
			</p>
		</header>
	</body>
</html>