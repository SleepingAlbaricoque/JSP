<%@page import="kr.co.jboard1.dao.ArticleDAO"%>
<%@page import="kr.co.jboard1.db.SQL"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kr.co.jboard1.db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String no = request.getParameter("no");
	String pg = request.getParameter("pg");
	
	ArticleDAO.getInstance().updateArticle(title, content, no);
	
	response.sendRedirect("/JBoard1/view.jsp?no="+no+"&pg="+pg);
%>