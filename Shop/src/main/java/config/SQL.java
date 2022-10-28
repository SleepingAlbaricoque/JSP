package config;

public class SQL {
	public static final String SELECT_CUSTOMERS = "select * from `customer`";
	
	public static final String SELECT_ORDERS ="select a.orderNo, a.orderCount, a.orderDate, b.name, c.prodName from `order` as a "
											+ "join `customer` as b on a.orderId = b.custId "
											+ "join `product` as c on a.orderProduct = c.prodNo";
	
	public static final String SELECT_PRODUCTS = "select * from `product`";
	
	public static final String INSERT_ORDER = "insert into `order` set `orderId`=?, `orderProduct`=?, `orderCount`=?, `orderDate`=NOW()";
}	
