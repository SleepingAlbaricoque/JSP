package kr.co.farmstory2.dao;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.farmstory2.db.DBHelper;
import kr.co.farmstory2.db.SQL;
import kr.co.farmstory2.vo.ArticleVO;
import kr.co.farmstory2.vo.UserVO;

public class ArticleDAO extends DBHelper{
	private static ArticleDAO instance = new ArticleDAO();
	public static ArticleDAO getInstance() {
		return instance;
	}
	private ArticleDAO() {}
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	// insert
	public void insertArticle() {}
	
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
				article.setOriName(rs.getString(12));
				article.setDownload(rs.getInt(13));
			}
			
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
	
	// update
	public void updateArticle() {}
	
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
	
	// delete
	public void deleteArticle() {}
}
