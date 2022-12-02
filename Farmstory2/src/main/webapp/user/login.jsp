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
<script>
	let success = ${success};
	if(success == '100'){
		alert('일치하는 회원 정보가 없습니다');
	}else if(success == '201'){
		alert('정상적으로 로그아웃 되었습니다');
	}else if(success == '101'){
		alert('로그인 후 이용 가능합니다');
	}else if(success == '111'){
		alert('이미 탈퇴한 회원입니다\n 다시 회원가입을 진행해 주세요');
	}
</script>
        <main id="user">
            <section class="login">
                <form action="/Farmstory2/user/login.do" method="post">
                    <table border="0">
                        <tr>
                            <td><img src="/Farmstory2/user/img/login_ico_id.png" alt="아이디"/></td>
                            <td><input type="text" name="uid" placeholder="아이디 입력"/></td>
                        </tr>
                        <tr>
                            <td><img src="/Farmstory2/user/img/login_ico_pw.png" alt="비밀번호"/></td>
                            <td><input type="password" name="pass" placeholder="비밀번호 입력"/></td>
                        </tr>
                    </table>
                    <input type="submit" value="로그인" class="btnLogin"/>
                    <label><input type="checkbox" name="auto">아이디 기억하기</label>
                </form>
                <div>
                    <h3>회원 로그인 안내</h3>
                    <p>
                        아직 회원이 아니시면 회원으로 가입하세요.
                    </p>
                    <div style="text-align: right;">
                        <a href="/Farmstory2/user/findId.do">아이디 |</a>
                        <a href="/Farmstory2/user/findPw.do">비밀번호찾기 |</a>
                        <a href="/Farmstory2/user/terms.do">회원가입</a>
                    </div>                    
                </div>
            </section>
        </main>
<jsp:include page="/WEB-INF/_footer.jsp"/>