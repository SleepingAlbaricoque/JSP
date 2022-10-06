<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>3_반복문</title>
		<!-- 
			날짜 : 2022.10.04
			이름 : 조수빈
			내용 : JSP 스크립트릿 반복문 실습하기
		 -->
	</head>
	<body>
		<h3>반복문</h3>
		
		<h4>for</h4>
		<%
			for(int i = 1; i <=3; i++){
				out.println("<p>i : " + i + "</p>");
			}
		%>
		
		<!-- 표현식 -->
		<%
			for(int k= 1; k <=3; k++){
		%>
			<p>k : <%= k %></p>
		<%
			}
		%>
		
		<h4>while</h4>
		<%
			int k = 1;
		
			while(k <=5){
		%>
			<p>k: <%= k %></p>
		<%
				k++;
			}
		%>
		
		<h4>구구단</h4>
		<table border ="1">
			<tr>
				<th>2단</th>
				<th>3단</th>
				<th>4단</th>
				<th>5단</th>
				<th>6단</th>
				<th>7단</th>
				<th>8단</th>
				<th>9단</th>
			</tr>
			<tr>
				<td>2 x 1 = 2</td>
				<td>3 x 1 = 2</td>
				<td>4 x 1 = 2</td>
				<td>5 x 1 = 2</td>
				<td>6 x 1 = 2</td>
				<td>7 x 1 = 2</td>
				<td>8 x 1 = 2</td>
				<td>9 x 1 = 2</td>
			</tr>
			<% for(int i = 2; i <=9; i++) { %>
			<tr>
				<% for(int l = 2; l <=9; l++) { %>
				<td><%=l %> x <%= i %> = <%= i*l %></td>
				<% } %>
			</tr>
			<% } %>
		</table>
	</body>
</html>