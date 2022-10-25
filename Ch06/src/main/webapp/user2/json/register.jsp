<%@page import="config.DB"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String uid = request.getParameter("uid");
	String name = request.getParameter("name");
	String hp = request.getParameter("hp");
	String age = request.getParameter("age");
	
	int result =0;
	
	try{
		Connection conn = DB.getInstance().getConnection();
		
		String sql = "insert into `user2` values (?,?,?,?)";
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, uid);
		psmt.setString(2, name);
		psmt.setString(3, hp);
		psmt.setString(4, age);
		
		result = psmt.executeUpdate(); // executeUpdate 메서드는 int값을 반환
		psmt.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	
	// user submit 할 때 데이터 전송에 있어 클라이언트와 서버는 서로 json을 주고 받음; 밑에서 정의한 json은 클라이언트가 돌려받는 json객체
	Gson gson = new Gson();
	JsonObject json = new JsonObject();
	json.addProperty("result", result);
	
	String jsonData = json.toString();
	
	out.print(jsonData);
%>