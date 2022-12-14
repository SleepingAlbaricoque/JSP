<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="./_header.jsp"/>
<script>
	$(function(){
		let sessUser = '${sessUser}';
		console.log(sessUser);
		if('${sessUser}' == ''){
			alert('로그인 후 이용 가능합니다');
			location.href = "/Farmstory2/user/login.do";
		}
		
		$('.btnNext').click(function(){
			let pass = $('input[name=pass]').val();
			let uid = $('input[name=uid]').val();
			
			$.ajax({
				url: '/Farmstory2/user/info.do',
				method: 'POST',
				data: {"pass":pass, "uid": uid},
				dataType: 'json',
				success: function(data){
					if(data.result > 0){
						location.href = "/Farmstory2/user/myInfo.do";
					}else{
						alert('비밀번호가 일치하지 않습니다');
						return;
					}
				}
			});
		});
	});
</script>
<main id="user">
	    <section class="find findId">
	        <form action="#">
	            <table border="0">
	                <caption>비밀번호 확인</caption>
	                <tr>
	                    <td>비밀번호</td>
	                    <td><input type="password" name="pass" placeholder="비밀번호 입력"/></td>
	                    <input type="hidden" name="uid" value="${sessUser.uid}"/>
	                </tr>                
	            </table>                                        
	        </form>
	        
	        <p>
	            회원님의 정보를 보호하기 위해 비밀번호를 다시 확인합니다.
	        </p>
	
	        <div>
	            <a href="/Farmstory2/index.do" class="btn btnCancel">취소</a>
	            <a href="#" class="btn btnNext">다음</a>
	        </div>
	    </section>
	</main>
<jsp:include page="/WEB-INF/_footer.jsp"/>