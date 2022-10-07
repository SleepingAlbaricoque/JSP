<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>2_include 액션태그</title>
		<!-- 
			날짜 : 2022.10.07
			이름 : 조수빈
			내용 : JSP include 액션태그 실습하기
			
			include 태그
			 - 일반적으로 UI 모듈, 공통 전역 파일을 삽입할 때 사용하는 지시자
			 - 동적타임에 삽입(include 지시자는 정적타임에 삽입)
		 -->
	</head>
	<body>
		<h3>include 액션태그</h3>
		
		<h4>include 지시자</h4> <!-- 정적 타임에 삽입 -->
		<%@ include file="/inc/_header.jsp" %>
		<%@ include file="/inc/_footer.jsp" %>
		<%@ include file="/inc/_config.jsp" %> <!-- config.jsp 파일 삽입된 상태가 아니면 밑의 print 메서드에 config.jsp에 선언된 전역변수 사용 불가 -->
		<%
			out.print("num1: " + num1 + "<br/>");
			out.print("num2: " + num2 + "<br/>");
			out.print("num3: " + num3 + "<br/>");
		%>
		
		<h4>include 액션태그</h4> <!-- 동적 타임에 삽입; 이 페이지를 요청할 때 삽입 시작 -->
		<jsp:include page="./inc/_header.jsp"></jsp:include>
		<jsp:include page="./inc/_footer.jsp"></jsp:include>
		<jsp:include page="./inc/_config2.jsp"></jsp:include>
		<%
			// out.print("var1: " + var1 + "<br/>"); config2.jsp 전역 변수 여기서 사용 불가 <- config2.jsp 파일은 runtime 때 삽입되기 때문에 지금(정적타임)은 사용할 수 없음
		%>
		
		<h4>include 함수</h4> <!-- 프로그램 코드이므로 동적 타임에 삽입 -->
		<%
			pageContext.include("./inc/_header.jsp");
			pageContext.include("./inc/_footer.jsp");
		%>
	</body>
</html>