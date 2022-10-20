/**
 * 
 */
 // user2 목록 불러오기
function list(){ // 함수로 모듈화
 	$(function(){ // 방금 만든 함수 list()는 자바스크립트지만 안의 문법은 jQuerry이기 때문에 jQuerry를 시작하는 $(function(){})을 시작에 적어야 함
 		$('nav').empty();
		$('#content').empty();
 		
		$('nav').append("<h4>user2 목록</h4>");
		$('nav').append("<a href='#' class='register'>user2 등록</a>");
		
		$.get('./json/users.jsp', function(data){
			
			let tableTag  = "<table border='1'>";
				tableTag += "<tr>";
				tableTag += "<th>아이디</th>";
				tableTag += "<th>이름</th>";
				tableTag += "<th>휴대폰</th>";
				tableTag += "<th>나이</th>";
				tableTag += "<th>관리</th>";
				tableTag += "</tr>";
				tableTag += "</table>";
			
			$('#content').append(tableTag);
			
			for(let user of data){
				let tags = "<tr>";
					tags += "<td>"+user.uid+"</td>";
					tags += "<td>"+user.name+"</td>";
					tags += "<td>"+user.hp+"</td>";
					tags += "<td>"+user.age+"</td>";
					tags += "<td>"
					tags += "<a href ='#' class='modify'>수정</a>"
					tags += "<a href ='#'>삭제</a>"
					tags += "</td>";
					tags +="</tr>"; 
					
				$('#content > table').append(tags);
			}
			
		});
	});
}