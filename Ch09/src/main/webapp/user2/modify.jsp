<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>user::register</title>
	</head>
	<body>
		<h3>user 수정하기</h3>
		
		<a href="/Ch09/user2/list.do">user 목록</a>
		
		<form action="/Ch09/user2/modify.do" method="post">
			<table border="1">
				<tr>
					<td>아이디</td>
					<td><input type="text" name="uid" value="${requestScope.vo.uid}" readonly/></td> <!-- 데이터베이스에서 기존 정보 불러온 것임 -->
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" name="name" value="${vo.name}"/></td>
				</tr>
				<tr>
					<td>휴대폰</td>
					<td><input type="text" name="hp" value="${vo.hp}"/></td>
				</tr>
				<tr>
					<td>나이</td>
					<td><input type="number" name="age" value="${vo.age}"/></td>
				</tr>
				<tr>
					<td colspan="2" align="right"></td>
					<td><input type="submit" value="등록하기"/></td>
				</tr>
			</table>
		</form>
		
	</body>
</html>