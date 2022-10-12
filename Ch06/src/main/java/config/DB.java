package config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DB {
	private static DB instance = new DB(); // 싱글턴 객체
	
	private DB() {}
	
	public static DB getInstance() {
		return instance;
	}
	
	private final String HOST = "jdbc:mysql://127.0.0.1:3306/college";
	private final String USER = "root";
	private final String PASS = "1234";
	
	public Connection getConnection() throws SQLException, ClassNotFoundException{
		Class.forName("com.mysql.cj.jdbc.Driver");
		return DriverManager.getConnection(HOST, USER, PASS);
	}
}
