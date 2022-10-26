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
	
	int parent = 0;
	
	try{
		Connection conn = DBCP.getConnection(); // connection은 정보 객체(객체는 곧 정보 덩어리) -> 이를 바탕으로 쿼리문 객체 생성
		conn.setAutoCommit(false);
		
		Statement stmt = conn.createStatement();
		PreparedStatement psmt = conn.prepareStatement(SQL.INSERT_ARTICLE);
		
		psmt.setString(1, title);
		psmt.setString(2, content);
		psmt.setInt(3, fname == null? 0 : 1);
		psmt.setString(4, uid);
		psmt.setString(5, regip);
		
		psmt.executeUpdate(); // INSERT
		ResultSet rs =stmt.executeQuery(SQL.SELECT_MAX_NO);
		
		conn.commit(); // 위에서 auto commit을 막고 여기서 psmt, stmt 한 번에 동시에 실행 => 내가 올리는 동안 다른 사용자가 글 올려서 max no가 다른 사용자 글 번호가 되는 상황 방지
		
		if(rs.next()){
			parent = rs.getInt(1);
		}
		
		rs.close();
		stmt.close();
		psmt.close();
		conn.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
	// 첨부한 파일 처리
	if(fname != null){
		
		// 파일명 수정
		int idx = fname.lastIndexOf("."); // 확장자 바로 앞의 점을 찾는 것
		String ext = fname.substring(idx); // 파일명 중 확장자만 잘라낸 것
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss_");
		String now = sdf.format(new Date());
		String newFname = now + uid + ext; // ex. 20221026111425_tnqls0421.txt
		
		File oriFile = new File(savePath + "/" + fname); // 스트림; 업로드 된 파일(oriFile)을 파일 객체화
		File newFile = new File(savePath + "/" + newFname);
		
		oriFile.renameTo(newFile);
		
		// 파일 테이블에 파일 정보 저장
		try{
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(SQL.INSERT_FILE);
			psmt.setInt(1, parent);
			psmt.setString(2, newFname);
			psmt.setString(3, fname);
			psmt.executeUpdate();
			
			psmt.close();
			conn.close();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	response.sendRedirect("/JBoard1/list.jsp");
%>