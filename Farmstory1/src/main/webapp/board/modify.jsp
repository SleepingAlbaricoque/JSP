<%@page import="kr.co.farmstory1.dao.ArticleDAO"%>
<%@page import="kr.co.farmstory1.beans.ArticleBean"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_header.jsp" %>
<%
	if(sessUser == null){
		response.sendRedirect("/Farmstory1/user/login.jsp?success=101");
		return;
	}

	String group = request.getParameter("group");
	String cate = request.getParameter("cate");	
	String no = request.getParameter("no");
	String pg = request.getParameter("pg");
	
	ArticleBean article = ArticleDAO.getInstance().selectArticle(no);
	
	pageContext.include("./_" + group+ ".jsp");
%>
	        <main id="board" class="modify">
	            <form action="/Farmstory1/board/proc/modifyProc.jsp" method="post" enctype="multipart/form-data">
	                <table border="0">
	                    <caption>글수정</caption>
	                    <tr>
	                    	<td><input type="hidden" name="no" value="<%= no %>"></td>
	                    	<td><input type="hidden" name="pg" value="<%= pg %>"></td>
	                    	<td><input type="hidden" name="cate" value="<%= cate %>"></td>
	                    	<td><input type="hidden" name="group" value="<%= group %>"></td>
	                    	<td><input type="hidden" name="uid" value=<%= sessUser.getUid() %>></td>
	                    </tr>
	                    <tr>
	                        <th>제목</th>
	                        <td><input type="text" name="title" value="<%= article.getTitle() %>"></td>
	                    </tr>
	                    <tr>
	                        <th>내용</th>
	                        <td><textarea name="content"><%= article.getContent() %></textarea></td>
	                    </tr>
	                    <tr>
	                        <th>파일</th>
	                        <td><input type="file" name="file"><%= article.getFile() %></td>
	                    </tr>
	                </table>
	
	                <div>
	                    <a href="./view.jsp?group=<%= group %>&cate=<%= cate %>&pg=<%= pg %>&no=<%= no %>" class="btn btnCancel">취소</a>
	                    <input type="submit" value="수정완료" class="btn btnComplete">
	                </div>
	            </form>
	        </main>
        </article>
    </section>
</div>
<%@ include file="../_footer.jsp" %>