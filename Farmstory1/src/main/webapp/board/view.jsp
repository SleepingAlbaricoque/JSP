<%@page import="java.util.List"%>
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
	
	// 댓글 가져오기
	List<ArticleBean> comments = ArticleDAO.getInstance().selectComments(no);

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
		
		// 댓글 작성하기
		$('.commentForm > form').submit(function(){
			
			let pg =$(this).children('input[name=pg]').val();
			let parent =$(this).children('input[name=parent]').val();
			let uid =$(this).children('input[name=uid]').val();
			let textarea =$(this).children('textarea[name=content]')
			let content = textarea.val();
			
			let jsonData ={
				"pg": pg,	
				"parent": parent,	
				"content": content,	
				"uid":uid
			};
			
			console.log(jsonData);
			
			$.ajax({
				url: '/Farmstory1/board/proc/commentWriteProc.jsp',
				method: 'POST',
				data: jsonData,
				dataType: 'json',
				success: function(data){
					
					let article = "<article>";
						article += "<span class='nick'>"+data.nick+"</span>";
						article += "<span class='date'>"+data.date+"</span>";
						article += "<p class='content'>"+data.content+"</p>";
						article += "<div>";
						article += "<a href='#' class='remove' data-no='"+data.no+"'>삭제</a>";
						article += "<a href='#' class='modify' data-no='"+data.no+"'> 수정</a>";
						article += "</div>";
						article += "</article>";
						
					$('.commentList > .empty').hide();
					$('.commentList').append(article);
					textarea.val('');
				}
			});
			
			return false;
		});
		
		// 댓글 수정하기
		$(document).on('click', '.modify', function(e){
			e.preventDefault();
			
			let txt = $(this).text();
			let p = $(this).parent().prev();
			
			if(txt == ' 수정'){
				$(this).text(' 수정완료');
				p.attr('contentEditable', true);
				p.focus();
			}else{
				$(this).text(' 수정');
				p.attr('contentEditable', false);
				
				let content = p.text();
				let no = $(this).attr('data-no');
				
				let jsonData ={
						"content": content,
						"no": no
				};
				
				$.ajax({
					url: '/Farmstory1/board/proc/commentModifyProc.jsp',
					type: 'POST',
					data: jsonData,
					dataType: 'json',
					success: function(data){
						if(data.resut >0){
							alert('댓글이 수정되었습니다.');
						}
					}
				});
			}
		});
		
		// 댓글 삭제하기
		$(document).on('click', '.remove', function(e){
			e.preventDefault();
			
			let tag = $(this);
			let result = confirm('정말 삭제 하시겠습니까?');
			
			if(result){
				let no = $(this).attr('data-no');
				
				$.ajax({
					url: '/Farmstory1/board/proc/commentDeleteProc.jsp?no='+no,
					type: 'GET',
					dataType: 'json',
					success: function(data){
						alert('댓글이 삭제되었습니다.');
						
						tag.parent().parent().hide();
					}
				});
			}
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
		                <a href="/Farmstory1/board/proc/deleteProc.jsp?group=<%= group %>&cate=<%= cate %>&no=<%= ab.getNo() %>&pg=<%= pg %>" class="btn btnRemove">삭제</a>
		                <a href="./modify.jsp?group=<%= group %>&cate=<%= cate %>&no=<%= ab.getNo() %>&pg=<%= pg %>" class="btn btnModify">수정</a>
		                <% } %>
		                <a href="./list.jsp?group=<%= group %>&cate=<%= cate %>&pg=<%= pg %>" class="btn btnList">목록</a>
		           </div>
		
		           <!--댓글 목록-->
		           <section class="commentList">
		                <h3>댓글목록</h3>
		                <% for(ArticleBean comment : comments){ %>
		                <article>
		                    <span class="nick"><%= comment.getNick() %></span>
		                    <span class="date"><%= comment.getRdate() %></span>
		                    <p class="content"><%= comment.getContent() %></p>
		                    <% if(sessUser.getUid().equals(comment.getUid())){ %>
		                    <div>
		                        <a href="#" class="remove" data-no="<%= comment.getNo() %>">삭제</a>
		                        <a href="./modify.jsp" class="view">수정</a>
		                    </div>
		                    <% } %>
		                </article>
		                <% } %>
		                
		                <% if(comments.size() == 0){ %>
		                <p class="empty">등록된 댓글이 없습니다.</p>
		                <% } %>
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