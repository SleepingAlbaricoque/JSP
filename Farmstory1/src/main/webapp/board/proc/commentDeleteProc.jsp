<%@page import="com.google.gson.JsonObject"%>
<%@page import="kr.co.farmstory1.dao.ArticleDAO"%>
<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String no = request.getParameter("no");
	
	ArticleDAO.getInstance().updateCommentCounter(no);
	int result = ArticleDAO.getInstance().deleteComment(no);
	
	JsonObject json = new JsonObject();
	json.addProperty("result", result);
	json.addProperty("no", no);
	out.print(json.toString());
%>