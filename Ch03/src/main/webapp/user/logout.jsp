<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<% 
	// 세션 종료
	session.invalidate(); // 여기서 session은 각 브라우저의 세션; invalidate는 무효화한다는 뜻
	response.sendRedirect("../6_session.jsp");
%>