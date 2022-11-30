<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="./_header.jsp"/>
<script>
//데이터 검증에 사용할 정규표현식
let regName  = /^[가-힣]{2,4}$/;
let regNick  = /^[가-힣a-zA-Z0-9]+$/;
let regEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
let regHp	 = /^\d{3}-\d{3,4}-\d{4}$/;
let regPass  = /^.*(?=^.{5,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;

//폼 데이터 검증 결과 상태변수
let isPassOk  = true;
let isNameOk  = false;
let isNickOk  = false;
let isEmailOk = false;
let isEmailAuthOk = false;
let isEmailAuthCodeOk = false; // 얘가 최종적으로 폼 submit 결정할 변수
let receivedCode = 0;
let isHpOk    = false;	

	$(function(){
		$('#btnModifyPass').click(function(){
			let modPass = $('input[name=pass2]').val();
			let uid = $('input[name=uid]').val();
			
			$.ajax({
				url: '/JBoard2/user/modifyPass.do',
				method: 'post',
				data: {"uid":uid, "modPass":modPass},
				dataType: 'json',
				success: function(data){
					if(data.result > 0){
						alert('비밀번호가 정상적으로 변경되었습니다');
					}
				}
			});
		});
		
		// 패스워드 일치 확인
		$('input[name=pass2]').focusout(function(){
			let pass1 = $('input[name=pass1]').val();
			let pass2 = $(this).val();
			
			if(pass1 == pass2){
				
				if(pass2.match(regPass)){
					$('.pwResult').css('color', 'green').text('사용 가능한 패스워드 입니다');
				}else{
					isPassOk = false;
					$('.pwResult').css('color', 'red').text('영문, 숫자, 특수문자 조합 최소 다섯 자 이상이어야 합니다');
				}
			}else{
				isPassOk = false;
				$('.pwResult').css('color', 'red').text('패스워드가 일치하지 않습니다');
			}
		});
		
		// 이름 유효성 검사
		$('input[name=name]').focusout(function(){
			let name = $(this).val();
			
			if(!name.match(regName)){
				$('.nameResult').css('color', 'red').text('이름은 한글 두 자 이상이어야 합니다');
			}else{
				isNameOk = true;
				$('.nameResult').css('color', 'green').text('사용 가능한 이름입니다');
			}
		});
		
		// 별명 중복 검사
		$('#btnCheckNick').click(function(){
			let nick = $('input[name=nick]').val();
			
			if(isNickOk){
				return;
			}
			
			if(!nick.match(regNick)){
				isNickOk = false;
				$('.resultNick').css('color', 'red').text('별명이 유효하지 않습니다.');
				return;
			}
			
			$.ajax({
				url: '/JBoard2/user/checkNick.do',
				method: 'GET',
				data: {"nick":nick},
				dataType: 'json',
				success: function(data){
					if(data.result >0){
						$('.nickResult').css('color', 'red').text('이미 사용 중인 별명입니다');
						
					}else{
						isNickOk = true;
						$('.nickResult').css('color', 'green').text('사용 가능한 별명입니다');
					}
				}
			});
		});
		
		// 휴대폰 유효성 검사
		$('input[name=hp]').focusout(function(){
			let hp = $(this).val();
			
			if(!hp.match(regHp)){
				$('.hpResult').css('color', 'red').text('휴대폰 번호가 유효하지 않습니다');
			}else{
				isHpOk = true;
				$('.hpResult').css('color', 'green').text('사용 가능한 번호입니다');
			}
		});
		
		// 이메일 인증
		// 이메일 유효성 검사
		$('input[name=email]').focusout(function(){
			let email = $(this).val();
			
			if(!email.match(regEmail)){
				isEmailOk = false;
				$('.resultEmail').css('color', 'red').text('이메일이 유효하지 않습니다.');
			}else{
				isEmailOk = true;
				$('.resultEmail').text('');
			}			
		});
		
		// 이메일 인증 코드 발송
		$('#btnEmail').click(function(){
			
			$(this).hide(); // 인증번호 받기 다시 못누르게
			let email = $('input[name=email]').val();
			console.log('here1: ' + email); // 자바 logger와 같은 기능
			
			if(isEmailAuthOk){
				console.log('here2: ' + email);
				return;
			}
			isEmailAuthOk = true; // 한 번만 setTimeout 발동하게 처리한 것
			
			$('.emailResult').text('인증코드 이메일 전송 중 입니다. 잠시만 기다리세요.');
			console.log('here3: ');
			
			setTimeout(function(){
				console.log('here4: ');
				
				$.ajax({
					url: '/JBoard2/user/emailAuth.do',
					method: 'GET',
					data: {"email":email},
					dataType: 'json',
					success: function(data){
						// console.log(data); 콘솔로 결과 뜨게 하면 아무나 데이터 볼 수 있음
						
						if(data.status >0){
							// 메일 전송 성공
							console.log('here5: ');
							isEmailAuthOk = true;
							$('.emailResult').text('이메일을 확인 후 인증 코드를 입력하세요.');
							$('.auth').show(); // 원래 display:none 상태
							receivedCode = data.code;
							
						}else{
							// 메일 전송 실패
							console.log('here6: ');
							isEmailAuthOk = false;
							alert('메일 전송에 실패했습니다.\n다시 시도 하시기 바랍니다.');
						}
					}
				});
				
			}, 1000);
			
		});
		
		// 이메일 인증코드 확인 버튼
		$('#btnEmailConfirm').click(function(){
			let code = $('input[name=auth]').val();
			
			if(code == ''){
				alert('이메일 확인 후 인증 코드를 입력하세요.');
				return;
			}
			
			if(code == receivedCode){
				isEmailAuthCodeOk = true;
				$('input[name=email]').attr('readonly', true); // 다시 이메일 수정하지 못하도록
				$('.emailResult').text('이메일이 인증되었습니다.');
				$('.auth').hide();
			}else{
				isEmailAuthCodeOk = false;
				alert('인증코드가 틀립니다.\n다시 확인하십시오.');
			}
			
		});
		
		// 폼 전송이 시작될 때 실행되는 폼 이벤트(폼 전송 버튼을 클릭했을 때) 
		$('.register > form').submit(function(){
						
			////////////////////////////////////
			// 폼 데이터 유효성 검증(Validation)
			////////////////////////////////////
			// 비밀번호 검증
			if(!isPassOk){
				alert('비밀번호를 확인 하십시요.');
				return false;
			}
			// 이름 검증
			if(!isNameOk){
				alert('이름을 확인 하십시요.');
				return false;
			}
			// 별명 검증
			if(!isNickOk){
				alert('별명을 확인 하십시요.');
				return false;
			}
			// 이메일 검증
			 if(!isEmailOk){
				alert('이메일을 확인 하십시요.');
				return false;
			}
			
			// 이메일 인증코드 확인 검증
			if(!isEmailAuthCodeOk){
				alert('이메일 인증을 완료하십시오.');
				return false;
			}
			
			// 휴대폰 검증
			if(!isHpOk){
				alert('휴대폰을 확인 하십시요.');
				return false;
			}
			
			// 최종 전송
			return true;
		});
	});
</script>
<script src="http://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/JBoard2/js/postcode.js"></script>
        <main id="user">
            <section class="register">

                <form action="/JBoard2/user/myInfo.do" method="post">
                    <table border="1">
                        <caption>회원정보 설정</caption>
                        <input type="hidden" name="uid" value="${user.getUid()}"/>
                        <tr>
                            <td>아이디</td>
                            <td>
                                ${user.getUid()}
                            </td>
                        </tr>
                        <tr>
                            <td>비밀번호</td>
                            <td><input type="password" name="pass1" placeholder="비밀번호 입력"/></td>
                        </tr>
                        <tr>
                            <td>비밀번호 확인</td>
                            <td><input type="password" name="pass2" placeholder="비밀번호 입력 확인"/>
                            	<button type="button" id="btnModifyPass" style="padding:6px; background:blue; color:#fff;">비밀번호 수정</button>
                            </td>
                        </tr>
                        <tr>
                        	<td>회원가입일</td>
                        	<td>${user.getRdate()}</td>
                        </tr>
                    </table>

                    <table border="1">
                        <caption>개인정보 수정</caption>
                        <tr>
                            <td>이름</td>
                            <td>
                                <input type="text" name="name" value="${user.getName()}"/>
                                <span class="nameResult"></span>                        
                            </td>
                        </tr>
                        <tr>
                            <td>별명</td>
                            <td>
                                <p class="nickInfo">공백없는 한글, 영문, 숫자 입력</p>
                                <input type="text" name="nick" value="${user.getNick()}"/>
                                <button type="button" id="btnCheckNick"><img src="../img/chk_id.gif" alt="중복확인"/></button>
                                <span class="nickResult"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>이메일</td>
                            <td>
                                
                                <input type="email" name="email" value="${user.getEmail()}"/>
                                <span class="emailResult"></span>
                                <button type="button" id="btnEmail"><img src="../img/chk_auth.gif" alt="인증번호 받기"/></button>
                                <div class="auth">
                                    <input type="text" name="auth" placeholder="인증번호 입력"/>
                                    <button type="button" id="btnEmailConfirm"><img src="../img/chk_confirm.gif" alt="확인"/></button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>휴대폰</td>
                            <td><input type="text" name="hp" value="${user.getHp()}"/></td>
                            <span class="hpResult"></span>
                        </tr>
                        <tr>
                            <td>주소</td>
                            <td>
                                <input type="text" name="zip" id="zip" value="${user.getZip()}"/>
                                <button type="button" onclick="postcode()"><img src="../img/chk_post.gif" alt="우편번호찾기"/></button>
                                <input type="text" name="addr1" id="addr1" value="${user.getAddr1()}"/>
                                <input type="text" name="addr2" id="addr2" value="${user.getAddr2()}"/>
                            </td>
                        </tr>
                        <tr>
                        	<td>회원탈퇴</td>
                        	<td>
                        		<button type="button" onclick="location.href='/JBoard2/user/deleteUser.do?uid=${user.getUid()}'" style="padding:6px; background:#ed2f2f; color:#fff;">회원탈퇴</button>
                        	</td>
                        </tr>
                    </table>

                    <div>
                        <a href="/JBaord2/user/login.do" class="btn btnCancel">취소</a>
                        <input type="submit" value="회원수정" class="btn btnRegister"/>
                    </div>

                </form>

            </section>
        </main>
<jsp:include page="./_footer.jsp"/>