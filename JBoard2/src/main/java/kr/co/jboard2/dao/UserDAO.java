package kr.co.jboard2.dao;


import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.jboard2.db.DBHelper;
import kr.co.jboard2.db.SQL;
import kr.co.jboard2.vo.ArticleVO;
import kr.co.jboard2.vo.TermsVO;
import kr.co.jboard2.vo.UserVO;

public class UserDAO extends DBHelper{
	private static UserDAO instance = new UserDAO();
	public static UserDAO getInstance() {
		return instance;
	}
	private UserDAO() {}
	
	// 로거 생성
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	// insert
	public void insertUser(UserVO vo) {
		try {
			logger.info("insertUser called");
			
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.INSERT_USER);
			psmt.setString(1, vo.getUid());
			psmt.setString(2, vo.getPass());
			psmt.setString(3, vo.getName());
			psmt.setString(4, vo.getNick());
			psmt.setString(5, vo.getEmail());
			psmt.setString(6, vo.getHp());
			psmt.setString(7, vo.getZip());
			psmt.setString(8, vo.getAddr1());
			psmt.setString(9, vo.getAddr2());
			psmt.setString(10, vo.getRegip());
			psmt.executeUpdate();
			
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
	}
	
	// select
	public TermsVO selectTerms() {
		TermsVO vo = null;
		
		try {
			logger.info("selectTerms called");
			
			conn = getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(SQL.SELECT_TERMS);
			
			if(rs.next()) {
				vo = new TermsVO();
				vo.setTerms(rs.getString(1));
				vo.setPrivacy(rs.getString(2));
			}
			
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("vo: " + vo);
		return vo;
	}
	
	public int selectCountUid(String uid) {
		int result = 0;
		
		try {
			logger.info("selectCheckUid called");
			
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.SELECT_COUNT_UID);
			psmt.setString(1, uid);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
			}
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("result: " + result );
		return result;
	}
	
	public int selectCountNick(String nick) {
		int result = 0;
		
		try {
			logger.info("selectCountNick called");
			
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.SELECT_COUNT_NICK);
			psmt.setString(1, nick);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
			}
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("result: " + result);
		return result;
	}
	
	public UserVO selectUser(String uid, String pass) {
		UserVO vo = null;
		
		try {
			logger.info("selectUser called");
			
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.SELECT_USER);
			psmt.setString(1, uid);
			psmt.setString(2, pass);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				vo = new UserVO();
				vo.setUid(rs.getString(1));
				vo.setPass(rs.getString(2));
				vo.setName(rs.getString(3));
				vo.setNick(rs.getString(4));
				vo.setEmail(rs.getString(5));
				vo.setHp(rs.getString(6));
				vo.setGrade(rs.getInt(7));
				vo.setZip(rs.getString(8));
				vo.setAddr1(rs.getString(9));
				vo.setAddr2(rs.getString(10));
				vo.setRegip(rs.getString(11));
				vo.setRdate(rs.getString(12));
			}
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("vo: " + vo);
		return vo;
	}
	
	public void selectUsers() {}
	
	public UserVO selectUserForFindId(String name, String email) {
		UserVO vo = null;
		
		try {
			logger.info("selectUserForFindId called");
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.SELECT_USER_FOR_FIND_ID);
			psmt.setString(1, name);
			psmt.setString(2, email);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				vo = new UserVO();
				vo.setUid(rs.getString(1));
				vo.setName(rs.getString(2));
				vo.setEmail(rs.getString(3));
				vo.setRdate(rs.getString(4));
			}
			
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("vo" + vo);
		return vo;
	}
	
	
	public int selectUserForFindPw(String uid, String email) {
		int result = 0;
		
		try {
			logger.info("selectUserForFindPw called");
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.SELECT_USER_FOR_FIND_PW);
			psmt.setString(1, uid);
			psmt.setString(2, email);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
			}
			
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("result " + result);
		return result;
	}
	
	public UserVO selectUserBySessId(String sessId) {
		UserVO vo = null;
		
		try {
			logger.info("selectUserBySessId called");
			
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.SELECT_USER_BY_SESSID);
			psmt.setString(1, sessId);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				vo = new UserVO();
				vo.setUid(rs.getString(1));
				vo.setPass(rs.getString(2));
				vo.setName(rs.getString(3));
				vo.setNick(rs.getString(4));
				vo.setEmail(rs.getString(5));
				vo.setHp(rs.getString(6));
				vo.setGrade(rs.getInt(7));
				vo.setZip(rs.getString(8));
				vo.setAddr1(rs.getString(9));
				vo.setAddr2(rs.getString(10));
				vo.setRegip(rs.getString(11));
				vo.setRdate(rs.getString(12));
			}
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		return vo;
	}
	
	public int selectUserByPass(String pass) {
		int result = 0;
		
		try {
			logger.info("selectUserByPass called");
			
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.SELECT_USER_BY_PASS);
			psmt.setString(1, pass);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
			}
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("result " + result);
		return result;
	}
	
	// update
	public void updateUser(UserVO user) {
		try {
			logger.info("updateUser called");
			
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.UPDATE_USER);
			psmt.setString(1, user.getName());
			psmt.setString(2, user.getNick());
			psmt.setString(3, user.getEmail());
			psmt.setString(4, user.getHp());
			psmt.setString(5, user.getZip());
			psmt.setString(6, user.getAddr1());
			psmt.setString(7, user.getAddr2());
			psmt.setString(8, user.getUid());
			psmt.executeUpdate();
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
	}
	
	public int updateUserPass(String uid, String pass) {
		int result = 0;
		try {
			logger.info("updateUserPass called");
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.UPDATE_USER_PASSWORD);
			psmt.setString(1, pass);
			psmt.setString(2, uid);
			result = psmt.executeUpdate();
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("result " + result);
		return result;
	}
	
	public void updateUserForSession(String uid, String sessId) {
		try {
			logger.info("updateUserForSession called");
			
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.UPDATE_USER_FOR_SESSION);
			psmt.setString(1, sessId);
			psmt.setString(2, uid);
			psmt.executeUpdate();
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
	}
	
	public void updateUserForSessionOut(String uid) {
		try {
			logger.info("updateUserForSession called");
			
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.UPDATE_USER_FOR_SESSION_OUT);
			psmt.setString(1, uid);
			psmt.executeUpdate();
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
	}
	
	// delete
	public void deleteUser(String uid) {
		try {
			logger.info("deleteUser called");
			
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.DELETE_USER);
			psmt.setString(1, uid);
			psmt.executeUpdate();
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
	}
}
