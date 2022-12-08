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
<script>

	$(function(){
		if('${comments}' != null){
			$('.empty').hide();
		}
		
		// 댓글 쓰기
		$('.commentForm > form').submit(function(){
			let parent = $(this).children('input[name=parent]').val();
			let uid = $(this).children('input[name=uid]').val();
			let group = $(this).children('input[name=group]').val();
			let textarea = $(this).children('textarea[name=content]');
			let content = textarea.val();
			
			
			let jsonData = {
				"group": group,
				"parent": parent,
				"uid": uid,
				"content": content
			};
			console.log(jsonData);
			
			$.ajax({
				url: '/Farmstory2/board/view.do',
				method: 'POST',
				data: jsonData,
				dataType: 'json',
				success: function(data){
					let article = "<article>"; // 댓글 목록 동적 생성하기 위하여 태그 동적 생성
				    article += "<span class='nick'>"+data.nick+"</span>";
				    article += "<span class='date'>"+data.rdate+"</span>";
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
			return false;
		});
		
		// 댓글 수정
		$('.modify').click(function(){
			let txt = $(this).text();
			let p = $(this).parent().prev();
			
			if(txt == '수정'){
				$(this).text('수정완료');
				p.attr('contentEditable', true);
				p.focus();
			}else{
				$(this).text('수정');
				p.attr('contentEditable', false);
				
				let content = p.text();
				let no = $(this).attr('data-no');
				console.log(content);
				console.log(no);
				
				let jsonData ={
						"content": content,
						"no": no
				};
				
				$.ajax({
					url: '/Farmstory2/board/commentModify.do',
					method: 'POST',
					data: jsonData,
					dataType: 'json',
					success: function(data){
						alert('댓글이 수정되었습니다');
					}
				});
			}
		});
		
		// 댓글 삭제
		$('.remove').click(function(){
			let tag = $(this);
			let result = confirm('정말 삭제하시겠습니까?');
			
			if(result){
				let no = $(this).attr('data-no');
				
				$.ajax({
					url: '/Farmstory2/board/commentDelete.do',
					method: 'POST',
					data: {"no":no},
					dataType: 'json',
					success: function(data){
						alert('댓글이 삭제되었습니다');
						tag.parent().parent().hide();
					}
				});
			}
		});
	});
</script>
<main id="board">
    <section class="view">
        
        <table border="0">
            <caption>글보기</caption>
            <tr>
                <th>제목</th>
                <td><input type="text" name="title" value="${article.title}" readonly/></td>
            </tr>
            <c:if test="${article.file >0 }">
            <tr>
                <th>파일</th>
                <td><a href="/Farmstory2/board/download.do?fno=${article.fno}">${article.oriName}</a>&nbsp;<span>${article.download}</span>회 다운로드</td>
            </tr>
            </c:if>
            <tr>
                <th>내용</th>
                <td>
                    <textarea name="content" readonly>${article.content}</textarea>
                </td>
            </tr>                    
        </table>
        
        <div>
        	<c:if test="${sessUser.uid eq article.uid}">
            <a href="/Farmstory2/board/delete.do?group=${group}&cate=${cate}&no=${no}" class="btn btnRemove">삭제</a>
            <a href="/Farmstory2/board/modify.do?group=${group}&cate=${cate}&no=${no}&pg=${pg}" class="btn btnModify">수정</a>
            </c:if>
            <a href="/Farmstory2/board/list.do?group=${group}&cate=${cate}&pg=1" class="btn btnList">목록</a>
        </div>

        <!-- 댓글목록 -->
        <section class="commentList">
            <h3>댓글목록</h3>                   
			
			<c:forEach var="comment" items="${comments}">
            <article>
                <span class="nick">${comment.nick}</span>
                <span class="date">${comment.rdate}</span>
                <p class="content">${comment.content}</p>                        
                <div>
                    <a href="#" class="remove" data-no="${comment.no}">삭제</a>
                    <a href="#" class="modify" data-no="${comment.no}">수정</a>
                </div>
            </article>
            </c:forEach>

            <p class="empty">등록된 댓글이 없습니다.</p>

        </section>

        <!-- 댓글쓰기 -->
        <section class="commentForm">
            <h3>댓글쓰기</h3>
            <form action="#">
            	<input type="hidden" name="parent" value="${no}"/>
            	<input type="hidden" name="uid" value="${sessUser.uid}"/>
                <input type="hidden" name="group" value="${group}"/>
                <textarea name="content" placeholder="댓글내용 입력"></textarea>
                <div>
                    <a href="#" class="btn btnCancel">취소</a>
                    <input type="submit" value="작성완료" class="btn btnComplete"/>
                </div>
            </form>
        </section>

    </section>
</main>
</article>
    </section>
</div>
<jsp:include page="/WEB-INF/_footer.jsp"/>