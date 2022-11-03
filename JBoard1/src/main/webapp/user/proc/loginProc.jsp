<%@page import="kr.co.jboard1.dao.UserDAO"%>
<%@page import="kr.co.jboard1.db.SQL"%>
<%@page import="kr.co.jboard1.bean.UserBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kr.co.jboard1.db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 데이터 액세스 로직
	request.setCharacterEncoding("UTF-8");
	String uid = request.getParameter("uid");
	String pass = request.getParameter("pass");
	
	UserBean ub = UserDAO.getInstance().selectUser(uid, pass);
	
	// 유저 데이터 DB에 있는지 없는지 판독
	if(ub != null){
		// 회원이 맞을 경우
		session.setAttribute("sessUser", ub); // 현재 세션에 지금 ub 정보 저장
		response.sendRedirect("/JBoard1/list.jsp");
	}else{
		// 회원이 아닌 경우
		
		response.sendRedirect("/JBoard1/user/login.jsp?success=100");
	}
%>