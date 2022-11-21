<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="./_header.jsp"/>
<script src="http://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/JBoard2/js/postcode.js"></script>
<script>
	// 데이터 검증에 사용할 정규표현식
	let regUid   = /^[a-z]+[a-z0-9]{4,19}$/g;
	let regName  = /^[가-힣]{2,4}$/;
	let regNick  = /^[가-힣a-zA-Z0-9]+$/;
	//let regEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	let regHp	 = /^\d{3}-\d{3,4}-\d{4}$/;
	let regPass  = /^.*(?=^.{5,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;

	//폼 데이터 검증 결과 상태변수
	let isUidOk   = false;
	let isPassOk  = false;
	let isNameOk  = false;
	let isNickOk  = false;
	//let isEmailOk = false;
	let isHpOk    = false;	

	$(function(){
		
		// 아이디 중복 검사
		$('#btnCheckUid').click(function(){
			let uid = $('input[name=uid]').val();
			
			if(isUidOk){
				return;
			}
			
			if(!uid.match(regUid)){
				isUidOk = false;
				$('.uidResult').css('color', 'red').text('아이디가 유효하지 않습니다.');
				return;
			}
			
			$.ajax({
				url: '/JBoard2/user/checkUid.do',
				method: 'GET',
				data: {"uid":uid},
				dataType: 'json',
				success: function(data){
					if(data.result > 0){
						$('.uidResult').css('color','red').text('이미 사용 중인 아이디 입니다');
						
					}else{
						isUidOk = true;
						$('.uidResult').css('color','green').text('사용 가능한 아이디 입니다');
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
					isPassOk = true;
					$('.pwResult').css('color', 'green').text('사용 가능한 패스워드 입니다');
				}else{
					$('.pwResult').css('color', 'red').text('영문, 숫자, 특수문자 조합 최소 다섯 자 이상이어야 합니다');
				}
			}else{
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
		
		// 폼 전송이 시작될 때 실행되는 폼 이벤트(폼 전송 버튼을 클릭했을 때) 
		$('.register > form').submit(function(){
						
			////////////////////////////////////
			// 폼 데이터 유효성 검증(Validation)
			////////////////////////////////////
			// 아이디 검증
			if(!isUidOk){
				alert('아이디를 확인 하십시요.');
				return false;
			}
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
			/* if(!isEmailOk){
				alert('이메일을 확인 하십시요.');
				return false;
			}
			*/
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
        <main id="user">
            <section class="register">

                <form action="/JBoard2/user/register.do" method="post">
                    <table border="1">
                        <caption>사이트 이용정보 입력</caption>
                        <tr>
                            <td>아이디</td>
                            <td>
                                <input type="text" name="uid" placeholder="아이디 입력"/>
                                <button type="button" id="btnCheckUid"><img src="../img/chk_id.gif" alt="중복확인"/></button>
                                <span class="uidResult"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>비밀번호</td>
                            <td><input type="password" name="pass1" placeholder="비밀번호 입력"/></td>
                        </tr>
                        <tr>
                            <td>비밀번호 확인</td>
                            <td><input type="password" name="pass2" placeholder="비밀번호 입력 확인"/><span class="pwResult"></span></td>
                        </tr>
                    </table>

                    <table border="1">
                        <caption>개인정보 입력</caption>
                        <tr>
                            <td>이름</td>
                            <td>
                                <input type="text" name="name" placeholder="이름 입력"/>
                                <span class="nameResult"></span>                        
                            </td>
                        </tr>
                        <tr>
                            <td>별명</td>
                            <td>
                                <p class="nickInfo">공백없는 한글, 영문, 숫자 입력</p>
                                <input type="text" name="nick" placeholder="별명 입력"/>
                                <button type="button" id="btnCheckNick"><img src="../img/chk_id.gif" alt="중복확인"/></button>
                                <span class="nickResult"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>이메일</td>
                            <td>
                                
                                <input type="email" name="email" placeholder="이메일 입력"/>
                                <button type="button"><img src="../img/chk_auth.gif" alt="인증번호 받기"/></button>
                                <div class="auth">
                                    <input type="text" name="auth" placeholder="인증번호 입력"/>
                                    <button type="button"><img src="../img/chk_confirm.gif" alt="확인"/></button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>휴대폰</td>
                            <td><input type="text" name="hp" placeholder="휴대폰 입력"/></td>
                            <span class="hpResult"></span>
                        </tr>
                        <tr>
                            <td>주소</td>
                            <td>
                                <input type="text" name="zip" id="zip" placeholder="우편번호"/>
                                <button type="button" onclick="postcode()"><img src="../img/chk_post.gif" alt="우편번호찾기"/></button>
                                <input type="text" name="addr1" id="addr1" placeholder="주소 검색"/>
                                <input type="text" name="addr2" id="addr2" placeholder="상세주소 입력"/>
                            </td>
                        </tr>
                    </table>

                    <div>
                        <a href="/JBaord2/user/login.do" class="btn btnCancel">취소</a>
                        <input type="submit" value="회원가입" class="btn btnRegister"/>
                    </div>

                </form>

            </section>
        </main>
<jsp:include page="./_footer.jsp"/>