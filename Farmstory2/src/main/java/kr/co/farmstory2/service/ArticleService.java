package kr.co.farmstory2.service;

import java.util.List;

import kr.co.farmstory2.dao.ArticleDAO;
import kr.co.farmstory2.vo.UserVO;

public enum ArticleService {
	INSTANCE;
	private ArticleDAO dao = ArticleDAO.getInstance();
	
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
