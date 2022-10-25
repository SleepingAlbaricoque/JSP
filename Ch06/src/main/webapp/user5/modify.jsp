<%@page import="config.DBCP"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="bean.User5Bean"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String name = request.getParameter("name");
	
	User5Bean ub = null;
	try{
		Connection conn = DBCP.getDBCP("dbcp_java1db");
		String sql = "SELECT * FROM `user5` WHERE `name`=?";
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, name);
		
		ResultSet rs = psmt.executeQuery();
		
		if(rs.next()){
			ub = new User5Bean();
			ub.setUid(rs.getString(1));
			ub.setName(rs.getString(2));
			ub.setBirth(rs.getString(3));
			ub.setAge(rs.getInt(4));
			ub.setAddress(rs.getString(5));
			ub.setHp(rs.getString(6));
			ub.setGender(rs.getInt(7));
		}
		
		rs.close();
		psmt.close();
		conn.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>user5::modify</title>
	</head>
	<body>
		<a href="../2_DBCPTest.jsp">처음으로</a>
		<a href="./list.jsp">user5 목록</a>
	
		<form action="./modifyProc.jsp" method="post">
			<table border="1">
				<tr>
					<td>아이디</td>
					<td><input type="text" name="uid" value="<%= ub.getUid() %>"></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" name="name" readonly="readonly" value="<%= ub.getName() %>"></td>
				</tr>
				<tr>
					<td>생년월일</td>
					<td><input type="date" name="birth" value=<%= ub.getBirth() %>></td>
				</tr>
				<tr>
					<td>성별</td>
					<td>
						<label></label><input type="radio" name="gender" value="1">남</label>
						<label></label><input type="radio" name="gender" value="2">여</label>
					</td>
				</tr>
				<tr>
					<td>나이</td>
					<td><input type="number" name="age" value=<%= ub.getAge() %>></td>
				</tr>
				<tr>
					<td>주소</td>
					<td><input type="text" name="address" value=<%= ub.getAddress() %>></td>
				</tr>
				<tr>
					<td>휴대폰</td>
					<td><input type="text" name="hp" value=<%= ub.getHp() %>></td>
				</tr>
				<tr>
					<td colspan="2" align="right"><input type="submit" value="수정"></td>
				</tr>
			</table>
		</form>
	</body>
</html>