<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>scopeResult</title>
	</head>
	<body>
		<h3>내장객체 영역 확인</h3>
		<p>
			pageContext 영역: <%= pageContext.getAttribute("name") %><br/> <!-- 현재 포워드되어서 온 페이지는 기존 scopeTest 페이지와 다른 페이지므로 scopeTest 페이지의 pageContext 이름이 출력되지 않고 null이 출력됨  -->
			request 영역: <%= request.getAttribute("name") %><br/>
			session 영역: <%= session.getAttribute("name") %><br/>
			application 영역: <%= application.getAttribute("name") %><br/>
		</p>
		
	</body>
</html>