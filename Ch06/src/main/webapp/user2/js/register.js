/**
 * 
 */
 function register(){
	
	$(function(){
		$('nav').empty();
					$('#content').empty(); // 현재 보이는 목록 화면을 비움
					
					$('nav').append("<h4>user2 등록</h4>");
					$('nav').append("<a href='#' class='list'>user2 목록</a>");
					
					let tags  = "<table border ='1'>"; // 데이터 폼으로 전송하는 것이 아니라 폼태그 필요 x
						tags += "<tr>";
						tags += "<td>아이디</td>";
						tags += "<td><input type='text' name='uid' placeholder='아이디 입력'></td>";
						tags += "</tr>";
						tags += "<tr>";
						tags += "<td>이름</td>";
						tags += "<td><input type='text' name='name' placeholder='이름 입력'></td>";
						tags += "</tr>";
						tags += "<tr>";
						tags += "<td>휴대폰</td>";
						tags += "<td><input type='text' name='hp' placeholder='휴대폰 입력'></td>";
						tags += "</tr>";
						tags += "<tr>";
						tags += "<td>나이</td>";
						tags += "<td><input type='text' name='age' placeholder='나이 입력'></td>";
						tags += "</tr>";
						tags += "<tr>";
						tags += "<td colspan='2' align ='right'><input type='submit' value='등록'></td>";
						tags += "</tr>";
						tags += "</table>";
					$('#content').append(tags);
	});
}