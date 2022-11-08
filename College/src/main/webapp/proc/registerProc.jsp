<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.college.beans.RegisterBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="kr.co.college.db.SQL"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kr.co.college.db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	// select student
	String name = request.getParameter("name");
	
	RegisterBean rg = null;
	List<RegisterBean> scoreBoard = new ArrayList<>();
	
	try{
		Connection conn = DBCP.getConnection();
		PreparedStatement psmt = conn.prepareStatement(SQL.SELECT_INFO);
		psmt.setString(1, name);
		ResultSet rs = psmt.executeQuery();
		
		while(rs.next()){
			rg = new RegisterBean();
			rg.setRegStdNo(rs.getString(1));
			rg.setRegLecNo(rs.getInt(2));
			rg.setRegMidScore(rs.getInt(3));
			rg.setRegFinalScore(rs.getInt(4));
			rg.setRegTotalScore(rs.getInt(5));
			rg.setRegGrade(rs.getString(6));
			rg.setLecName(rs.getString(7));
			rg.setStdName(rs.getString(8));
			scoreBoard.add(rg);
		}
		
		rs.close();
		psmt.close();
		conn.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
	Gson gson = new Gson();
	String jsonData = gson.toJson(scoreBoard);
	out.print(jsonData);
	
	
	/* JsonObject json = new JsonObject();
	json.addProperty("regStdNo", rg.getRegStdNo());
	json.addProperty("regStdName", rg.getStdName());
	json.addProperty("regLecName", rg.getLecName());
	json.addProperty("regLecNo", rg.getRegLecNo());
	json.addProperty("regMidScore", rg.getRegMidScore());
	json.addProperty("regFinalScore", rg.getRegFinalScore());
	json.addProperty("regTotalScore", rg.getRegTotalScore());
	json.addProperty("regRegGrade", rg.getRegGrade());
	
	String jsonData = json.toString();
	out.print(jsonData);
	*/
%>