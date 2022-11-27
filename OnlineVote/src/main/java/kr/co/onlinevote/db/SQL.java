package kr.co.onlinevote.db;

public class SQL {
	// insert
	public static final String INSERT_VOTER = "insert into `registry` set `name`=?, `birth`=?, `file`=?, `hp`=?, `rdate`=NOW(), `email`=?, `is_admin`=?, `id`=?, `password`=SHA2(?, 256)";
	public static final String INSERT_FILE = "insert into `file` set `regNo`=?, `newName`=?, `oriName`=?";
	
	// select
	public static final String SELECT_VOTER = "select * from `registry` where `id`=? and `password`=SHA2(?, 256)";
	public static final String SELECT_VOTER_W_ID = "select `is_admin` from `registry` where `id`=?";
	public static final String SELECT_ADMIN = "select * from `registry` where `id`=? and `password`=SHA2(?, 256) and `is_admin`=1";
	public static final String SELECT_REGNO = "select `regNo` from `registry` where `id`=?";
	public static final String SELECT_VOTER_BY_SESSID = "select * from `registry` where `sessId`=?";
	
	// update
	public static final String UPDATE_VOTER_FOR_SESSION = "update `registry` set `sessId`=?, `sessLimitDate`=DATE_ADD(NOW(), INTERVAL 3 DAY) where `id`=?";
	public static final String UPDATE_VOTER_FOR_SESSION_OUT = "update `registry` set `sessId`=NULL, `sessLimitDate`=NULL where `id`=?";
	
	// delete
}
