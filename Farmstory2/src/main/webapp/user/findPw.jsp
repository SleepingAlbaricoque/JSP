<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/_header.jsp"/>
<script>
let isEmailAuthOk = false;
let receivedCode = 0;
let isEmailAuthCodeOk = false;

	$(function(){
		// 이메일 인증 코드 발송
		$('#btnEmail').click(function(){
			$(this).hide();
			let email = $('input[name=email]').val();
			console.log('here1: ' + email);
			
			if(isEmailAuthOk){
				console.log('here2');
				return;
			}
			
			$('.emailResult').text('인증코드 이메일 전송 중 입니다');
			console.log('here3');
			
			setTimeout(function(){
				console.log('here4');
				$.ajax({
					url: '/Farmstory2/user/emailAuth.do',
					method: 'GET',
					data: {"email":email},
					dataType: 'json',
					success: function(data){
						if(data.status >0){
							// 메일 전송 성공
							isEmailAuthOk = true;
							$('.emailResult').text('이메일을 확인 후 인증 코드를 입력하세요');
							$('.auth').show();
							receivedCode = data.code;
						}else{
							isEamilAuthOk = false;
							alert('메일 전송에 실패했습니다.\n다시 시도하시기 바랍니다');
						}
					}
				});
				
			}, 500);
		});
		
		// 이메일 인증코드 확인 버튼
		$('#btnEmailConfirm').click(function(){
			let code = $('input[name=auth]').val();
			
			if(code == ''){
				alert('이메일 확인 후 인증 코드를 입력하세요');
				return;
			}
			
			if(code == receivedCode){
				isEmailAuthCodeOk = true;
				$('input[name=email]').attr('readonly', true);
				$('.emailResult').text('이메일이 인증되었습니다');
				$('.auth').hide();
			}else{
				isEmailAuthCodeOk = false;
				alert('인증코드가 틀립니다\n다시 확인하십시오');
			}
		});
		
		$('.btnNext').click(function(){
			if(isEmailAuthCodeOk){
				let uid = $('input[name=uid]').val();
				let email = $('input[name=email]').val();
				
				$.ajax({
					url: '/Farmstory2/user/findPw.do',
					method: 'POST',
					data: {"uid":uid, "email":email},
					dataType: 'json',
					success: function(data){
						if(data.result > 0){
							location.href = "/Farmstory2/user/findPwChange.do?uid=" + uid;
						}else{
							alert('해당하는 사용자가 존재하지 않습니다');
						}
					}
				});
				return false;
			}else{
				alert('이메일 인증을 하셔야 합니다');
				return false;
			}
		});
	});
</script>
        <main id="user">
            <section class="find findPw">
                <form action="#">
                    <table border="0">
                        <caption>비밀번호 찾기</caption>                        
                        <tr>
                            <td>아이디</td>
                            <td><input type="text" name="uid" placeholder="아이디 입력"/></td>
                        </tr>
                        <tr>
                            <td>이메일</td>
                            <td>
                                <div>
                                    <input type="email" name="email" placeholder="이메일 입력"/>
                                    <span class="emailResult"></span>
                                    <button type="button" class="btnAuth" id="btnEmail">인증번호 받기</button>
                                </div>
                                <div class="auth">
                                    <input type="text" name="auth" placeholder="인증번호 입력"/>
                                    <button type="button" class="btnConfirm" id="btnEmailConfirm">확인</button>
                                </div>
                            </td>
                        </tr>                        
                    </table>                                        
                </form>
                
                <p>
                    비밀번호를 찾고자 하는 아이디와 이메일을 입력해 주세요.<br>                    
                    회원가입시 입력한 아이디와 이메일 주소가 같아야, 인증번호를 받을 수 있습니다.<br>
                    인증번호를 입력 후 확인 버튼을 누르세요.
                </p>

                <div>
                    <a href="/Farmstory2/user/login.do" class="btn btnCancel">취소</a>
                    <a href="/Farmstory2/user/findPwChange.do" class="btn btnNext">다음</a>
                </div>
            </section>
        </main>
<jsp:include page="/WEB-INF/_footer.jsp"/>