<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>exception</title>
	</head>
	<body>
		<h3>5xx 에러 페이지</h3>
		<%
			int num1 = 1;
			int num2 = 0;
			
			int result = num1 / num2; // 에러 처리 따로 안해서 여기서 에러 남; web.xml에서 커스텀 에러 페이지 설정해서 유저가 5xx 에러 내용 보지 않도록 하기
		%>
		
		<p>
			결과: <%= result %>
		</p>
	</body>
</html>