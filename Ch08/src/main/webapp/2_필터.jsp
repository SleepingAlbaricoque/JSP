<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>2_필터</title>
		<!-- 
			날짜 : 2022.11.09
			이름 : 조수빈
			내용 : 서블릿 필터 실습하기
			필터 서블릿들 만들어 반복 작업 자동화; 요청 가능한 자원(Ch08에서는 JSP와 servlet 패키지 서블릿들) 실행 전 실행 w/ doFilter() method
			역시 web.xml에서 등록 필요; annotation으로 해도 되지만 xml 설정하는 게 나음 <- 필터들 실행 순서 정할 수 있음
				필터 순서 바꾸려면 web.xml에서 등록 위치를 바꾸면 됨 e.g. FirstFilter를 SecondFilter 밑으로 배치하면 Second > First 순으로 실행
			Greeting 서블릿 실행하는 a태그 실행 시 Greeting init > FirstFilter doFilter > SecondFilter doFilter > Greeting doGet 순으로 실행됨(콘솔 기록 보기)
		 -->
	</head>
	<body>
		<h3>필터 실습</h3>
		
		
	</body>
</html>