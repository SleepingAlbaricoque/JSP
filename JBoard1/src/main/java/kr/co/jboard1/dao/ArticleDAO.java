package kr.co.jboard1.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.jboard1.bean.ArticleBean;
import kr.co.jboard1.bean.FileBean;
import kr.co.jboard1.db.DBCP;
import kr.co.jboard1.db.SQL;

// DAO: Data Access Object
public class ArticleDAO { // 싱글턴 객체
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	private static ArticleDAO instance = new ArticleDAO();
	public static ArticleDAO getInstance() {
		return instance;
	}
	private ArticleDAO() {}
	
	// 기본 CRUD(insert, select, update, delete) 메서드
	public int insertArticle(ArticleBean article) { // parent값 return해야함
		int parent = 0;
		
		try{
			logger.info("insertArticle starts");
			Connection conn = DBCP.getConnection(); // connection은 정보 객체(객체는 곧 정보 덩어리) -> 이를 바탕으로 쿼리문 객체 생성
			conn.setAutoCommit(false);
			
			Statement stmt = conn.createStatement();
			PreparedStatement psmt = conn.prepareStatement(SQL.INSERT_ARTICLE);
			
			psmt.setString(1, article.getTitle());
			psmt.setString(2, article.getContent());
			psmt.setInt(3, article.getFname() == null? 0 : 1);
			psmt.setString(4, article.getUid());
			psmt.setString(5, article.getRegip());
			
			psmt.executeUpdate(); // INSERT
			ResultSet rs =stmt.executeQuery(SQL.SELECT_MAX_NO);
			
			conn.commit(); // 위에서 auto commit을 막고 여기서 psmt, stmt 한 번에 동시에 실행 => 내가 올리는 동안 다른 사용자가 글 올려서 max no가 다른 사용자 글 번호가 되는 상황 방지
			
			if(rs.next()){
				parent = rs.getInt(1);
			}
			
			rs.close();
			stmt.close();
			psmt.close();
			conn.close();
			
		}catch(Exception e){
			e.printStackTrace();
			logger.error(e.getMessage());
		}
		
		return parent;
	}
	
	public void insertFile(int parent, String newName, String fname) {
		try{
			logger.info("insertFile starts");
			
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(SQL.INSERT_FILE);
			psmt.setInt(1, parent);
			psmt.setString(2, newName);
			psmt.setString(3, fname);
			psmt.executeUpdate();
			
			psmt.close();
			conn.close();
			
		}catch(Exception e){
			e.printStackTrace();
			logger.error(e.getMessage());
		}
	}
	
	public ArticleBean insertComment(ArticleBean comment) {
		ArticleBean article = null;
		
		try{
			Connection conn = DBCP.getConnection();
			
			// 트랜잭션 시작
			conn.setAutoCommit(false);
			
			PreparedStatement psmt = conn.prepareStatement(SQL.INSERT_COMMENT);
			Statement stmt = conn.createStatement();
			
			psmt.setInt(1, comment.getParent());
			psmt.setString(2, comment.getContent());
			psmt.setString(3, comment.getUid());
			psmt.setString(4, comment.getRegip());
			psmt.executeUpdate();
			ResultSet rs = stmt.executeQuery(SQL.SELECT_COMMENT_LATEST);
			
			// 작업 확정
			conn.commit();
			
			if(rs.next()) {
				article = new ArticleBean();
				article.setNo(rs.getInt(1));
				article.setParent(rs.getInt(2));
				article.setContent(rs.getString(6));
				article.setRdate(rs.getString(11).substring(2, 10));
				article.setNick(rs.getString(12));
			}
			
			rs.close();
			stmt.close();
			psmt.close();
			conn.close();
			
		}catch(Exception e){
			e.printStackTrace();
			logger.error(e.getMessage());
		}
		
		return article;
	}
	
