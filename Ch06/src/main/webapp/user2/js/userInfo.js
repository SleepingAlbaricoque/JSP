/**
 * 
 */
 function userInfo(){
	$(function(){
		$('nav').empty();
		$('#content').empty();
 		
		$('nav').append("<h4>user2 목록</h4>");
		$('nav').append("<a href='#' class='list'>user2 목록</a>");
		
		$.get('./json/modify.jsp', function(data){
			let tags  = "<table border ='1'>"; // 데이터 폼으로 전송하는 것이 아니라 폼태그 필요 x
						tags += "<tr>";
						tags += "<td>아이디</td>";
						tags += "<td><input type='text' name='uid' value='"+data.uid+"'></td>";
						tags += "</tr>";
						tags += "<tr>";
						tags += "<td>이름</td>";
						tags += "<td><input type='text' name='name' value='"+data.name+"''></td>";
						tags += "</tr>";
						tags += "<tr>";
						tags += "<td>휴대폰</td>";
						tags += "<td><input type='text' name='hp' value='"+data.hp+"'></td>";
						tags += "</tr>";
						tags += "<tr>";
						tags += "<td>나이</td>";
						tags += "<td><input type='text' name='age' value='"+data.age+"'></td>";
						tags += "</tr>";
						tags += "<tr>";
						tags += "<td colspan='2' align ='right'><input type='submit' value='등록'></td>";
						tags += "</tr>";
						tags += "</table>";
					$('#content').append(tags);
		});
	});
}