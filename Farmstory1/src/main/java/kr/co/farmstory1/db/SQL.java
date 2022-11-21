package kr.co.farmstory1.db;

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
	
	// BOARD
	public static final String INSERT_ARTICLE = "insert into `board_article` set `cate`=?, `title`=?, `content`=?, `file`=?, `uid`=?, `regip`=?, `rdate`=NOW()";
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
	public static final String SELECT_COUNT_TOTAL = "SELECT COUNT(`no`) FROM `board_article` where `parent`=0 and `cate`=?";
	public static final String SELECT_ARTICLES = "SELECT a.*, b.`nick` FROM `board_article` AS a "
			+ "JOIN `board_user` AS b ON a.uid = b.uid "
			+ "where `parent`=0 and `cate`=? "
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
	public static final String SELECT_COMMENT = "select `parent` from `board_article` where `no`=?";
	public static final String SELECT_LATESTS = "(SELECT `no`, `title`, `rdate` FROM `board_article` WHERE `cate`='grow' ORDER BY `no` DESC LIMIT 5) "
												+ "UNION "
												+ "(SELECT `no`, `title`, `rdate` FROM `board_article` WHERE `cate`='school' ORDER BY `no` DESC LIMIT 5) "
												+ "UNION "
												+ "(SELECT `no`, `title`, `rdate` FROM `board_article` WHERE `cate`='story' ORDER BY `no` DESC LIMIT 5)";
	public static final String SELECT_LATEST = "SELECT `no`, `title`, `rdate` FROM `board_article` WHERE `cate`=? ORDER BY `no` DESC LIMIT 3";
	
	public static final String UPDATE_ARTICLE_HIT = "UPDATE `board_article` SET `hit` = `hit` +1 WHERE `no` =?";
	public static final String UPDATE_ARTICLE_COMMENT = "update `board_article` set `comment` = `comment` + 1 where `no`=?";
	public static final String UPDATE_FILE_DOWNLOAD = "update `board_file` set `download` = `download` + 1 where `fno`=?";
	public static final String UPDATE_COMMENT = "update `board_article` set `content`=?, `rdate`=NOW() where `no`=?";
	public static final String UPDATE_ARTICLE = "update `board_article` set `title`=?, `content`=?, `rdate`=NOW() where `no`=?";
	public static final String UPDATE_FILE = "update `board_file` set `newName`=?, `oriName`=?, `rdate`=NOW() where `parent`=?";
	public static final String UPDATE_ARTICLE_FILE = "update `board_article` set `file` =1 where `no`=?";
	public static final String UPDATE_COMMENT_COUNTER ="update `board_article` set `comment` = `comment` -1 where `no`=?";
	
	public static final String DELETE_COMMENT = "delete from `board_article` where `no`=?";
	public static final String DELETE_ARTICLE = "delete from `board_article` where `no`=? or `parent`=?";
	public static final String DELETE_FILE = "delete from `board_file` where `parent`=?";
}
