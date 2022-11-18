<%@page import="kr.co.farmstory1.beans.ArticleBean"%>
<%@page import="kr.co.farmstory1.dao.ArticleDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_header.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");
	String no = request.getParameter("no");
	String pg = request.getParameter("pg");
	
	// 글 불러오기
	ArticleBean ab = ArticleDAO.getInstance().selectArticle(no);
	
	// 글 조회 수 올리기
	ArticleDAO.getInstance().updateArticleHit(no);

	if(sessUser == null){
		response.sendRedirect("/Farmstory1/user/login.jsp?success=101");
		return;
	}

	String group = request.getParameter("group");
	String cate = request.getParameter("cate");
	
	// aside 내용 불러오기
	pageContext.include("./_" + group+ ".jsp");
%>
<script>
	$(function(){
		
		// 글 작성하기
		$('.commentForm > form').submit(function(){
			
			let pg =$(this).children('input[name=pg]').val();
			let parent =$(this).children('input[name=parent]').val();
			let uid =$(this).children('input[name=uid]').val();
			let content =$(this).children('textarea[name=content]').val();
			
			let jsonData ={
				"pg": pg,	
				"parent": parent,	
				"uid": uid,	
				"content": content,	
			};
			
			$.ajax({
				url: '/Farmstory1/board/proc/commentWriteProc.jsp',
				method: 'POST',
				data: 'jsonData',
				dataType: 'json',
				success: function(data){
					
					let article = "<article>";
						article += "<span class="nick">"+data.nick+"</span>";
						article += "<span class="date">"+data.date+"</span>";
						article += "<p class='content'>"+data.content+"</p>";
						article += "<div>";
						article += "<a href='#' class='remove' data-no='"+data.no+"'>삭제</a>";
						article += "<a href='#' class='modify' data-no='"+data.no+"'>수정</a>";
						article += "</div>";
						article += "</article>";
						
					$('.commentList > .empty').hide();
					$('.commentList').append(article);
					textarea.val('');
				}
			});
		});
	});
</script>
		        <main id="board" class="view">
		           <table>
		            <caption>글보기</caption>
		            <tr>
		                <th>제목</th>
		                <td><input type="text" name="title" value="<%= ab.getTitle() %>" readonly></td>
		            </tr>
		            <% if(ab.getFile() >0 ){ %>
		            <tr>
		                <th>파일</th>
		                <td><a href="/Farmstory1/board/proc/download.jsp?fno=<%= ab.getFno() %>"><%= ab.getOriName() %></a><span><%= ab.getDownload() %></span>회 다운로드</td>
		            </tr>
		            <% } %>
		            <tr>
		                <th>내용</th>
		                <td><textarea name="content" readonly><%= ab.getContent() %></textarea></td>
		            </tr>
		           </table>
		
		           <div>
		           		<% if(sessUser.getUid().equals(ab.getUid())){ %>
		                <a href="#" class="btn btnRemove">삭제</a>
		                <a href="./modify.jsp?group=<%= group %>&cate=<%= cate %>" class="btn btnModify">수정</a>
		                <% } %>
		                <a href="./list.jsp?group=<%= group %>&cate=<%= cate %>&pg=<%= pg %>" class="btn btnList">목록</a>
		           </div>
		
		           <!--댓글 목록-->
		           <section class="commentList">
		                <h3>댓글목록</h3>
		                <article>
		                    <span class="nick">길동이</span>
		                    <span class="date">20-05-13</span>
		                    <p class="content">댓글 샘플입니다.</p>
		                    <div>
		                        <a href="#" class="remove">삭제</a>
		                        <a href="./modify.jsp" class="view">수정</a>
		                    </div>
		                </article>
		                <p class="empty">등록된 댓글이 없습니다.</p>
		           </section>
		           
		           <!--댓글 쓰기-->
		           <section class="commentForm">
		                <h3>댓글쓰기</h3>
		                <form action="#" method="post">
		                	<input type="hidden" name="pg" value="<%= pg %>">
		                	<input type="hidden" name="parent" value="<%= no %>">
		                	<input type="hidden" name="uid" value="<%= sessUser.getUid() %>">
		                    <textarea name="content" placeholder="댓글내용 입력"></textarea>
		                    <div>
		                        <a href="#" class="btn btnCancel">취소</a>
		                        <input type="submit" class="btn btnComplete" value="작성완료">
		                    </div>
		                </form>
		
		           </section>
		        </main>
      	</article>
    </section>
</div>
<%@ include file="../_footer.jsp" %>