	public ArticleBean selectArticle(String no) {
		ArticleBean ab = null;
		try{
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(SQL.SELECT_ARTICLE);
			psmt.setString(1, no);
			ResultSet rs = psmt.executeQuery();
			
			if(rs.next()){
				ab = new ArticleBean();
				ab.setNo(rs.getInt(1));
				ab.setParent(rs.getInt(2));
				ab.setComment(rs.getInt(3));
				ab.setCate(rs.getString(4));
				ab.setTitle(rs.getString(5));
				ab.setContent(rs.getString(6));
				ab.setFile(rs.getInt(7));
				ab.setHit(rs.getInt(8));
				ab.setUid(rs.getString(9));
				ab.setRegip(rs.getString(10));
				ab.setRdate(rs.getString(11));
				ab.setNick(rs.getString(12));
				ab.setFno(rs.getInt(13));
				ab.setOriName(rs.getString(14));
				ab.setDownload(rs.getInt(15));
			}
			
			rs.close();
			psmt.close();
			conn.close();
			
		}catch(Exception e){
			e.printStackTrace();
			logger.error(e.getMessage());
		}
		
		return ab;
	}
	
	public List<ArticleBean> selectArticles(int start) {
		List<ArticleBean> articles = new ArrayList<>();
		
		try{
			Connection conn = DBCP.getConnection();
			
			PreparedStatement psmt = conn.prepareStatement(SQL.SELECT_ARTICLES);
			psmt.setInt(1, start);
			ResultSet rs = psmt.executeQuery();
			
			while(rs.next()){
				ArticleBean ab = new ArticleBean();
				ab.setNo(rs.getInt(1));
				ab.setParent(rs.getInt(2));
				ab.setComment(rs.getInt(3));
				ab.setCate(rs.getString(4));
				ab.setTitle(rs.getString(5));
				ab.setContent(rs.getString(6));
				ab.setFile(rs.getInt(7));
				ab.setHit(rs.getInt(8));
				ab.setUid(rs.getString(9));
				ab.setRegip(rs.getString(10));
				ab.setRdate(rs.getString(11));
				ab.setNick(rs.getString(12));
				articles.add(ab);
			}
			
			rs.close();
			psmt.close();
			conn.close();
			
		}catch(Exception e){
			e.printStackTrace();
			logger.error(e.getMessage());
		}
		
		return articles;
	}
	
	public FileBean selectFile(String fno) {
		FileBean fb = null;
		
		try{
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(SQL.SELECT_FILE);
			psmt.setString(1, fno);
			ResultSet rs = psmt.executeQuery();
			
			if(rs.next()){
				fb = new FileBean();
				fb.setFno(rs.getInt(1));
				fb.setParent(rs.getInt(2));
				fb.setNewName(rs.getString(3));
				fb.setOriName(rs.getString(4));
				fb.setDownload(rs.getInt(5));
				fb.setRdate(rs.getString(6));
			}
			
			rs.close();
			psmt.close();
			conn.close();
			
		}catch(Exception e){
			e.printStackTrace();
			logger.error(e.getMessage());
		}
		
		return fb;

	}
	
	public List<ArticleBean> selectComments(String parent) {
		List<ArticleBean> comments = new ArrayList<>();
		ArticleBean comment = null;
		
		try{
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(SQL.SELECT_COMMENTS);
			psmt.setString(1, parent);
			ResultSet rs = psmt.executeQuery();
			
			while(rs.next()){
				comment = new ArticleBean();
				comment.setNo(rs.getInt(1));
				comment.setParent(rs.getInt(2));
				comment.setComment(rs.getInt(3));
				comment.setCate(rs.getString(4));
				comment.setTitle(rs.getString(5));
				comment.setContent(rs.getString(6));
				comment.setFile(rs.getInt(7));
				comment.setHit(rs.getInt(8));
				comment.setUid(rs.getString(9));
				comment.setRegip(rs.getString(10));
				comment.setRdate(rs.getString(11).substring(2,10)); // 날짜 포맷 맞추기 위해 substring(년도 두 자리, 월, 일 표시)
				comment.setNick(rs.getString(12));
				comments.add(comment);
			}
			
			rs.close();
			psmt.close();
			conn.close();
			
		}catch(Exception e){
			e.printStackTrace();
			logger.error(e.getMessage());
		}
		
		return comments;
	}
	
