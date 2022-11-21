<%@page import="java.io.File"%>
<%@page import="kr.co.farmstory1.dao.ArticleDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String group = request.getParameter("group");
	String cate = request.getParameter("cate");	
	String no = request.getParameter("no");
	String pg = request.getParameter("pg");
	
	String fileName = ArticleDAO.getInstance().deleteFile(no);
	
	if(fileName != null){
		String path = application.getRealPath("/file");
		File file = new File(path, fileName);
		
		if(file.exists()){
			file.delete();
		}
	}
	
	ArticleDAO.getInstance().deleteArticle(no);
	
	response.sendRedirect("/Farmstory1/board/list.jsp?group="+group+"&cate="+cate+"&no="+no+"&pg="+pg);
%>