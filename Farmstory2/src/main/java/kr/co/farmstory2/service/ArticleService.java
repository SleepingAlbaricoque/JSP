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
	public int selectCountTotal() {
		return dao.selectCountTotal();
	}
	
	// update
	public void updateArticle() {
		dao.updateArticle();
	}
	
	// delete
	public void deleteArticle() {
		dao.deleteArticle();
	}
	
	// list
	// 마지막 페이지 번호
	public int getLastPageNum(int total) {
		int lastPageNum =0;
		
		if(total % 10 == 0){
			lastPageNum = total /10;
		}else {
			lastPageNum = total /10 + 1;
		}
		return lastPageNum;
	}
	
	// 페이지 그룹 스타트, 엔드
	public void getPageGroupNum(int currentPage) {
		int currentPageGroup = (int) Math.ceil(currentPage /10);
		int pageGroupStart = (currentPageGroup -1)*10 + 1;
		int pageGroupEnd = currentPageGroup *10;
		
	
	}
}
