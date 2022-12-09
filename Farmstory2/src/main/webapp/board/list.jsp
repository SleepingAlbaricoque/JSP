<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:choose>
	<c:when test="${null ne sessUser}">
		<jsp:include page="/user/_header.jsp"/>
	</c:when>
	<c:otherwise>
		<jsp:include page="/WEB-INF/_header.jsp"/>
	</c:otherwise>
</c:choose>
<jsp:include page="./_${group}.jsp"/>
	<main id="board">
    <section class="list">                
        <form action="/Farmstory2/board/list.do" method="get">
        	<input type="hidden" name="group" value="${group}">
        	<input type="hidden" name="cate" value="${cate}">
        	<select name="searchOption">
        		<option value="title">제목</option>
        		<option value="nick">글쓴이</option>
        	</select>
            <input type="text" name="search" placeholder="제목 키워드, 글쓴이 검색">
            <input type="submit" value="검색" class="btnSearch">
        </form>
        
        <table border="0">
            <caption>글목록</caption>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>글쓴이</th>
                <th>날짜</th>
                <th>조회</th>
            </tr>   
            <c:forEach var="article" items="${articles}">                
            <tr>
                <td>${pageStartNum = pageStartNum -1}</td>
                <td><a href="/Farmstory2/board/view.do?no=${article.no}&pg=${currentPage}&cate=${cate}&group=${group}">${article.title}[${article.comment}]</a></td>
                <td>${article.nick}</td>
                <td>${article.rdate}</td>
                <td>${article.hit}</td>
            </tr>
            </c:forEach> 
        </table>

        <div class="page">
        	<c:if test="${pageGroupStart >1}">
            <a href="/Farmstory2/board/list.do?pg=${pageGroupStart -1}&group=${group}&cate=${cate}" class="prev">이전</a>
            </c:if>
            <c:forEach var="num" begin="${pageGroupStart}" end="${pageGroupEnd}" step="1">
            <a href="/Farmstory2/board/list.do?pg=${num}&group=${group}&cate=${cate}" class="num ${(num == currentPage)? 'current' : 'off'}">${num}</a>
            </c:forEach>
            <c:if test="${pageGroupEnd < lastPageNum}">
            <a href="/Farmstory2/board/list.do?pg=${pageGroupEnd +1}&group=${group}&cate=${cate}" class="next">다음</a>
            </c:if>
        </div>

        <a href="./write.do?group=${group}&cate=${cate}" class="btn btnWrite">글쓰기</a>
        
    </section>
</main>
</article>
    </section>
</div>
<jsp:include page="/WEB-INF/_footer.jsp"/>