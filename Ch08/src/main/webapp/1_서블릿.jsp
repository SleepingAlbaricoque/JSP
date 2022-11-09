<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>1_서블릿</title>
		<!-- 
			날짜 : 2022.11.09
			이름 : 조수빈
			내용 : 서블릿 실습하기
			JSP 페이지 생성해서 실행; 브라우저 주소창에 자원(1_서블릿.jsp)가 표시됨; jsp 요청하면 servlet으로 변환됨(=확장자가 .class로 바뀜; 노션 jsp life cycle 참조),
			톰캣 서버가 꺼지면 서블릿도 종료됨(destroy됨)
			WAS가(여기서는 톰캣) 서블릿을 java class 파일로 만들어 실행함
			
			서블릿(Servlet)
			- JSP 이전에 Java 웹 프로그래밍 기술
			- 서블릿은 HTML 처리 및 작성이 불편하기 때문에 JSP 기술로 대체
			- 서블릿은 MVC(모델2)에서 컨트롤러 컴포넌트로 사용
		 -->
	</head>
	<body>
		<h3>서블릿 실습</h3>
		
		<a href="/Ch08/hello.do">Hello 서블릿 요청</a> <!-- 액션 주소; 실행하려면 web.xml가서 서블릿 등록 및 맵핑 해야 함 -->
		<a href="/Ch08/welcome.do">Welcome 서블릿 요청</a> <!-- 클래스 페이지 맨 위에 annotation 달면 xml 설정할 필요 없음 -->
		<a href="/Ch08/greeting">Greeting 서블릿 요청</a>
	</body>
</html>