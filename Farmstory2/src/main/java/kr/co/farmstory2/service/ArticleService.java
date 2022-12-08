package kr.co.farmstory2.service;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.co.farmstory2.dao.ArticleDAO;
import kr.co.farmstory2.vo.ArticleVO;
import kr.co.farmstory2.vo.FileVO;
import kr.co.farmstory2.vo.UserVO;

public enum ArticleService {
	INSTANCE;
	private ArticleDAO dao = ArticleDAO.getInstance();
	
	// insert
	public int insertArticle(ArticleVO article) {
		return dao.insertArticle(article);
	}
	public ArticleVO insertComment(String parent, String uid, String content, String regip) {
		return dao.insertComment(parent, uid, content, regip);
	}
	public void insertFile(int parent, String newName, String fname) {
		dao.insertFile(parent, newName, fname);
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
	public FileVO selectFile(String fno) {
		return dao.selectFile(fno);
	}
	public List<ArticleVO> selectLatest(){
		return dao.selectLatest();
	}
	public List<ArticleVO> selectLatest(String cate){
		return dao.selectLatest(cate);
	}
	public List<ArticleVO> selectArticlesByKeyword(String cate, String searchOption, String search, int start){
		return dao.selectArticlesByKeyword(cate, searchOption, search, start);
	}
	// update
	public void updateArticle(String title, String content, String no) {
		dao.updateArticle(title, content, no);
	}
	
	public void updateArticleComment(String parent) {
		dao.updateArticleComment(parent);
	}
	
	public void updateArticleHit(String no) {
		dao.updateArticleHit(no);
	}
	
	public int updateComment(String content, String no) {
		return dao.updateComment(content, no);
	}
	
	public void updateFileDownload(String fno) {
		dao.updateFileDownload(fno);
	}
	
	public void updateFile(String no, String newName, String fname) {
		dao.updateFile(no, newName, fname);
	}
	
	public void updateArticleFile(String no) {
		dao.updateArticleFile(no);
	}
	
	// delete
	public void deleteArticle(String no) {
		dao.deleteArticle(no);
	}
	
	public int deleteComment(String no) {
		return dao.deleteComment(no);
	}
	
	public void deleteComments(String no) {
		dao.deleteComments(no);
	}
	
	public void deleteFile(String no) {
		dao.deleteFile(no);
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
	
	// file
	public MultipartRequest uploadFile(HttpServletRequest req, String path) throws IOException{
		int maxSize = 1024 * 1024* 10;
		
		return new MultipartRequest(req, path, maxSize, "UTF-8", new DefaultFileRenamePolicy());
	}
	
	public String renameFile(ArticleVO article, String path) {
		int idx = article.getFname().lastIndexOf(".");
		String ext = article.getFname().substring(idx);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss_");
		String now = sdf.format(new Date());
		String newName = now + article.getUid() + ext;
		
		File oriFile = new File(path+"/"+article.getFname());
		File newFile = new File(path+"/"+newName);
		oriFile.renameTo(newFile);
		
		return newName;
	}
	
	
}
