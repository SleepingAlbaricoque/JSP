<%@page import="java.util.List"%>
<%@page import="kr.co.jboard1.dao.ArticleDAO"%>
<%@page import="kr.co.jboard1.bean.ArticleBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="kr.co.jboard1.db.SQL"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kr.co.jboard1.db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String no = request.getParameter("no");
	String pg = request.getParameter("pg");
	
	// DAO 객체 생성
	ArticleDAO dao = ArticleDAO.getInstance();
	
	// 글 가져오기
	ArticleBean ab = dao.selectArticle(no);
	
	// 글 조회 수 카운트 +1
	dao.updateArticleHit(no);
	
	// 댓글 가져오기
	List<ArticleBean> comments = dao.selectComments(no);
%>
<%@ include file= "./_header.jsp" %>
<script>
	$(document).ready(function(){
		
		// 댓글 수정하기
		
		$(document).on('click', '.modify', function(e){
			e.preventDefault(); // 이벤트 자동 실행 방지
			
			let txt = $(this).text();
			let p = $(this).parent().prev(); // 여기서 this는 클릭된 modify의 a 태그 지칭
			// prev(): Get the immediately preceding sibling of each element in the set of matched elements. 
			// If a selector is provided, it retrieves the previous sibling only if it matches that selector
			
			if(txt == '수정'){
				// 수정모드
				$(this).text('수정완료');
				p.attr('contentEditable', true); // p의 속성 contentEditable을 true로
				p.focus(); // p에 커서 위치시키기
			}else{
				// 수정 완료
				$(this).text('수정');
				p.attr('contentEditable', false);
				
				let content = p.text();
				let no = $(this).attr('data-no');
				
				let jsonData = {
						"content": content,
						"no" : no
				};
				
				// 수정한 댓글 데이터 proc 페이지에 넘겨서 거기서 DB로 insert할 수 있도록
				$.ajax({
					url: '/JBoard1/proc/commentModifyProc.jsp',
					type: 'POST',
					data: jsonData,
					dataType: 'json',
					success: function(data){
						
						if(data.result >0){ // data.result == 1보다 >0이 나음 <-result값이 2가 되는 경우도 있다고 함
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
					url: '/JBoard1/proc/commentDeleteProc.jsp?no='+no,
					type: 'GET', // 넘기는 값 하나라 jsonData 만들지 않고 get으로 해서 주소로 바로 넘겨주기
					dataType: 'json',
					success: function(data){
						alert('댓글이 삭제되었습니다.');
						
						// 화면 삭제
						// 여기서는 this 선택자 사용 불가 <- ajax success function과 $(document).on()의 스코프 다름
						tag.parent().parent().hide();
						// tag.closest('article').hide();도 가능, closest는 조상 태그 중에 argument와 일치하는, this에서 가장 가까운 태그 선택
					}
				});
			}
		});
		
		// 댓글쓰기
		$('.commentForm > form').submit(function(){
			
			let pg = $(this).children('input[name=pg]').val();
			let parent = $(this).children('input[name=parent]').val();
			let uid = $(this).children('input[name=uid]').val();
			let textarea = $(this).children('textarea[name=content]');
			let content = textarea.val();
			
			let jsonData = {
				"pg":pg,	
				"parent":parent,	
				"content":content,	
				"uid":uid	
			};
			
			console.log(jsonData);
			
			$.ajax({
				url: '/JBoard1/proc/commentWriteProc.jsp', // url 페이지는 json을 다시 넘겨주어야 함
				method: 'POST',
				data: jsonData, // json 형식으로 데이터를 전송
				dataType: 'json',
				success: function(data){ // json 데이터 받아오기
					
					console.log(data);
					
					let article = "</article>"; // 댓글 목록 동적 생성하기 위하여 태그 동적 생성
					    article += "<span class='nick'>"+data.nick+"</span>";
					    article += "<span class='date'>"+data.date+"</span>";
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
			
			
			return false; // 폼 전송되는 것 막기 위해서 <- ajax써서 동적으로 댓글 추가 및 로드하려고
		});
	});
</script>
        </header>
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
                <td><a href="/JBoard1/proc/download.jsp?fno=<%= ab.getFno() %>"><%= ab.getOriName() %></a>&nbsp;<span><%= ab.getDownload() %></span>회 다운로드</td>
            </tr>
            <% } %>
            <tr>
                <th>내용</th>
                <td><textarea name="content" readonly><%= ab.getContent() %></textarea></td>
            </tr>
           </table>

           <div>
           		<% if(sessUser.getUid().equals(ab.getUid())){ %> 
                <a href="/JBoard1/proc/deleteProc.jsp?no=<%= ab.getNo() %>&pg=<%= pg %>" class="btn btnRemove">삭제</a>
                <a href="/JBoard1/modify.jsp?no=<%= ab.getNo() %>&pg=<%= pg %>" class="btn btnModify">수정</a>
                <% } %>
                <a href="/JBoard1/list.jsp?pg=<%= pg %>" class="btn btnList">목록</a>
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
                        <a href="#" class="modify" data-no="<%= comment.getNo() %>">수정</a>
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
                <form action=# method="post">
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
<%@ include file="./_footer.jsp" %>