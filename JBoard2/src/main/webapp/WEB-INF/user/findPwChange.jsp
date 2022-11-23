<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="./_header.jsp"/>
<script>
	let regPass  = /^.*(?=^.{5,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
	
	$(function(){
		$('.btnNext').click(function(e){
			e.preventDefault();
			
			let uid = $('.uid').text();
			let pass1 = $('input[name=pass1]').val();
			let pass2 = $('input[name=pass2]').val();
			
			if(pass1 != pass2){
				alert('비밀번호가 일치하지 않습니다');
				return;
			}
			
			if(!pass2.match(regPass)){
				alert('영문, 숫자, 특수문자 조합 최소 다섯 자 이상이어야 합니다');
				return;
			}
			
			let jsonData = {
				"uid" : uid,
				"pass" : pass2
			};
			
			//alert('성공');
			$.ajax({
				url: '/JBoard2/user/findPwChange.do',
				method: 'post',
				data: jsonData,
				dataType: 'json',
				success: function(data){
					console.log('here5');
					
					if(data.result > 0){
						alert('비밀번호 변경 완료\n다시 로그인하세요');
						location.href = "/JBoard2/user/login.do";
					}
				}
			});
		});
	});
</script>
        <main id="user">
            <section class="find findPwChange">
                <form action="#">
                    <table border="0">
                        <caption>비밀번호 변경</caption>                        
                        <tr>
                            <td>아이디</td>
                            <td class="uid">${uid}</td>
                        </tr>
                        <tr>
                            <td>새 비밀번호</td>
                            <td>
                                <input type="password" name="pass1" placeholder="새 비밀번호 입력"/>
                                <span class="pwResult"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>새 비밀번호 확인</td>
                            <td>
                                <input type="password" name="pass2" placeholder="새 비밀번호 입력"/>
                            </td>
                        </tr>
                    </table>                                        
                </form>
                
                <p>
                    비밀번호를 변경해 주세요.<br>
                    영문, 숫자, 특수문자를 사용하여 8자 이상 입력해 주세요.                    
                </p>

                <div>
                    <a href="/JBoard2/user/login.do" class="btn btnCancel">취소</a>
                    <a href="/JBoard2/user/login.do" class="btn btnNext">다음</a>
                </div>
            </section>
        </main>
<jsp:include page="./_footer.jsp"/>