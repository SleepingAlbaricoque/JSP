<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/user/_header.jsp"/>
<script src="/Farmstory2/js/validationWOuid.js"></script>
<script src="/Farmstory2/js/postcode.js"></script>
<script src="http://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	$(function(){
		let sessUser = '${sessUser}';
		if(sessUser == ''){
			alert('로그인 후 이용 가능합니다\n로그인 해 주세요');
			location.href="/Farmstory2/user/login.do";
		}
		
		$('#btnModifyPass').click(function(){
			let uid = $('input[name=uid]').val();
			let pass = $('input[name=pass2]').val();
			let modify = 1;
			
			$.ajax({
				url: '/Farmstory2/user/myInfo.do',
				method: 'POST',
				data: {"modify": 1, "uid":uid, "pass":pass},
				dataType: 'json',
				success: function(data){
					if(data.result > 0){
						alert('비밀번호가 정상적으로 변경되었습니다');
					}
				}
			});
		});
		
		$('#btnDeleteUser').click(function(){
			let uid = '${sessUser.uid}';
			
			let remove = confirm('정말로 탈퇴하시겠습니까?');
			console.log(remove);
			
			if(confirm){
				$.ajax({
					url: '/Farmstory2/user/deleteUser.do',
					method: 'POST',
					data: {"uid":uid},
					dataType: 'json',
					success: function(data){
						if(data.result > 0){
							alert('회원정보가 정상적으로 삭제되었습니다\n다시 로그인해주세요');
							location.href="/Farmstory2/index.jsp";
						}
					}
				});
			}
		});
	});
</script>
<main id="user">
    <section class="register">

        <form action="/Farmstory2/user/myInfo.do" method="post">
            <table border="1">
                <caption>회원정보 설정</caption>
                <input type="hidden" name="uid" value="${sessUser.uid}"/>
                <tr>
                    <td>아이디</td>
                    <td>
                        ${sessUser.uid}
                    </td>
                </tr>
                <tr>
                    <td>비밀번호</td>
                    <td><input type="password" name="pass1" placeholder="비밀번호 입력"/></td>
                </tr>
                <tr>
                    <td>비밀번호 확인</td>
                    <td><input type="password" name="pass2" placeholder="비밀번호 입력 확인"/><span class="pwResult"></span>
                    	<button type="button" id="btnModifyPass" style="padding:6px; background:blue; color:#fff;">비밀번호 수정</button>
                    </td>
                </tr>
                <tr>
                	<td>회원가입일</td>
                	<td>${sessUser.rdate}</td>
                </tr>
            </table>

            <table border="1">
                <caption>개인정보 수정</caption>
                <tr>
                    <td>이름</td>
                    <td>
                        <input type="text" name="name" value="${sessUser.name}"/>
                        <span class="nameResult"></span>                        
                    </td>
                </tr>
                <tr>
                    <td>별명</td>
                    <td>
                        <p class="nickInfo">공백없는 한글, 영문, 숫자 입력</p>
                        <input type="text" name="nick" value="${sessUser.nick}"/>
                        <button type="button" id="btnCheckNick"><img src="./img/chk_id.gif" alt="중복확인"/></button>
                        <span class="nickResult"></span>
                    </td>
                </tr>
                <tr>
                    <td>이메일</td>
                    <td>
                        
                        <input type="email" name="email" value="${sessUser.email}"/>
                        <span class="emailResult"></span>
                        <button type="button" id="btnEmail"><img src="./img/chk_auth.gif" alt="인증번호 받기"/></button>
                        <div class="auth">
                            <input type="text" name="auth" placeholder="인증번호 입력"/>
                            <button type="button" id="btnEmailConfirm"><img src="./img/chk_confirm.gif" alt="확인"/></button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>휴대폰</td>
                    <td><input type="text" name="hp" value="${sessUser.hp}"/></td>
                    <span class="hpResult"></span>
                </tr>
                <tr>
                    <td>주소</td>
                    <td>
                        <input type="text" name="zip" id="zip" value="${sessUser.zip}"/>
                        <button type="button" onclick="postcode()"><img src="./img/chk_post.gif" alt="우편번호찾기"/></button>
                        <input type="text" name="addr1" id="addr1" value="${sessUser.addr1}"/>
                        <input type="text" name="addr2" id="addr2" value="${sessUser.addr2}"/>
                    </td>
                </tr>
                <tr>
                	<td>회원탈퇴</td>
                	<td>
                		<button type="button" id="btnDeleteUser" style="padding:6px; background:#ed2f2f; color:#fff;">회원탈퇴</button>
                	</td>
                </tr>
            </table>

            <div>
                <a href="/Farmstory2/user/login.do" class="btn btnCancel">취소</a>
                <input type="submit" value="회원수정" class="btn btnRegister"/>
            </div>

        </form>

    </section>
</main>
<jsp:include page="/WEB-INF/_footer.jsp"/>