<%@page import="java.util.List"%>
<%@page import="kr.co.jboard1.dao.UserDAO"%>
<%@page import="kr.co.jboard1.db.SQL"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="kr.co.jboard1.db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./_header.jsp" %>
<script>
	$(function(){
		$('.next').click(function(){
			
			let isChecked1 = $('input[class=terms]').is(':checked');
			let isChecked2 = $('input[class=privacy]').is(':checked');
			
			if(isChecked1 && isChecked2){
				return true;
			}else{
				alert('동의 체크를 하셔야 다음으로 진행할 수 있습니다');
				return false;
			}
		});
	});
</script>
<%
	List<String> info = UserDAO.getInstance().selectTerms();
	String terms = info.get(0);
	String privacy = info.get(1);
%>
        <main id="user" class="terms">
            <table border="0">
                <caption>사이트 이용약관</caption>
                <tr>
                    <td>
                        <textarea class="terms" readonly><%= terms %></textarea>
                        <label><input type="checkbox" class="terms">&nbsp;동의합니다.</label>
                    </td>
                </tr>
            </table>
            <table border="0">
                <caption>개인정보 취급방침</caption>
                <tr>
                    <td>
                        <textarea class="privacy" readonly><%= privacy %></textarea>
                        <label><input type="checkbox" class="privacy">&nbsp;동의합니다.</label>
                    </td>
                </tr>
            </table>
            
            <p>
                <a href="/JBoard1/user/login.jsp" class="cancel">취소</a>
                <a href="/JBoard1/user/register.jsp" class="next">다음</a>
            </p>
        </main>
<%@ include file="./_footer.jsp" %>