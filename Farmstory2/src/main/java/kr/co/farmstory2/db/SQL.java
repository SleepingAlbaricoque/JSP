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
		public static final String SELECT_USER_BY_SESSID = "select * from `board_user` where `sessId`=?";
		public static final String SELECT_USER_FOR_FIND_ID = "select * from `board_user` where `name`=? and `email`=?";
		public static final String SELECT_USER_FOR_FIND_PW = "select count(`pass`) from `board_user` where `uid`=? and `email`=?";
		
		// update
		public static final String UPDATE_USER_FOR_SESSION = "update `board_user` set `sessId`=?, `sessLimitDate`=DATE_ADD(NOW(), INTERVAL 3 DAY) where `uid`=?";
		public static final String UPDATE_USER_FOR_SESSION_OUT = "update `board_user` set `sessId`=NULL, `sessLimitDate`=NULL where `uid`=?";
		public static final String UPDATE_PASS = "update `board_user` set `pass`=SHA2(?, 256) where `uid`=?";
		public static final String UPDATE_USER = "update `board_user` set `name`=?, `nick`=?, `email`=?, `hp`=?, `zip`=?, `addr1`=?, `addr2`=? where `uid`=?";
		
		// delete
		public static final String DELETE_USER = "update `board_user` set `grade`=5, `sessId`=NULL, `sessLimitDate`=NULL, `wdate`=NOW() where `uid`=?";
	
	// board
		// insert
		public static final String INSERT_COMMENT = "insert into `board_article` set `parent`=?, `content`=?, `uid`=?, `regip`=?, `rdate`=NOW()";
		public static final String INSERT_ARTICLE = "insert into `board_article` set `cate`=?, `title`=?, `content`=?, `file`=?, `uid`=?, `regip`=?, `rdate`=NOW()";
		public static final String INSERT_FILE = "insert into `board_file` set `parent`=?, `newName`=?, `oriName`=?, `rdate`=NOW()";
		
		// select
		public static final String SELECT_COUNT_TOTAL = "select count(`no`) from `board_article` where `parent`=0 and `cate`=?";
		public static final String SELECT_ARTICLES = "select a.*, b.`nick` from `board_article` as a "
													+ "join `board_user` as b on a.uid = b.uid "
													+ "where `parent` = 0 and `cate` =? "
													+ "order by `no` DESC "
													+ "limit ?, 10";
		public static final String SELECT_ARTICLE = "select a.*, b.`oriName`, b.`download`, b.`fno` from `board_article` as a "
													+ "left join `board_file` as b on a.no = b.parent "
													+ "where `no`=?";
		public static final String SELECT_COMMENTS = "select a.*, b.`nick` from `board_article` as a "
													+ "join `board_user` as b on a.uid = b.uid "
													+ "where `parent`=? order by `no` asc";
		public static final String SELECT_COMMENT_LATEST = "select a.*, b.`nick` from `board_article` as a "
														+ "join `board_user` as b on a.uid = b.uid "
														+ "where `parent`!=0 order by `no` desc limit 1";
		public static final String SELECT_MAX_NO = "select max(`no`) from `board_article`";
		public static final String SELECT_FILE = "select * from `board_file` where `fno`=?";
		public static final String SELECT_LATEST = "(SELECT `no`, `title`, `rdate` FROM `board_article` WHERE `cate`='grow' ORDER BY `no` DESC LIMIT 5) "
												+ "UNION "
												+ "(SELECT `no`, `title`, `rdate` FROM `board_article` WHERE `cate`='school' ORDER BY `no` DESC LIMIT 5) "
												+ "UNION "
												+ "(SELECT `no`, `title`, `rdate` FROM `board_article` WHERE `cate`='story' ORDER BY `no` DESC LIMIT 5)";
		public static final String SELECT_LATEST_BY_CATE = "select `no`, `title`, `rdate` from `board_article` where `cate`=? order by `no` desc limit 3";
		public static final String SELECT_ARTICLES_BY_KEYWORD = "SELECT a.*, b.nick FROM `board_article` AS a "
															+ "JOIN `board_user` AS b "
															+ "ON a.uid = b.uid "
															+ "WHERE `parent`=0 AND `cate`=? and `title` like ? "
															+ "order by `no` desc "
															+ "limit ?, 10";
		public static final String SELECT_ARTICLES_BY_NICK = "SELECT a.*, b.nick FROM `board_article` AS a "
															+ "JOIN `board_user` AS b "
															+ "ON a.uid = b.uid "
															+ "WHERE `parent`=0 AND `cate`=? and `nick` like ? "
															+ "order by `no` desc "
															+ "limit ?, 10";
		
		// update
		public static final String UPDATE_ARTICLE_COMMENT = "update `board_article` set `comment` = `comment` +1 where `no`=?";
		public static final String UPDATE_ARTICLE_HIT = "update `board_article` set `hit` = `hit` + 1 where `no`=?";
		public static final String UPDATE_COMMENT = "update `board_article` set `content`=?, rdate=NOW() where `no`=?";
		public static final String UPDATE_FILE_DOWNLOAD = "update `board_file` set `download` = `download` + 1 where `fno`=?";
		public static final String UPDATE_FILE = "update `board_file` set `newName`=?, `oriName`=?, `rdate`=NOW() where `parent`=?";
		public static final String UPDATE_ARTICLE = "update `board_article` set `title`=?, `content`=? where `no`=?";
		public static final String UPDATE_ARTICLE_FILE = "update `board_article` set `file`=1 where `no`=?";
		
		// delete
		public static final String DELETE_COMMENT = "delete from `board_article` where `no`=?";
		public static final String DELETE_COMMENTS = "delete from `board_article` where `parent`=?";
		public static final String DELETE_FILE = "delete from `board_file` where `parent`=?";
		public static final String DELETE_ARTICLE = "delete from `board_article` where `no`=?";
}
