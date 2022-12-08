package kr.co.farmstory2.dao;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.farmstory2.db.DBHelper;
import kr.co.farmstory2.db.SQL;
import kr.co.farmstory2.vo.ArticleVO;
import kr.co.farmstory2.vo.FileVO;
import kr.co.farmstory2.vo.UserVO;

public class ArticleDAO extends DBHelper{
	private static ArticleDAO instance = new ArticleDAO();
	public static ArticleDAO getInstance() {
		return instance;
	}
	private ArticleDAO() {}
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	// insert
	public int insertArticle(ArticleVO article) {
		int parent = 0;
		try {
			logger.info("insertArticle called");
			
			conn = getConnection();
			conn.setAutoCommit(false);
			
			stmt = conn.createStatement();
			psmt = conn.prepareStatement(SQL.INSERT_ARTICLE);
			psmt.setString(1, article.getCate());
			psmt.setString(2, article.getTitle());
			psmt.setString(3, article.getContent());
			psmt.setInt(4, article.getFname() == null? 0 : 1);
			psmt.setString(5, article.getUid());
			psmt.setString(6, article.getRegip());
			psmt.executeUpdate();
			
			rs = stmt.executeQuery(SQL.SELECT_MAX_NO);
			conn.commit();
			
			if(rs.next()) {
				parent = rs.getInt(1);
			}
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("parent " + parent);
		return parent;
	}
	
	public ArticleVO insertComment(String parent, String uid, String content, String regip) {
		ArticleVO comment = null;
		try {
			conn = getConnection();
			conn.setAutoCommit(false);
			
			psmt = conn.prepareStatement(SQL.INSERT_COMMENT);
			stmt = conn.createStatement();
			
			psmt.setString(1, parent);
			psmt.setString(2, content);
			psmt.setString(3, uid);
			psmt.setString(4, regip);
			psmt.executeUpdate();
			rs = stmt.executeQuery(SQL.SELECT_COMMENT_LATEST);
			
			conn.commit();
			
			if(rs.next()) {
				comment = new ArticleVO();
				comment.setNo(rs.getInt(1));
				comment.setParent(rs.getInt(2));
				comment.setContent(rs.getString(6));
				comment.setRdate(rs.getString(11).substring(2, 10));
				comment.setNick(rs.getString(12));
			}	
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("comment "+ comment);
		return comment;
	}
	
	public void insertFile(int parent, String newName, String fname) {
		try {
			logger.info("insertFile called");
			
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.INSERT_FILE);
			psmt.setInt(1, parent);
			psmt.setString(2, newName);
			psmt.setString(3, fname);
			psmt.executeUpdate();
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
	}
	
	// select
	public ArticleVO selectArticle(String no) {
		ArticleVO article = null;
		try {
			logger.info("selectArticle called");
			
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.SELECT_ARTICLE);
			psmt.setString(1, no);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				article = new ArticleVO();
				article.setTitle(rs.getString(5));
				article.setContent(rs.getString(6));
				article.setFile(rs.getInt(7));
				article.setUid(rs.getString(9));
				article.setOriName(rs.getString(12));
				article.setDownload(rs.getInt(13));
				article.setFno(rs.getInt(14));
			}
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("article " + article);
		return article;
	}
	
	public List<ArticleVO> selectArticles(int start, String cate) {
		List<ArticleVO> articles = new ArrayList<>();
		ArticleVO article = null;
		
		try{
			logger.info("selectArticles called");
			
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.SELECT_ARTICLES);
			psmt.setInt(2, start);
			psmt.setString(1, cate);
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				article = new ArticleVO();
				article.setNo(rs.getInt(1));
				article.setParent(rs.getInt(2));
				article.setComment(rs.getInt(3));
				article.setCate(rs.getString(4));
				article.setTitle(rs.getString(5));
				article.setContent(rs.getString(6));
				article.setFile(rs.getInt(7));
				article.setHit(rs.getInt(8));
				article.setUid(rs.getString(9));
				article.setRegip(rs.getString(10));
				article.setRdate(rs.getString(11).substring(2, 10));
				article.setNick(rs.getString(12));
				articles.add(article);
			}
			close();
					
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("articles " + articles);
		return articles;
	}
	
