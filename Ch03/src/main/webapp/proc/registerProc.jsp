<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 전송 파라미터 인코딩 설정
	request.setCharacterEncoding("UTF-8"); // post 방식으로 전송하면 데이터가 인코딩되므로 이후 어떤 언어로 디코딩할지 지정해주는 메서드

	// 전송 파라미터 수신; 데이터 타입 상관없이 무조건 문자열로 수신
	String name = request.getParameter("name");
	String birth = request.getParameter("birth");
	String gender = request.getParameter("gender");
	String[] hobbies = request.getParameterValues("hobby"); // hobby 여러 개 선택 가능이라 배열로 받아 옴
	String addr = request.getParameter("addr");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원가입 처리</title>
	</head>
	<body>
		<h3>회원가입 처리</h3>
		<p>
			이름: <%= name %><br/>
			생년월일: <%= birth %><br/>
			주소: <%= addr %><br/>
			성별: 
			<% 
				if(gender.equals("1"))
					out.print("남자");
				else
					out.print("여자");
			%>
			<br/>
			취미: <%= String.join(", ", hobbies) %><br/>
			<!-- 
				취미 alternative
				for(String hobby : hobbies)
					out.print(hobby + " ");
			 -->
		</p>
		
		<a href="../1_request.jsp">뒤로가기</a>
	</body>
</html>