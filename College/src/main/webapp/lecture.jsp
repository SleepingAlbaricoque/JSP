<%@page import="java.sql.ResultSet"%>
<%@page import="kr.co.college.db.SQL"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kr.co.college.db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.college.beans.LectureBean"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	LectureBean lb = null;
	List<LectureBean> lectures = new ArrayList<>();
	
	try{
		Connection conn = DBCP.getConnection();
		PreparedStatement psmt = conn.prepareStatement(SQL.SELECT_LECTURES);
		ResultSet rs = psmt.executeQuery();
		
		while(rs.next()){
			lb = new LectureBean();
			lb.setLecNo(rs.getInt(1));
			lb.setLecName(rs.getString(2));
			lb.setLecCredit(rs.getInt(3));
			lb.setLecTime(rs.getInt(4));
			lb.setLecClass(rs.getString(5));
			lectures.add(lb);
		}
		
		rs.close();
		psmt.close();
		conn.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>강좌관리</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
		<script>
			$(function(){
				$('.register').click(function(){
					$('section').show();
				});
				
				$('.btnClose').click(function(){
					$('section').hide();
				});
				
				$('#registerComplete').on('click', function(){
					let lecNo = $('input[name=lecNo]').val();
					let lecName = $('input[name=lecName]').val();
					let lecCredit = $('input[name=lecCredit]').val();
					let lecTime = $('input[name=lecTime]').val();
					let lecClass = $('input[name=lecClass]').val();
					
					let jsonData = {
							"lecNo": lecNo ,
							"lecName": lecName ,
							"lecCredit": lecCredit ,
							"lecTime": lecTime ,
							"lecClass": lecClass 
					};
					
					$.ajax({
						url: '/College/proc/lectureProc.jsp',
						type: 'post',
						data: jsonData,
						dataType: 'json',
						success:function(data){
							if(data.result == 1){
								alert('등록이 완료되었습니다');
							}
						}
					});
				});
			});
		</script>
	</head>
	<body>
		<h3>강좌관리</h3>
				
		<a href="./lecture.jsp">강좌관리</a>
		<a href="./register.jsp">수강관리</a>
		<a href="./student.jsp">학생관리</a>
		<br/>
		<h4>강좌현황</h4>
		<br/>
		<input type="button" value="등록" class="register">
		<table border="1">
			<tr>
				<th>번호</th>
				<th>강좌명</th>
				<th>학점</th>
				<th>시간</th>
				<th>강의장</th>
			</tr>
			<% for(LectureBean lecture : lectures){ %>
			<tr>
				<td><%= lecture.getLecNo() %></td>
				<td><%= lecture.getLecName() %></td>
				<td><%= lecture.getLecCredit() %></td>
				<td><%= lecture.getLecTime() %></td>
				<td><%= lecture.getLecClass() %></td>				
			</tr>
			<% } %>
		</table>
		<section style="display:none">
			<h4>강좌등록</h4>
			<br/>
			<input type="button" value="닫기" class="btnClose">
			<table border="1">
				<tr>
					<td>번호</td>
					<td><input type="text" name="lecNo"></td>
				</tr>
				<tr>
					<td>강좌명</td>
					<td><input type="text" name="lecName"></td>
				</tr>
				<tr>
					<td>학점</td>
					<td><input type="text" name="lecCredit"></td>
				</tr>
				<tr>
					<td>시간</td>
					<td><input type="text" name="lecTime"></td>
				</tr>
				<tr>
					<td>강의장</td>
					<td><input type="text" name="lecClass"></td>
				</tr>
				<tr>
					<td colspan="2" align="right"><input type="submit" value="추가" id="registerComplete">
				</tr>
			</table>
		</section>
	</body>
</html>