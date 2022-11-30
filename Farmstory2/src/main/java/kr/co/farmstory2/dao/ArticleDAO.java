package kr.co.farmstory2.dao;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.farmstory2.db.DBHelper;
import kr.co.farmstory2.db.SQL;
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
	
	// select
	public void selectArticle() {}
	
	public void selectArticles() {}
	
	public int selectCountTotal() {
		int total = 0;
		try {
			logger.info("selectCountTotal called");
			
			conn = getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(SQL.SELECT_COUNT_TOTAL);
			
			if(rs.next()) {
				total = rs.getInt(1);
			}
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("total " + total);
		return total;
	}
	
	// update
	public void updateArticle() {}
	
	// delete
	public void deleteArticle() {}
}
