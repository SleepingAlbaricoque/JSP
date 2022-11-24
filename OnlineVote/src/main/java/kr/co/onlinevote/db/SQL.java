package kr.co.onlinevote.db;

public class SQL {
	// insert
	public static final String INSERT_VOTER = "insert into `registry` set `name`=?, `birth`=?, `file`=?, `hp`=?, `rdate`=NOW(), `email`=?, `is_admin`=?, `id`=?, `password`=SHA2(?, 256)";
	public static final String INSERT_FILE = "insert into `file` set `regNo`=?, `newName`=?, `oriName`=?";
	
	// select
	public static final String SELECT_VOTER = "select * from `registry` where `id`=? and `password`=SHA2(?, 256)";
	public static final String SELECT_REGNO = "select `regNo` from `registry` where `id`=?";
	
	// update
	
	// delete
}
