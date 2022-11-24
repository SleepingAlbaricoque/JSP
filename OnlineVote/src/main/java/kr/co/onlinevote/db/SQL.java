package kr.co.onlinevote.db;

public class SQL {
	// insert
	
	// select
	public static final String SELECT_VOTER = "select * from `registry` where `id`=? and `pass`=SHA2(?, 256)";
	
	// update
	
	// delete
}
