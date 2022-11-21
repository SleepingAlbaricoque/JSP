<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="./_header.jsp"/>
<script>
	$(function(){
		$('.btnNext').click(function(){
			
			alert('22');
			let isCheckedTerms = $('input[class=terms]').is(':checked');
			let isCheckedPrivacy = $('input[class=privacy]').is(':checked');
			
			if(isCheckedTerms && isCheckedPrivacy){
				return true;
			}else{
				alert('모두 동의하셔야 다음으로 진행할 수 있습니다');
				return false;
			}
		});
	});
</script>
        <main id="user">
            <section class="terms">
                <table border="1">
                    <caption>사이트 이용약관</caption>
                    <tr>
                        <td>
                            <textarea name="terms">${requestScope.vo.terms}</textarea>
                            <label><input type="checkbox" class="terms">&nbsp;동의합니다.</label>
                        </td>
                    </tr>
                </table>

                <table border="1">
                    <caption>개인정보 취급방침</caption>
                    <tr>
                        <td>
                            <textarea name="privacy">${vo.privacy}</textarea>
                            <label><input type="checkbox" class="privacy">&nbsp;동의합니다.</label>
                        </td>
                    </tr>
                </table>
                
                <div>
                    <a href="/JBoard2/user/login.do" class="btn btnCancel">취소</a>
                    <a href="/JBoard2/user/register.do" class="btn btnNext">다음</a>
                </div>

            </section>
        </main>
<jsp:include page="./_footer.jsp"/>