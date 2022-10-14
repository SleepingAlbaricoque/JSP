<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8");
	String uid = request.getParameter("uid");
	String name = request.getParameter("name");
	String birth = request.getParameter("birth");
	String gender = request.getParameter("gender");
	String age = request.getParameter("age");
	String address = request.getParameter("address");
	String hp = request.getParameter("hp");
	
	// 데이터베이스 작업 - 일일히 서버를 거쳐 데이터베이스에 접속하는 것이 아니라 WAS인 Tomcat의 기능을 이용해 데이터풀 생성해 필요시 데이터풀에서 하나씩 꺼내서 쓰기
	//				 => Servers 폴더 context.xml 가서 커넥션 풀 설정 해주어야 함
	try{
		// 1단계 - JNDI 서비스 객체 생성
		Context initCtx = new InitialContext();
		Context ctx = (Context) initCtx.lookup("java:comp/env");
		
		// 2단계 - 커넥션 풀 얻기
		DataSource ds = (DataSource) ctx.lookup("dbcp_java1db");
		Connection conn = ds.getConnection();
		
		// 3단계
		String sql = "INSERT INTO `user5` VALUES (?,?,?,?,?,?,?)";
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1,uid);
		psmt.setString(2,name);
		psmt.setString(3,birth);
		psmt.setString(4,age);
		psmt.setString(5,address);
		psmt.setString(6,hp);
		psmt.setString(7,gender);
		
		
		// 4단계
		psmt.executeUpdate();
		
		// 5단계
		// 6단계
		psmt.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	
	response.sendRedirect("./list.jsp");
%>