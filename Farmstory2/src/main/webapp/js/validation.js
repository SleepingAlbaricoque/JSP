/**
 * 
 */
 let regUid   = /^[a-z]+[a-z0-9]{4,19}$/g;
let regName  = /^[가-힣]{2,4}$/;
let regNick  = /^[가-힣a-zA-Z0-9]+$/;
let regEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
let regHp	 = /^\d{3}-\d{3,4}-\d{4}$/;
let regPass  = /^.*(?=^.{5,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;

let isUidOk = false;
let isPassOk = false;
let isNameOk = false;
let isNickOk = false;
let isEmailOk = false;
let isEmailAuthOk = false;
let receivedCode = 0;
let isEmailAuthCodeOk = false;
let isHpOk = false;

$(function(){
	// 아이디 중복 검사
	$('#btnCheckUid').click(function(){
		let uid = $('input[name=uid]').val();
		
		if(isUidOk){
			return;
		}
		
		if(!uid.match(regUid)){
			isUidOk = false;
			$('.uidResult').css('color', 'red').text('아이디가 유효하지 않습니다');
			return;
		}
		
		$.ajax({
			url: '/Farmstory2/user/checkUid.do',
			method: 'GET',
			data: {"uid":uid},
			dataType: 'json',
			success: function(data){
				if(data.result > 0){
					$('.uidResult').css('color', 'red').text('이미 사용중인 아이디입니다');
				}else{
					isUidOk = true;
					$('.uidResult').css('color', 'green').text('사용 가능한 아이디입니다');
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
				$('.pwResult').css('color', 'green').text('사용 가능한 패스워드입니다');
			}else{
				$('.pwResult').css('color', 'red').text('최소 다섯 자리 이상의 영문, 숫자, 특수문자 조합이어야 합니다');
			}
		}else{
			isPassOk = false;
			$('.pwResult').css('color', 'red').text('비밀번호가 일치하지 않습니다');
		}
	});
	
	// 이름 유효성 검사
	$('input[name=name]').focusout(function(){
		let name = $(this).val();
		
		if(name.match(regName)){
			isNameOk = true;
			$('.nameResult').css('color', 'green').text('사용 가능한 이름입니다');
		}else{
			$('.nameResult').css('color', 'red').text('이름은 한글 두 글자 이상이어야 합니다');
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
			$('.nickResult').css('color', 'red').text('별명이 유효하지 않습니다');
			return;
		}
		
		$.ajax({
			url: '/Farmstory2/user/checkNick.do',
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
		
		if(hp.match(regHp)){
			isHpOk = true;
			$('.hpResult').css('color', 'green').text('사용 가능한 번호입니다');
		}else{
			$('.hpResult').css('color', 'red').text('유효하지 않은 번호입니다');
		}
	});
	
	// 이메일 인증
	// 이메일 유효성 검사
	$('input[name=email]').focusout(function(){
		let email = $(this).val();
		
		if(email.match(regEmail)){
			isEmailOk = true;
			$('.emailResult').css('color', 'green').text('사용 가능한 이메일입니다');
		}else{
			$('.emailResult').css('color', 'red').text('유효하지 않은 이메일입니다');
		}
	});
	
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
	
	$('.register > form').submit(function(){
		if(!isUidOk){
			alert('아이디를 확인하십시오');
			return false;
		}
		if(!isPassOk){
			alert('비밀번호를 확인하십시오');
			return false;
		}
		if(!isNameOk){
			alert('이름을 확인하십시오');
			return false;
		}
		if(!isNickOk){
			alert('닉네임을 확인하십시오');
			return false;
		}
		if(!isEmailAuthCodeOk){
			alert('이메일을 확인하십시오');
			return false;
		}
		if(!isHpOk){
			alert('전화번호를 확인하십시오');
			return false;
		}
		return true;
	});
});