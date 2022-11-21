<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="kr.co.farmstory1.dao.ArticleDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String savePath = application.getRealPath("/file");
	int maxSize = 1024 * 1024 * 10;
	MultipartRequest mr = new MultipartRequest(request, savePath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
	
	String no = mr.getParameter("no");
	String pg = mr.getParameter("pg");
	String group = mr.getParameter("group");
	String cate = mr.getParameter("cate");
	String file = mr.getFilesystemName("file");
	String title = mr.getParameter("title");
	String content = mr.getParameter("content");
	String uid = mr.getParameter("uid");
	
	if(file != null){
		// 파일명 수정
		int idx = file.lastIndexOf("."); // 확장자 바로 앞의 점을 찾는 것
		String ext = file.substring(idx); // 파일명 중 확장자만 잘라낸 것
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss_");
		String now = sdf.format(new Date());
		String newName = now + uid + ext; // ex. 20221026111425_tnqls0421.txt
		
		File oriFile = new File(savePath + "/" + file); // 스트림; 업로드 된 파일(oriFile)을 파일 객체화
		File newFile = new File(savePath + "/" + newName);
		
		oriFile.renameTo(newFile);
		
		// 파일 테이블에 파일 정보 저장
		ArticleDAO.getInstance().updateFile(no, newName, file);
		ArticleDAO.getInstance().updateArticle(title, content, no);
		ArticleDAO.getInstance().updateArticleFile(no);

	}else{
		ArticleDAO.getInstance().updateArticle(title, content, no);
	}
	
	response.sendRedirect("/Farmstory1/board/view.jsp?no="+no+"&pg="+pg+"&cate="+cate+"&group="+group);
%>