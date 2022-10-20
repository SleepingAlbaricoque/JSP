<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>user2 관리</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
		<script src='./js/list.js'></script>
		<script src='./js/register.js'></script>
		<script>
			$(function(){
				
				// 처음 user 목록 불러오기
				list(); // 반복적으로 등장하는 코드 블럭을 함수로 모듈화해 사용
				
				
				// user 목록보기
				$(document).on('click', '.list', function(e){ // 동적 이벤트 생성
					e.preventDefault();
					list();
				});
				
				// user 등록하는 틀 불러오기
				$(document).on('click', '.register', function(e){
					e.preventDefault();
					register();
				});
				
				// user 등록(submit)
				$(document).on('click', 'input[type=submit]', function(e){
					e.preventDefault();
					
					// 데이터 가져오기
					let uid = $('input[name=uid]').val();
					let name = $('input[name=name]').val();
					let hp = $('input[name=hp]').val();
					let age = $('input[name=age]').val();
					
					// json 데이터 생성
					let jsonData = {
						"uid": uid,
						"name": name,
						"hp": hp,
						"age": age
					};
					
					// 데이터 전송
					$.ajax({
						url: './json/register.jsp', //API
						type: 'post',
						data: jsonData,
						dataType: 'json',
						success: function(data){ // regsiter.jsp가 요청 처리하고 "result"값 반환
							alert('데이터 전송 성공');
						
							if(data.result ==1){
								alert('데이터 입력 성공');
							}else{ // result값은 0 아니면 1인데, DB에 정상적으로 데이터가 넣어진 경우에 1 반환; 0은 데이터값이 기존 primary key와 겹쳐서 등록안되는 경우 등에 해당
								alert('데이터 입력 실패');
							}
						}
					});
				});
			});
		</script>
	</head>
	<body>
		<h3>user2 관리자</h3>
		
		<nav></nav>
		<div id="content"></div>
	</body>
</html>