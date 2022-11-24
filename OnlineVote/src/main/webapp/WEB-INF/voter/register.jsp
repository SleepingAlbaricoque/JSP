<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Registration::Personal Information</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
	<script>
		// 이메일 인증 및 검증
		let regEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	
		let isEmailOk = false;
		let isEmailAuthOk = false;
		let receivedCode = 0;
		let isEmailAuthCodeOk = false;
		
		$(function(){
			$('.auth').hide();
			
			$('input[name=email]').focusout(function(){
				let email = $(this).val();
				
				if(!email.match(regEmail)){
					isEmailOk = false;
					$('.resultEmail').css('color', 'red').text('Invalid Email Address');
				}else{
					isEmailOk = true;
					$('.resultEmail').text('');
				}			
			});
			
			$('#btnEmail').click(function(){
				$(this).hide();
				let email = $('input[name=email]').val();
				console.log('here1');
				
				$('.emailResult').text('Authentification Code Sent\nPlease wait');
				
				setTimeout(function(){
					
					$.ajax({
						url: '/OnlineVote/voter/emailAuth.do',
						method: 'GET',
						data: {"email":email},
						dataType: 'json',
						success: function(data){
							if(data.status >0){
								isEmailAuthOk = true;
								$('.emailResult').text('Please check your inbox to get the code and enter it here');
								$('.auth').show();
								receivedCode = data.code;
								
							}else{
								isEmailAuthOk = false;
								alert('We have failed to send the code\nPlease try again');
								$(this).show();
							}
						}
					});
				}, 1000);
			});
			
			// 이메일 인증코드 확인 버튼
			$('#btnEmailConfirm').click(function(){
				let code = $('input[name=auth]').val();
				
				if(code == ''){
					alert('Please enter the code');
					return;
				}
				
				if(code == receivedCode){
					isEmailAuthCodeOk = true;
					$('input[name=email]').attr('readonly', true);
					$('.emailResult').text('Email verified');
					$('.auth').hide();
				}else{
					isEmailAuthCodeOk = false;
					alert('Not a valid code\nPlease try again');
				}
			});
			
			$('.register > form').submit(function(){
				if(!isEmailOk){
					alert('Please check the email address');
					return false;
				}
				
				if(!isEmailAuthCodeOk){
					alert('Please verify your email');
					return false;
				}
				
				return true;
			});
		});
	</script>
	</head>
	<body>
		<header></header>
		<main>
			<section class="register">
				<form action="/OnlineVote/voter/register.do" method="post" enctype="multipart/form-data">
					<table border="1">
						<tr>
							<td>Name</td>
							<td><input type="text" name="name" placeholder="Enter Name"></td>
						</tr>
						<tr>
							<td>Birth</td>
							<td><input type="text" name="birth" placeholder="Enter Date of Birth(YYYY/MM/DD)"></td>
						</tr>
						<tr>
							<td>File</td>
							<td><input type="file" name="fname" placeholder="Upload a Picture of Yourself"></td>
						</tr>
						<tr>
							<td>Mobile Number</td>
							<td><input type="text" name="hp" placeholder="Enter Mobile Number"></td>
						</tr>
						<tr>
							<td>Email</td>
							<td>
								<input type="text" name="email" placeholder="Enter Email"/>
								<span class="emailResult"></span>
								<button type="button" id="btnEmail">Get Authentification #</button>
								<div class="auth">
									<input type="text" name="auth" placeholder="Enter Code">
									<button type="button" id="btnEmailConfirm">Check</button>
								</div>
							</td>
						</tr>
						<tr>
							<td>ID</td>
							<td><input type="text" name="id" placeholder="Enter ID"></td>
						</tr>
						<tr>
							<td>Password</td>
							<td><input type="text" name="password" placeholder="Enter Password"></td>
						</tr>
					</table>
					<input type="submit" value="register">
				</form>
			</section>
		</main>
		<footer></footer>
	</body>
</html>