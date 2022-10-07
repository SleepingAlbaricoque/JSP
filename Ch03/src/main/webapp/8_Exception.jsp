<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>8_Exception</title>
		<!-- 
			날짜 : 2022.10.07
			이름 : 조수빈
			내용 : JSP Exception 내장객체 실습하기
			
			web.xml 내용 수정하면 설정 수정한 것이나 마찬가지므로 서버 다시 restart해야 함
			
			exception 내장 객체
			 - JSP 페이지에서 예외가 발생했을 때 생성되는 내장객체
			 - 직접적으로 exception 처리를 하지 않고 에러코드에 따라 에러페이지 작업
			
			주요 응답상태 코드
			 - 200: 요청을 정상적으로 처리
			 - 307: redirect 응답코드
			 - 401: 접근을 허용하지 않음
			 - 404: 요청한 페이지를 찾을 수 없음
			 - 500: 서버 내부 에러 발생
			 - 503: 서버가 일시적으로 서비스를 할 수 없음 <- 서버 꺼져 있음, 서버에 트래픽 몰림 등 이유
		 -->
	</head>
	<body>
		<h3>exception 객체</h3>
		<h4>Custom Error Pages</h4>
		
		<a href="./9_text.jsp">404 에러 페이지</a>
		<a href="./proc/exception.jsp">5xx 에러 페이지</a>
	</body>
</html>