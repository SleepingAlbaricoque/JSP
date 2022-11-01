<%@page import="kr.co.jboard1.dao.ArticleDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.jboard1.bean.ArticleBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="kr.co.jboard1.db.SQL"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kr.co.jboard1.db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String pg = request.getParameter("pg");
	
	
	int start = 0;
	int total = 0;
	int lastPageNum = 0;
	int currentPage = 1;
	int currentPageGroup = 1;
	int pageGroupStart = 0;
	int pageGroupEnd = 0;
	int pageStartNum = 0;
	
	if(pg != null) // 로그인해서 들어오면 바로 1페이지 보이는데 이때 login.jsp에서 넘어온 거라 pg값을 받지 못함 -> pg값은 null
		currentPage = Integer.parseInt(pg);
	else
	
	start = (currentPage - 1)*10;
	currentPageGroup = (int) Math.ceil(currentPage /10.0);
	pageGroupStart = (currentPageGroup - 1) * 10 + 1; // 2그룹은 11 ~ 20 페이지의 그룹이므로 currentPageGroup이 2 -> 해당 식에 대입해보면 결과 11 나옴
	pageGroupEnd = currentPageGroup * 10;
	
	ArticleDAO dao = ArticleDAO.getInstance();
	
	// 전체 게시물 갯수
	total = dao.selectCountTotal();
	
	// 마지막 페이지 번호
	if(total % 10 == 0){
		lastPageNum = total / 10;
	}else{
		lastPageNum = total / 10 + 1;
	}
	
	if(pageGroupEnd > lastPageNum){
		pageGroupEnd = lastPageNum;
	}
	
	pageStartNum = total - start; // getNo로 글번호 하면 DB의 글번호를 사용하게 되는데, no가 auto increment라 삭제해서 없어진 번호도 있어서 글이 목록에서 가지는 실제 순서와 다를 수 있음
	
	List<ArticleBean> articles = dao.selectArticles(start);
	
%>
<%@ include file="./_header.jsp" %>
        <main id="board" class="list">
            <table border="0">
                <caption>글목록</caption>
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>글쓴이</th>
                    <th>날짜</th>
                    <th>조회</th>
                </tr>
                <% for(ArticleBean article: articles){ %>
                <tr>
                    <td><%= pageStartNum-- %></td>
                    <td><a href="/JBoard1/view.jsp?no=<%= article.getNo()%>&pg=<%= currentPage %>"><%= article.getTitle() %>[<%= article.getComment() %>]</a></td>
                    <td><%= article.getNick() %></td>
                    <td><%= article.getRdate().substring(2, 10) %></td>
                    <td><%= article.getHit() %></td>
                </tr>
                <% } %>
            </table>

            <div class="page">
            	<% if(pageGroupStart > 1){ %>
                <a href="/JBoard1/list.jsp?pg=<%= pageGroupStart - 1 %>" class="prev">이전</a>
                <% } %>
                
                <% for(int num = pageGroupStart; num <= pageGroupEnd; num++){ %>
                <a href="/JBoard1/list.jsp?pg=<%= num %>" class="num <%= (num == currentPage) ? "current": "off" %>"><%= num %></a>
                <% } %>
                
                <% if(pageGroupEnd < lastPageNum ){ %> <!-- pageGroupEnd와 lastPageNum이 같으면 더이상 다음 버튼이 뜨지 않는다 -->
                <a href="/JBoard1/list.jsp?pg=<%= pageGroupEnd + 1 %>" class="next">다음</a>
                <% } %>
            </div>

            <a href="/JBoard1/write.jsp" class="btnWrite">글쓰기</a>
        </main>
<%@ include file="./_footer.jsp" %>