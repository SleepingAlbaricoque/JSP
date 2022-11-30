package kr.co.jboard2.db;

public class SQL {
	
	// USER
	public static final String INSERT_USER = "insert into `board_user` set " // registerProc
											+"`uid`=?,"
											+"`pass`=SHA2(?, 256),"
											+"`name`=?,"
											+"`nick`=?,"
											+"`email`=?,"
											+"`hp`=?,"
											+"`zip`=?,"
											+"`addr1`=?,"
											+"`addr2`=?,"
											+"`regip`=?,"
											+"`rdate`=NOW()";
	
	public static final String SELECT_USER = "select * from `board_user` where `uid`=? and `pass`=SHA2(?,256)"; // loginProc
	public static final String SELECT_COUNT_UID = "select count(`uid`) from `board_user` where `uid`=?"; // checkUid
	public static final String SELECT_COUNT_NICK = "select count(`nick`) from `board_user` where `nick`=?"; // checkNick
	public static final String SELECT_TERMS = "select * from `board_terms`"; // terms
	public static final String SELECT_USER_FOR_FIND_ID ="select `uid`, `name`, `email`, `rdate` from `board_user` where `name`=? and `email`=?";
	public static final String SELECT_USER_FOR_FIND_PW ="select count(`uid`) from `board_user` where `uid`=? and `email`=?";
	public static final String SELECT_USER_BY_SESSID ="select * from `board_user` where `sessId`=?";
	public static final String SELECT_USER_BY_PASS = "select count(`pass`) from `board_user` where `pass`=SHA2(?,256)";
	
	public static final String UPDATE_USER_PASSWORD = "update `board_user` set `pass`=SHA2(?, 256) where `uid`=? and `sessLimitDate` > NOW()";
	public static final String UPDATE_USER_FOR_SESSION = "update `board_user` set `sessId`=?, `sessLimitDate`=DATE_ADD(NOW(), INTERVAL 3 DAY) where `uid`=?";
	public static final String UPDATE_USER_FOR_SESSION_OUT= "update `board_user` set `sessId`=NULL, `sessLimitDate`=NULL where `uid`=?";
	public static final String UPDATE_USER = "update `board_user` set `name`=?, `nick`=?, `email`=?, `hp`=?, `zip`=?, `addr1`=?, `addr2`=? where `uid`=?";
	public static final String UPDATE_USER_PASS = "update `board_user` set `pass`=SHA2(?, 256) where `uid`=?";
	
	public static final String DELETE_USER= "update `board_user` set `grade`=0, `wdate`=NOW(), `sessId`=NULL, `sessLimitDate`=NULL where `uid`=?";
	
	// BOARD
	public static final String INSERT_ARTICLE = "insert into `board_article` set `title`=?, `content`=?, `file`=?, `uid`=?, `regip`=?, `rdate`=NOW()";
	public static final String INSERT_FILE = "insert into `board_file` set "
			+ "`parent`=?,"
			+ "`newName`=?,"
			+ "`oriName`=?,"
			+ "`rdate`=NOW()";
	public static final String INSERT_COMMENT = "insert into `board_article` set "
											  + "`parent`=?,"
											  + "`content`=?,"
											  + "`uid`=?,"
											  + "`regip`=?,"
											  + "`rdate`=NOW()";
	
	public static final String SELECT_MAX_NO = "select max(`no`) from `board_article`";
	public static final String SELECT_COUNT_TOTAL = "SELECT COUNT(`no`) FROM `board_article` where `parent`=0";
	public static final String SELECT_COUNT_TOTAL_FOR_SEARCH = "SELECT COUNT(`no`) FROM `board_article` as a "
															+ "join `board_user` as b "
															+ "on a.uid = b.uid "
															+ "where `parent`=0 and (`title` LIKE ? or `nick` LIKE ?)";
	public static final String SELECT_ARTICLES = "SELECT a.*, b.`nick` FROM `board_article` AS a "
			+ "JOIN `board_user` AS b ON a.uid = b.uid "
			+ "where `parent`=0 "
			+ "order by `no` DESC "
			+ "limit ?, 10";
	public static final String SELECT_ARTICLE = "SELECT *, b.fno, b.oriName, b.download "
											+ "FROM `board_article` AS a "
											+ "LEFT JOIN `board_file` AS b "
											+ "ON a.`no`=b.`parent` "
											+ "WHERE `no`=?";
	public static final String SELECT_FILE = "select * from `board_file` where `fno` =?";
	public static final String SELECT_FILE_WITH_PARENT = "select * from `board_file` where `parent` =?";
	public static final String SELECT_COMMENTS = "select a.*, b.nick from `board_article` as a "
											+ "join `board_user` as b "
											+ "on a.uid = b.uid "
											+ "where parent=? "
											+ "order by `no` ASC";
	public static final String SELECT_COMMENT_LATEST = "SELECT a.*, b.nick FROM `board_article` as a "
													+ "JOIN `board_user` AS b USING(`uid`) "
													+ "WHERE parent !=0 ORDER BY `no` DESC LIMIT 1";
	public static final String SELECT_ARTICLE_BY_KEYWORD = "SELECT a.`*`, b.nick FROM `board_article` AS a "
														+ "JOIN `board_user` AS b "
														+ "ON a.uid = b.uid "
														+ "WHERE `parent`=? AND (`title` LIKE ? OR `uid` LIKE ?) "
														+ "order by `no` desc "
														+ "limit ?, 10";
	
	public static final String UPDATE_ARTICLE_HIT = "UPDATE `board_article` SET `hit` = `hit` +1 WHERE `no` =?";
	public static final String UPDATE_ARTICLE_COMMENT = "update `board_article` set `comment` = `comment` + 1 where `no`=?";
	public static final String UPDATE_FILE_DOWNLOAD = "update `board_file` set `download` = `download` + 1 where `fno`=?";
	public static final String UPDATE_COMMENT = "update `board_article` set `content`=?, `rdate`=NOW() where `no`=?";
	public static final String UPDATE_ARTICLE = "update `board_article` set `title`=?, `content`=?, `rdate`=NOW() where `no`=?";
	
	public static final String DELETE_COMMENT = "delete from `board_article` where `no`=?";
	public static final String DELETE_ARTICLE = "delete from `board_article` where `no`=? or `parent`=?";
	public static final String DELETE_FILE = "delete from `board_file` where `parent`=?";
}
