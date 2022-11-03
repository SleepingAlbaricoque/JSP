<%@page import="java.io.File"%>
<%@page import="kr.co.jboard1.bean.ArticleBean"%>
<%@page import="kr.co.jboard1.dao.ArticleDAO"%>
<%@page import="kr.co.jboard1.db.SQL"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kr.co.jboard1.db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String no =request.getParameter("no");
	String pg = request.getParameter("pg");
	
	ArticleDAO dao = ArticleDAO.getInstance();
	
	// 파일 정보 삭제 from DB
	String fileName = dao.deleteFile(no);
	
	// 파일 삭제 from 디렉터리
	if(fileName != null){
		String path = application.getRealPath("/file");
		File file = new File(path, fileName);
		
		if(file.exists()){
			file.delete();
		}
	}
	
	// 글 + 댓글 삭제
	dao.deleteArticle(no);
	
	
	
	response.sendRedirect("/JBoard1/list.jsp?pg="+pg);
%>