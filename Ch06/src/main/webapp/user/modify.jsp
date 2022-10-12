<%@page import="bean.UserBean"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String uid = request.getParameter("uid"); // uid만 list.jsp에서 받아와서 이걸 가지고 DB에서 uid에 해당하는 전체 정보 불러와야 함
											  // uid는 해당 테이블의 primary key 이므로 두 개 이상의 결과값이 나올 수 없음
	
	//데이터베이스 처리
	String host = "jdbc:mysql://127.0.0.1:3306/java1db";
	String user = "root";
	String pass = "1234";
	
	UserBean ub = null; // 여기서 initialize하는 것보다 일단 null로 놔두고 try문 안에서 초기화하기 <- 이후 null 체크 할 때 유용하게 쓰임
	
	try{
	// 1단계 생략
	// 2단계
	Connection conn = DriverManager.getConnection(host, user, pass);
	// 3단계
	Statement stmt = conn.createStatement();
	// 4단계
	ResultSet rs = stmt.executeQuery("SELECT * FROM `user3` WHERE `uid`='"+uid+"'");
	// 5단계
	if(rs.next()){
		ub = new UserBean();
		ub.setUid(rs.getString(1));
		ub.setName(rs.getString(2));
		ub.setHp(rs.getString(3));
		ub.setAge(rs.getInt(4));
	}
	// 6단계
	rs.close();
	stmt.close();
	conn.close();
	
	} catch(Exception e){
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>user::register</title>
	</head>
	<body>
		<h3>user 수정하기</h3>
		
		<a href="./list.jsp">user 목록</a>
		
		<form action="./modifyProc.jsp" method="post">
			<table border="1">
				<tr>
					<td>아이디</td>
					<td><input type="text" name="uid" value="<%= ub.getUid() %>" readonly/></td> <!-- 데이터베이스에서 기존 정보 불러온 것임 -->
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" name="name" value="<%= ub.getName() %>"/></td>
				</tr>
				<tr>
					<td>휴대폰</td>
					<td><input type="text" name="hp" value="<%= ub.getHp() %>"/></td>
				</tr>
				<tr>
					<td>나이</td>
					<td><input type="number" name="age" value="<%= ub.getAge() %>"/></td>
				</tr>
				<tr>
					<td colspan="2" align="right"></td>
					<td><input type="submit" value="등록하기"/></td>
				</tr>
			</table>
		</form>
		
	</body>
</html>