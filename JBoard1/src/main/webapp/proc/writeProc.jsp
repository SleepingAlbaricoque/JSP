<%@page import="kr.co.jboard1.bean.ArticleBean"%>
<%@page import="kr.co.jboard1.dao.ArticleDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="kr.co.jboard1.db.SQL"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kr.co.jboard1.db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@page import="kr.co.jboard1.bean.UserBean"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8"); // 한글은 암호화해야 전송 가능; 암호화 된 한글 데이터 다시 복호화하기 위한 코드
	
	// multipart 전송 데이터 수신
	String savePath = application.getRealPath("/file"); 
	int maxSize = 1024 * 1024 * 10; // 파일 업로드 10메가까지 허용
	MultipartRequest mr = new MultipartRequest(request, savePath , maxSize , "UTF-8", new DefaultFileRenamePolicy()); // request, 파일 저장경로, 파일 최대 사이즈, 인코딩, defaultfilerenamepolicy
	
	String title = mr.getParameter("title");
	String content = mr.getParameter("content");
	String uid = mr.getParameter("uid");
	String fname = mr.getFilesystemName("fname");
	String regip = request.getRemoteAddr();
	
	// System.out.println("fname: " + fname); system.out이라 콘솔로 출력, 필요없는 코드들은 주석 처리해서 자원 낭비 방지
	// System.out.println("savePath: " + savePath);
	
	ArticleBean article = new ArticleBean();
	article.setTitle(title);
	article.setContent(content);
	article.setUid(uid);
	article.setFname(fname);
	article.setRegip(regip);
	
	ArticleDAO dao = ArticleDAO.getInstance();
	int parent = dao.insertArticle(article);
	
	// 첨부한 파일 처리
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
		dao.insertFile(parent, newName, fname);
	}
	
	response.sendRedirect("/JBoard1/list.jsp");
%>