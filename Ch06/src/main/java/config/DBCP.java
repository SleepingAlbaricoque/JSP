package config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class DBCP {
private static DBCP instance = new DBCP(); // 싱글턴 객체
	
	private DBCP() {}
	
	public static DBCP getInstance() {
		return instance;
	}
	
	private static DataSource ds = null;
	
	public static Connection getDBCP(String name) throws NamingException, SQLException{  // Servers > context.xml에서 설정한 커넥션 풀의 이름 넣기
		if(ds == null) {
			ds = (DataSource) new InitialContext().lookup("java:comp/env/"+name);
		}
		return ds.getConnection();
	}
}