	public void updateArticle() {}
	public void deleteArticle() {}
	
	// 전체 게시물 카운트
	public int selectCountTotal() {
		int total = 0;
		
		try {
			Connection conn = DBCP.getConnection();
			Statement stmt = conn.createStatement(); // statement는 쿼리 파라미터가 없는 sql문 수행
			ResultSet rs = stmt.executeQuery(SQL.SELECT_COUNT_TOTAL);
			
			if(rs.next()) {
				total = rs.getInt(1);
			}
			
			rs.close();
			stmt.close();
			conn.close();
			
		}catch(Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage());
		}
		
		return total;
	}
	
	public void updateArticleHit(String no) {
		try{
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(SQL.UPDATE_ARTICLE_HIT);
			psmt.setString(1, no);
			psmt.executeUpdate();
			
			psmt.close();
			conn.close();
			
		}catch(Exception e){
			e.printStackTrace();
			logger.error(e.getMessage());
		}
	}
	
	public void updateFileDownload(String fno) {
		try{
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(SQL.UPDATE_FILE_DOWNLOAD);
			psmt.setString(1, fno);
			psmt.executeUpdate();
			
			psmt.close();
			conn.close();
			
		}catch(Exception e){
			e.printStackTrace();
			logger.error(e.getMessage());
		}
	}
	
	public int updateComment(String content, String no) {
		int result = 0;
		
		try{
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(SQL.UPDATE_COMMENT);
			psmt.setString(1, content);
			psmt.setString(2, no);
			result = psmt.executeUpdate();
			
			psmt.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			logger.error(e.getMessage());
		}
		
		return result; // 잘 작동했는 지 체크하기위해
	}
	
	public void updateArticle(String title, String content, String no) {
		try{
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(SQL.UPDATE_ARTICLE);
			psmt.setString(1, title);
			psmt.setString(2, content);
			psmt.setString(3, no);
			psmt.executeUpdate();
			
			psmt.close();
			conn.close();
			
		}catch(Exception e){
			e.printStackTrace();
			logger.error(e.getMessage());
		}
	}
	
	public void updateArticleComment(String parent) {
		try {
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(SQL.UPDATE_ARTICLE_COMMENT);
			psmt.setString(1, parent);
			psmt.executeUpdate();
			
			psmt.close();
			conn.close();
			
		}catch(Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage());
		}
	}
	
	public int deleteComment(String no) {
		int result = 0;
		
		try {
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(SQL.DELETE_COMMENT);
			psmt.setString(1, no);
			result = psmt.executeUpdate();
			
			psmt.close();
			conn.close();
			
		}catch(Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage());
		}
		return result;
	}
	
	public void deleteArticle(String no) {
		try{
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(SQL.DELETE_ARTICLE);
			psmt.setString(1, no);
			psmt.setString(2, no);
			psmt.executeUpdate();
			
			psmt.close();
			conn.close();
			
		}catch(Exception e){
			e.printStackTrace();
			logger.error(e.getMessage());
		}
	}
	
	public String deleteFile(String no) {
		String newName = null;
		
		try{
			Connection conn = DBCP.getConnection();
			
			conn.setAutoCommit(false);
			
			PreparedStatement psmt1 = conn.prepareStatement(SQL.SELECT_FILE_WITH_PARENT);
			PreparedStatement psmt2 = conn.prepareStatement(SQL.DELETE_FILE);
			psmt1.setString(1, no);
			psmt2.setString(1, no);
			
			ResultSet rs = psmt1.executeQuery();
			psmt2.executeUpdate();
			
			conn.commit();
			
			if(rs.next()) {
				newName = rs.getString(3);
			}
			
			rs.close();
			psmt1.close();
			psmt2.close();
			conn.close();
			
		}catch(Exception e){
			e.printStackTrace();
			logger.error(e.getMessage());
		}
		
		return newName;
	}
	
	public void deleteArticleComment() {
		
	}
}
