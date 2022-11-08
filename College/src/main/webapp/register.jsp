<%@page import="java.sql.ResultSet"%>
<%@page import="kr.co.college.db.SQL"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kr.co.college.db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.college.beans.RegisterBean"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>수강관리</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
		<script>
			$(function(){
				$('.register').click(function(){
					$('section').show();
				});
				
				$('.btnClose').click(function(){
					$('section').hide();
				});
				
				$('.search').on('click', function(){
					let name = $('input[name=name]').val();
					
					let jsonData = {
							"name": name
					};
					
					$.ajax({
						url: '/College/proc/registerProc.jsp',
						type: 'post',
						data: jsonData,
						dataType: 'json',
						success:function(data){
							let obj = JSON.parse(data);
							
							console.log("obj", obj);
							
							for(let i =0; i < data.length; i++){
							let result = "<tr>";
								result += "<td>"+obj[i].regStdNo+"</td>";
								result += "<td>"+obj[i].regStdName+"</td>";
								result += "<td>"+obj[i].regLecName+"</td>";
								result += "<td>"+obj[i].regLecNo+"</td>";
								result += "<td>"+obj[i].regMidScore+"</td>";
								result += "<td>"+obj[i].regFinalScore+"</td>";
								result += "<td>"+obj[i].regTotalScore+"</td>";
								result += "<td>"+obj[i].regRegGrade+"</td>";
								result += "</tr>"
							}
							
							$('.result').append();
						}
					});
				});
				
				$('#registerComplete').on('click', function(){
					let regStdNo = $('input[name=regStdNo]').val();
					let regStdName = $('input[name=regStdName]').val();
					let regLecName = $('select[name=regLecName]').val();
					
					let jsonData = {
							"regStdNo": regStdNo,
							"regStdName": regStdName,
							"regLecName": regLecName
					};
					
					$.ajax({
						url: '/College/proc/registerProc.jsp',
						type: 'post',
						data: jsonData,
						dataType: 'json',
						success:function(data){
							alert('성공');
						
						}
				});
			});
		</script>
	</head>
	<body>
		<h3>수강관리</h3>
		<br>
		<a href="./lecture.jsp">강좌관리</a>
		<a href="./register.jsp">수강관리</a>
		<a href="./student.jsp">학생관리</a>
		<br>
		<h4>수강현황</h4>
		
		<input type="text" name="name">
		<input type="submit" value="검색" class="search">
		<input type="button" value="수강신청" class="register">
		<table border="1" class="result">
			<tr>
				<th>학번</th>
				<th>이름</th>
				<th>강좌명</th>
				<th>강좌코드</th>
				<th>중간시험</th>
				<th>기말시험</th>
				<th>총점</th>
				<th>등급</th>
			</tr>
		</table>
		<section style="display:none">
		<h4>수강신청</h4>
		<input type="button" value="닫기" class="btnClose">
		<table border="1">
			<tr>
				<td>학번</td>
				<td><input type="text" name="regStdNo"></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><input type="text" name="stdName"></td>
			</tr>
			<tr>
				<td>신청강좌</td>
				<td>
					<select name="regLecName">
						<option value=""></option>
					</select>
				</td>	
			</tr>
			<tr>
				<td colspan="2" align="right"><input type="submit" value="신청" id="registerComplete"></td>
			</tr>
		</table>
		</section>
	</body>
</html>