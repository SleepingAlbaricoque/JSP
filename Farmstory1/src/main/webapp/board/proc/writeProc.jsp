<%@page import="java.io.File"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="kr.co.farmstory1.beans.ArticleBean"%>
<%@page import="kr.co.farmstory1.dao.ArticleDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	// 파일 처리 위한 작업
	String savePath = application.getRealPath("/file");
	int maxSize = 1024 * 1024 * 10;
	MultipartRequest mr = new MultipartRequest(request, savePath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
	
	String group = mr.getParameter("group");
	String cate = mr.getParameter("cate");
	String uid = mr.getParameter("uid");
	String title = mr.getParameter("title");
	String content = mr.getParameter("content");
	String fname = mr.getFilesystemName("fname");
	String regip = request.getRemoteAddr();
	
	ArticleBean ab = new ArticleBean();
	ab.setCate(cate);
	ab.setTitle(title);
	ab.setContent(content);
	ab.setUid(uid);
	ab.setFname(fname);
	ab.setRegip(regip);
	
	int parent = ArticleDAO.getInstance().insertArticle(ab);
	
	if(fname != null){
			
			// 파일명 수정
			int idx = fname.lastIndexOf("."); // 확장자 바로 앞의 점을 찾는 것
			String ext = fname.substring(idx); // 파일명 중 확장자만 잘라낸 것
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss_");
			String now = sdf.format(new Date());
			String newName = now + uid + ext; // ex. 20221026111425_tnqls0421.txt
			
			File oriFile = new File(savePath + "/" + fname); // 스트림; 업로드 된 파일(oriFile)을 파일 객체화
			File newFile = new File(savePath + "/" + newName);
			
			oriFile.renameTo(newFile);
			
			// 파일 테이블에 파일 정보 저장
			ArticleDAO.getInstance().insertFile(parent, newName, fname);
		}
	
	response.sendRedirect("/Farmstory1/board/list.jsp?group="+group+"&cate="+cate);
%>