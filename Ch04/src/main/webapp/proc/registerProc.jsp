<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>registerProc</title>
		<!-- 
			html 코드 내부에 스크립트릿이 너무 많으면 유지보수가 힘듦 -> 대신 액션태그로 표현하기
			BUT jsp 자체에서 태그 문법을 사용하지 않는 추세; 새로운 태그 업데이트도 안되고 있어서 그냥 bean이 있다는 것만 알고 넘어가기
		 -->
	</head>
	<body>
		<h3>useBean 액션태그</h3>
		
		<%	
			request.setCharacterEncoding("UTF-8");
			// 전송 데이터 수신
			/* 
			request.setCharacterEncoding("UTF-8");
			String 	 name    = request.getParameter("name");
			String 	 birth   = request.getParameter("birth");
			String 	 addr    = request.getParameter("addr");
			String 	 gender  = request.getParameter("gender");
			String[] hobbies = request.getParameterValues("hobby");
			*/
		%>
		
		<jsp:useBean id="ub" class="bean.UserBean">
			<jsp:setProperty property="name" name="ub"/> <!-- name의 setter 호출; 폼에서 사용자가 입력한 name을 u2b 객체에 대입 -->
			<jsp:setProperty property="birth" name="ub"/> 
			<jsp:setProperty property="addr" name="ub"/> 
			<jsp:setProperty property="gender" name="ub"/>
			<jsp:setProperty property="hobbies" name="ub"/>
		</jsp:useBean>
		
		<p>
			이름: <%= ub.getName() %><br/>
			생년월일: <%= ub.getBirth() %><br/>
			주소: <%= ub.getAddr() %><br/>
			성별: <%= ub.getGender() == 1 ? "남자": "여자" %><br/>
			취미: <%= String.join(", ", ub.getHobbies()) %><br/>
		</p>
		
		<a href="../3_useBean 태그.jsp">뒤로가기</a>
	</body>
</html>