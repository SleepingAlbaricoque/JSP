<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./_header.jsp" %>

<script>
	// 데이터 검증에 사용할 정규표현식(자바스크립트 정규표현식이라고 구글링하면 나옴)
	var regEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i; // 이메일
	var regHp = /^\d{3}-\d{3,4}-\d{4}$/; // 휴대폰
	var regPass = /^.*(?=^.{5,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/; // 비밀번호; 특문, 문자, 숫자 모두 포함
	
	// 폼 데이터 검증 결과 상태변수
	let isUidOk = false;
	let isPassOk = false;
	let isNameOk = false;
	let isNickOk = false;
	let isEmailOk = false;
	let isHpOk = false;

	$(function(){
		
		// 비밀번호 일치 여부 확인
		$('input[name=pass2]').focusout(function(){ // 커서가 해당 지시자가 가리키는 곳을 벗어나거나 tab키로 벗어나면 실행됨
			
			let pass1 = $('input[name=pass1]').val(); // 해당 지시자가 가리키는 곳의 value 가져옴
			let pass2 = $(this).val();
			
			if(pass1 == pass2){ // javascript에서는 스트링도 == 비교 가능
				// 비밀번호 특수문자 포함 여부(비밀번호가 최소 5자 이상 15자 이하, 영문, 숫자, 특수문자 조합이어야 함)
				if(regPass.test(pass2)){ // 조건을 정규표현식으로 표현(Java에도 있는 표현); test()함수에 pass2값을 넣어서 이 값이 해당 정규표현식을 충족하는 지 확인
					isPassOk = true;
					$('.resultPass').css('color', 'green').text('비밀번호가 일치합니다.');
				}else{
					isPassOk= false;
					$('.resultPass').css('color', 'red').text('영문, 숫자, 특수문자 조합 최소 5자 이상 15자 이하');
				}
				
			}else{
				isPassOk = false;
				$('.resultPass').css('color', 'red').text('비밀번호가 일치하지 않습니다');
			}
		});
		
		// 폼 전송이 시작될 때 실행되는 폼 이벤트(폼 전송 버튼을 클릭했을 때)
		$('.register > form').submit(function(){
			////////////////////////////////
			// 폼 데이터 유효성 검증(validation)
			////////////////////////////////
			// 아이디 검증
			
			// 비밀번호 검증
			
			
			// 이름 검증
			// 별명 검증
			// 이메일 검증
			// 휴대폰 검증
			return false;
		});
		
	});
</script>

  <main id="user" class="register">

      <form action="/JBoard1/user/proc/registerProc.jsp" method="post">
      <table border="1">
          <caption>사이트 이용정보 입력</caption>
          <tr>
              <th>아이디</th>
              <td>
                  <input type="text" name="uid" placeholder="아이디 입력">
                  <button type="button"><img src="/JBoard1/img/chk_id.gif" alt="중복확인"></button> <!--button은 원래 submit과 동일한 기능; type을 버튼으로 바꾸어주어야 데이터 전송하지 않음-->
                  <span class="resultUid"></span>
              </td>
          </tr>
          <tr>
              <th>비밀번호</th>
              <td>
                  <input type="password" name="pass1" placeholder="비밀번호 입력">
                  <span class="resultPass"></span>
              </td>
          </tr>
          <tr>
              <th>비밀번호 확인</th>
              <td>
                  <input type="password" name="pass2" placeholder="비밀번호 확인 입력">
              </td>
          </tr>
      </table>

      <table border="1">
          <caption>개인정보 입력</caption>
          <tr>
              <th>이름</th>
              <td>
                  <input type="text" name="name" placeholder="이름 입력">
              </td>
          </tr>
          <tr>
              <th>별명</th>
              <td>
                  <p>공백 없이 한글, 영문, 숫자 입력</p>
                  <input type="text" name="nick" placeholder="별명 입력">
                  <button type="button"><img src="/JBoard1/img/chk_id.gif" alt="중복확인"></button>
                  <span class="resultNick"></span>
              </td>
          </tr>
          <tr>
              <th>이메일</th>
              <td>
                  <input type="email" name="email" placeholder="이메일 입력">
              </td>
          </tr>
          <tr>
              <th>휴대폰</th>
              <td>
                  <input type="text" name="hp" placeholder="- 포함 13자리 입력">
              </td>
          </tr>
          <tr>
              <th>주소</th>
              <td>
                  <input type="text" name="zip" placeholder="우편번호 검색" readonly>
                  <button type="button"><img src="/JBoard1/img/chk_post.gif" alt="우편번호 찾기"></button>
                  <input type="text" name="addr1" placeholder="기본주소 검색" readonly>
                  <input type="text" name="addr2" placeholder="상세주소 입력">
              </td>
          </tr>
      </table>

      <div>
          <a href="/JBoard1/user/login.jsp" class="btnCancel">취소</a>
          <input type="submit" class="btnRegister" value="회원가입">
      </div>
      </form>

  </main>
<%@ include file="./_footer.jsp" %>