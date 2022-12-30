<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/admin/_header.jsp"/>
            <section id="admin-notice-view">
                <nav>
                    <h3>공지사항 보기</h3>
                    <p>
                        HOME > 고객센터 > <strong>공지사항</strong>
                    </p>
                </nav>
                <article class="list">
	               <table>
	               	<tr>
	               		<th>유형</th>
	               		<td>${notice.cate}</td>
	               	</tr>
	               	<tr>
	               		<th>제목</th>
	               		<td>${notice.title}</td>
	               	</tr>
	               	<tr>
	               		<th>내용</th>
	               		<td>${notice.content}</td>
	               	</tr>
	               </table>
	               <div>
	               <c:if test="${pg eq ''}">
	               	<a href="/Kmarket1/admin/cs/notice/list.do" class="btnNoticeList">목록</a>
	               </c:if>
	               <c:if test="${pg ne ''}">
					<a href="/Kmarket1/admin/cs/notice/list.do?pg=${pg}" class="btnNoticeList">목록</a>
					</c:if>
						<a href="/Kmarket1/admin/cs/notice/modify.do?&cate=${cate}&no=${no}" class="btnModify">수정</a>
						<a href="/Kmarket1/admin/cs/notice/delete.do?&cate=${cate}&no=${no}&pg=${pg}" class="btnDelete">삭제</a>
					</div>
	        	</article>        
            </section>
        </main>
<jsp:include page="/admin/_footer.jsp"/>