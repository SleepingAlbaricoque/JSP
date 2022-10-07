<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>500</title>
		<!-- exception 내장 객체 사용하려면 맨 윗 줄에 isErrorPage = "true" 적어야 함 -->
	</head>
	<body>
		<h3>일시적인 시스템 장애가 발생하였습니다. 관리자에게 문의하시기 바랍니다.</h3>
		<p>
			에러타입: <%= exception.getClass().getName()%><br/>
			에러내용: <%= exception.getMessage()%><br/>
		</p>
		<a href="/Ch03/8_Exception.jsp">뒤로가기</a>
	</body>
</html>