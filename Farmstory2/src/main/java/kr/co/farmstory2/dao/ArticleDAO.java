package kr.co.farmstory2.dao;

import kr.co.farmstory2.db.DBHelper;

public class ArticleDAO extends DBHelper{
	private static ArticleDAO instance = new ArticleDAO();
	public static ArticleDAO getInstance() {
		return instance;
	}
	private ArticleDAO() {}
	
	public void insertArticle() {}
	public void selectArticle() {}
	public void selectArticles() {}
	public void updateArticle() {}
	public void deleteArticle() {}
}
