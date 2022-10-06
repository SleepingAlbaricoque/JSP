<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 해당 페이지를 파일 다운로드로 응답; 해당 페이지가 파일로 다운로드 됨
	response.setHeader("Content-Type", "application/octet-stream"); // 컨텐츠 타입이 기존의 html이 아니라 파일 전송을 위한 타입으로 바뀜
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>response 페이지</title>
	</head>
	<body>
		<h3>response 페이지</h3>
		<a href="../2_response.jsp">뒤로가기</a>
	</body>
</html>