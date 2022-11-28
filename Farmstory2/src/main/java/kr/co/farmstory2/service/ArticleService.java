package kr.co.farmstory2.service;

import kr.co.farmstory2.dao.ArticleDAO;

public enum ArticleService {
	INSTANCE;
	private ArticleDAO dao;
	
	// insert
	public void insertArticle() {
		dao.insertArticle();
	}
	
	// select
	public void selectArticle() {
		dao.selectArticle();
	}
	public void selectArticles() {
		dao.selectArticles();
	}
	
	// update
	public void updateArticle() {
		dao.updateArticle();
	}
	
	// delete
	public void deleteArticle() {
		dao.deleteArticle();
	}
}
