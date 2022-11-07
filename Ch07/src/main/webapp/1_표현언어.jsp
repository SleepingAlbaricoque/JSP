<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>1_표현언어</title>
		<!-- 
			날짜 : 2022.11.07
			이름 : 조수빈
			내용 : JSP 표현언어(Expression Language) 실습하기
		 -->
	</head>
	<body>
		<h3>1.표현언어</h3>
		<%
			String name = "홍길동";
			int num1 = 1;
			int num2 = 2;
			
			pageContext.setAttribute("name", name);
			request.setAttribute("num1", num1);
			session.setAttribute("num2", num2);			
		%>
		
		<h4>표현식</h4>
		<!-- 모델1에서 쓰는 문법이라 모델2에서는 볼 일 없음; scriptlet도 마찬가지 -->
		<p>
			name : <%= name %><br/>
			num1 : <%= num1 %><br/>
			num2 : <%= num2 %><br/>
		</p>
		
		<h4>표현언어</h4>
		<!-- 스크립트릿의 변수 직접 참조 불가 -> jsp 내장객체로 값 설정해주어야 함 -> 이후 중괄호에 변수 넣을 수 있음-->
		<!-- page, request, session, application 어느 스코프든 변수 값 저장만 되면 어디서든 사용 가능 -->
		<p>
			name : ${name}<br/> 
			num1 : ${num1}<br/> 
			num2 : ${num2}<br/> 
			num3 : ${num1+num2}<br/> 
		</p>
	</body>
</html>