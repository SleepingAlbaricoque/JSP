<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="beans.ProductBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="config.SQL"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="config.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	ProductBean pb = null;
	List<ProductBean> products = new ArrayList<>();

	try{
		Connection conn = DBCP.getConnection();
		PreparedStatement psmt = conn.prepareStatement(SQL.SELECT_PRODUCTS);
		ResultSet rs = psmt.executeQuery();
		
		while(rs.next()){
			pb = new ProductBean();
			pb.setProdNo(rs.getInt(1));
			pb.setProdName(rs.getString(2));
			pb.setStock(rs.getInt(3));
			pb.setPrice(rs.getInt(4));
			pb.setCompany(rs.getString(5));
			products.add(pb);
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
		<title>Shop::product</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
		<script>
			$(function(){
				$('.btnOrder').click(function(){
					let prodNo = $(this).val();
					
					$('section').show().find('input[name=prodNo]').val(prodNo);
					// section이 display:none이므로 일단 먼저 show하고, 버튼에 준 value 값(각 상품의 prodNo; 밑의 for문 참조)을 넣기
				});
				
				$('.btnClose').click(function(){
					$('section').hide();
				});
				
				$('#orderComplete').on('click', function(){
					let prodNo = $('input[name=prodNo]').val();
					let count = $('input[name=count]').val();
					let customer = $('input[name=customer]').val();
					
					let jsonData = {
							"prodNo": prodNo,
							"count": count,
							"customer": customer,
					};
					
					console.log('jsonData: ' + jsonData);
					
					$.ajax({
						url: './registerProc.jsp',
						type: 'post',
						data: jsonData, // 전송
						dataType: 'json', // 수신
						success:function(data){
							if(data.result == 1){
								alert('주문완료!');
							}else{
								alert('주문실패');
							}
						}
					});
				});
			});
</script>
	</head>
	<body>
		<h3>상품목록</h3>
		
		<a href="./customer.jsp">고객목록</a>
		<a href="./order.jsp">주문목록</a>
		
		<table border="1">
			<tr>
				<th>상품번호</th>
				<th>상품명</th>
				<th>재고량</th>
				<th>가격</th>
				<th>제조사</th>
				<th>주문</th>
			</tr>
			<% for(ProductBean product : products){ %>
			<tr>
				<td><%= product.getProdNo() %></td>
				<td><%= product.getProdName() %></td>
				<td><%= product.getStock() %></td>
				<td><%= product.getPrice() %></td>
				<td><%= product.getCompany() %></td>
				<td><button class="btnOrder" value="<%= product.getProdNo() %>">주문</button></td><!-- id값은 중복 불가 -->
			</tr>
			<% } %>
		</table>
		<section style="display:none">
			<h4>주문하기</h4>
				<table border="1">
					<tr>
						<td>상품번호</td>
						<td><input type="text" name="prodNo"></td>
					</tr>
					<tr>
						<td>수량</td>
						<td><input type="text" name="count"></td>
					</tr>
					<tr>
						<td>주문자</td>
						<td><input type="text" name="customer"></td>
					</tr>
					<tr>
						<td colspan="2" align="right"><input type="submit" value="주문하기" id="orderComplete"></td>
					</tr>
				</table>
				<button class="btnClose">닫기</button>
		</section>
	</body>
</html>