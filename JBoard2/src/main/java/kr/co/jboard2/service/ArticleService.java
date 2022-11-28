package kr.co.jboard2.service;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import ch.qos.logback.classic.Logger;
import kr.co.jboard2.dao.ArticleDAO;
import kr.co.jboard2.vo.ArticleVO;

public enum ArticleService {
	INSTANCE;
	private ArticleDAO dao = ArticleDAO.getInstance();
	
	// insert
	public int insertArticle(ArticleVO article) {
		return dao.insertArticle(article);		
	}
	public void insertFile(int parent, String newName, String fname) {
		dao.insertFile(parent, newName, fname);
	}
	
	// select
	public ArticleVO selectArticle(String no) {
		return dao.selectArticle(no);
	}
	public List<ArticleVO> selectArticles(int start) {
		return dao.selectArticles(start);
	}
	public int selectCountTotal() {
		return dao.selectCountTotal();
	}
	public List<ArticleVO> selectComments(String no) {
		return dao.selectComments(no);
	}
	public List<ArticleVO> selectArticleByKeyword(String keyword, int start) {
		return dao.selectArticleByKeyword(keyword, start);
	}
	public int selectCountTotalForSearch(String keyword) {
		return dao.selectCountTotalForSearch(keyword);
	}
	
	// update
	public void updateArticle() {}
	public void updateArticleHit(String no) {
		dao.updateArticleHit(no);
	}
	
	// delete
	public void deleteArticle() {}
	
	// file
	public MultipartRequest uploadFile(HttpServletRequest req, String path) throws IOException {
		int maxSize = 1024 * 1024 * 10; // 최대 파일 업로드 허용량 10MB
		
		return new MultipartRequest(req, path, maxSize, "UTF-8", new DefaultFileRenamePolicy());
	}
	
	public String renameFile(ArticleVO article, String path) {
		// 파일명 수정
		int idx = article.getFname().lastIndexOf(".");
		String ext = article.getFname().substring(idx);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss_");
		String now = sdf.format(new Date());
		String newName = now+article.getUid()+ext; // 20221026111323_chhak0503.txt 
		
		File oriFile = new File(path+"/"+article.getFname());
		File newFile = new File(path+"/"+newName);
		
		oriFile.renameTo(newFile);
		
		return newName;
	}
	
	// 마지막 페이지 번호
	public int getLastPageNum(int total) {
		int lastPageNum = 0;
		
		if(total % 10 == 0) {
			lastPageNum = total /10;
		}else {
			lastPageNum = total / 10 +1;
		}
		return lastPageNum;
	}
	
	public int[] getPageGroupNum(int currentPage, int lastPageNum) {
		int currentPageGroup = (int) Math.ceil(currentPage /10.0);
		int pageGroupStart = (currentPageGroup -1)*10 + 1;
		int pageGroupEnd = currentPageGroup * 10;
		
		if(pageGroupEnd > lastPageNum) {
			pageGroupEnd = lastPageNum;
		}
		int[] result = {currentPageGroup, pageGroupStart, pageGroupEnd};
		return result;
	}
}
