package kr.co.farmstory2.service;

import java.util.List;

import kr.co.farmstory2.dao.ArticleDAO;
import kr.co.farmstory2.vo.ArticleVO;
import kr.co.farmstory2.vo.UserVO;

public enum ArticleService {
	INSTANCE;
	private ArticleDAO dao = ArticleDAO.getInstance();
	
	// insert
	public void insertArticle() {
		dao.insertArticle();
	}
	public ArticleVO insertComment(String parent, String uid, String content, String regip) {
		return dao.insertComment(parent, uid, content, regip);
	}
	
	// select
	public ArticleVO selectArticle(String no) {
		return dao.selectArticle(no);
	}
	public List<ArticleVO> selectArticles(int start, String cate) {
		return dao.selectArticles(start, cate);
	}
	public int selectCountTotal(String cate) {
		return dao.selectCountTotal(cate);
	}
	public List<ArticleVO> selectComments(String no){
		return dao.selectComments(no);
	}
	
	// update
	public void updateArticle() {
		dao.updateArticle();
	}
	
	public void updateArticleComment(String parent) {
		dao.updateArticleComment(parent);
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
	public int[] getPageGroupNum(int currentPage, int lastPageNum) {
		int currentPageGroup = (int) Math.ceil(currentPage /10.0);
		int pageGroupStart = (currentPageGroup -1)*10 + 1;
		int pageGroupEnd = currentPageGroup *10;
		
		if(pageGroupEnd > lastPageNum) {
			pageGroupEnd = lastPageNum;
		}
		int[] result = {currentPageGroup, pageGroupStart, pageGroupEnd};
		return result;
	}
}
