package kr.co.farmstory2.db;

public class SQL {
	// user
		// insert
		public static final String INSERT_USER = "insert into `board_user` set " 
												+"`uid`=?,"
												+"`pass`=SHA2(?, 256),"
												+"`name`=?,"
												+"`nick`=?,"
												+"`email`=?,"
												+"`hp`=?,"
												+"`grade`=?,"
												+"`zip`=?,"
												+"`addr1`=?,"
												+"`addr2`=?,"
												+"`regip`=?,"
												+"`rdate`=NOW(),"
												+"`sessId`=NULL,"
												+"`sessLimitDate`=NULL";
	
		
		// select
		public static final String SELECT_TERMS = "select * from `board_terms`";
		public static final String SELECT_COUNT_UID = "select count(`uid`) from `board_user` where `uid`=?";
		public static final String SELECT_COUNT_NICK = "select count(`nick`) from `board_user` where `nick`=?";
		public static final String SELECT_USER = "select * from `board_user` where `uid`=? and `pass`=SHA2(?,256)";
		
		// update
		public static final String UPDATE_USER_FOR_SESSION = "update `board_user` set `sessId`=?, `sessLimitDate`=DATE_ADD(NOW(), INTERVAL 3 DAY) where `uid`=?";
		public static final String UPDATE_USER_FOR_SESSION_OUT = "update `board_user` set `sessId`=NULL, `sessLimitDate`=NULL where `uid`=?";
		
		// delete
	
	// board
		// insert
		// select
		// update
		// delete
}
