<%@page import="kr.co.jboard1.bean.ArticleBean"%>
<%@page import="kr.co.jboard1.dao.ArticleDAO"%>
<%@page import="kr.co.jboard1.db.SQL"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kr.co.jboard1.db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String no = request.getParameter("no");
	String pg = request.getParameter("pg");
	
	ArticleBean article = ArticleDAO.getInstance().selectArticle(no);
%>
<%@ include file="./_header.jsp" %>
        </header>
        <main id="board" class="modify">
            <form action="/JBoard1/proc/modifyProc.jsp" method="post">
                <table border="0">
                    <caption>글수정</caption>
                    <tr>
                    	<td><input type="hidden" name="no" value="<%= no %>"></td>
                    	<td><input type="hidden" name="pg" value="<%= pg %>"></td>
                    </tr>
                    <tr>
                        <th>제목</th>
                        <td><input type="text" name="title" placeholder="제목을 입력하세요." value="<%= article.getTitle() %>"></td>
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
                    <a href="/JBoard1/view.jsp" class="btn btnCancel">취소</a>
                    <input type="submit" value="수정완료" class="btn btnComplete">
                </div>
            </form>
        </main>
<%@ include file="./_footer.jsp" %>