	public int selectCountTotal(String cate) {
		int total = 0;
		try {
			logger.info("selectCountTotal called");
			
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.SELECT_COUNT_TOTAL);
			psmt.setString(1, cate);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				total = rs.getInt(1);
			}
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("total " + total);
		return total;
	}
	public List<ArticleVO> selectComments(String no){
		List<ArticleVO> comments = new ArrayList<>();
		try {
			logger.info("selectComments called");
			
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.SELECT_COMMENTS);
			psmt.setString(1, no);
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				ArticleVO comment = new ArticleVO();
				comment.setNo(rs.getInt(1));
				comment.setContent(rs.getString(6));
				comment.setRdate(rs.getString(11).substring(2, 10));
				comment.setNick(rs.getString(12));
				comments.add(comment);
			}
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("comments " + comments);
		return comments;
	}
	
	public FileVO selectFile(String fno) {
		FileVO file = null;
		try {
			conn = getConnection();
			psmt = conn.prepareCall(SQL.SELECT_FILE);
			psmt.setString(1, fno);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				file = new FileVO();
				file.setFno(rs.getInt(1));
				file.setParent(rs.getInt(2));
				file.setNewName(rs.getString(3));
				file.setOriName(rs.getString(4));
				file.setDownload(rs.getInt(5));
				file.setRdate(rs.getString(6));
			}
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("file " + file);
		return file;
	}
	
	public List<ArticleVO> selectLatest(){
		List<ArticleVO> latestArticles = new ArrayList<>();
		try {
			logger.info("selectLatest called");
			
			conn = getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(SQL.SELECT_LATEST);
			
			while(rs.next()) {
				ArticleVO article = new ArticleVO();
				article.setNo(rs.getInt(1));
				article.setTitle(rs.getString(2));
				article.setRdate(rs.getString(3).substring(2, 10));
				latestArticles.add(article);
			}
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("latestArticles " + latestArticles);
		return latestArticles;
	}
	
	public List<ArticleVO> selectLatest(String cate){
		List<ArticleVO> latestArticles = new ArrayList<>();
		try {
			logger.info("selectLatestForTab called");
			
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.SELECT_LATEST_BY_CATE);
			psmt.setString(1, cate);
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				ArticleVO article = new ArticleVO();
				article.setNo(rs.getInt(1));
				article.setTitle(rs.getString(2));
				article.setRdate(rs.getString(3).substring(2, 10));
				latestArticles.add(article);
			}
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("latestArticles size: " + latestArticles.size());
		return latestArticles;
	}
	
	public List<ArticleVO> selectArticlesByKeyword(String cate, String searchOption, String search, int start){
		List<ArticleVO> articles = new ArrayList<>();
		try {
			logger.info("selectArticlesByKeyword called");
			
			conn = getConnection();
			if(searchOption.equals("title")) {
				psmt = conn.prepareStatement(SQL.SELECT_ARTICLES_BY_KEYWORD);
				psmt.setString(1, cate);
				psmt.setString(2, "%"+search+"%");
				psmt.setInt(3, start);
			}else {
				psmt = conn.prepareStatement(SQL.SELECT_ARTICLES_BY_NICK);
				psmt.setString(1, cate);
				psmt.setString(2, "%"+search+"%");
				psmt.setInt(3, start);
			}
			
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				ArticleVO article = new ArticleVO();
				article.setNo(rs.getInt(1));
				article.setParent(rs.getInt(2));
				article.setComment(rs.getInt(3));
				article.setCate(rs.getString(4));
				article.setTitle(rs.getString(5));
				article.setContent(rs.getString(6));
				article.setFile(rs.getInt(7));
				article.setHit(rs.getInt(8));
				article.setUid(rs.getString(9));
				article.setRegip(rs.getString(10));
				article.setRdate(rs.getString(11).substring(2, 10));
				article.setNick(rs.getString(12));
				articles.add(article);
			}
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("articles " + articles);
		return articles;
	}
	
	// update
	public void updateArticle(String title, String content, String no) {
		try {
			logger.info("updateArticle called");
			
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.UPDATE_ARTICLE);
			psmt.setString(1, title);
			psmt.setString(2, content);
			psmt.setString(3, no);
			psmt.executeUpdate();
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
	}
	
	public void updateArticleComment(String parent) {
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.UPDATE_ARTICLE_COMMENT);
			psmt.setString(1, parent);
			psmt.executeUpdate();
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
	}
	
	public void updateArticleHit(String no) {
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.UPDATE_ARTICLE_HIT);
			psmt.setString(1, no);
			psmt.executeUpdate();
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
	}
	
	public int updateComment(String content, String no) {
		int result = 0;
		try {
			logger.info("updateComment called");
			
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.UPDATE_COMMENT);
			psmt.setString(1, content);
			psmt.setString(2, no);
			result = psmt.executeUpdate();
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("result " + result);
		return result;
	}
	
	public void updateFileDownload(String fno) {
		try {
			logger.info("updateFileDownload called");
			
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.UPDATE_FILE_DOWNLOAD);
			psmt.setString(1, fno);
			psmt.executeUpdate();
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
	}
	
	public void updateFile(String no, String newName, String fname) {
		try {
			logger.info("updateFile called");
			
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.UPDATE_FILE);
			psmt.setString(1, newName);
			psmt.setString(2, fname);
			psmt.setString(3, no);
			psmt.executeUpdate();
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
	}
	
	public void updateArticleFile(String no) {
		try {
			logger.info("updateArticleFile called");
			
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.UPDATE_ARTICLE_FILE);
			psmt.setString(1, no);
			psmt.executeUpdate();
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
	}
	
	// delete
	public void deleteArticle(String no) {
		try {
			logger.info("deleteArticle called");
			
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.DELETE_ARTICLE);
			psmt.setString(1, no);
			psmt.executeUpdate();
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
	}
	
	public int deleteComment(String no) {
		int result = 0;
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.DELETE_COMMENT);
			psmt.setString(1, no);
			result = psmt.executeUpdate();
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("result " + result);
		return result;
	}
	
	public void deleteComments(String no) {
		try {
			logger.info("deleteComments called");
			
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.DELETE_COMMENTS);
			psmt.setString(1, no);
			psmt.executeUpdate();
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
	}
	
	public void deleteFile(String no) {
		try {
			logger.info("deleteFile called");
			
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.DELETE_FILE);
			psmt.setString(1, no);
			psmt.executeUpdate();
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
	}
}
