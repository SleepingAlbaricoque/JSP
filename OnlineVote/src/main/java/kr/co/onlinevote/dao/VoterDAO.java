package kr.co.onlinevote.dao;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.onlinevote.db.DBHelper;
import kr.co.onlinevote.db.SQL;
import kr.co.onlinevote.vo.VoterVO;

public class VoterDAO extends DBHelper{
	private static VoterDAO instance = new VoterDAO();
	public static VoterDAO getInstance() {
		return instance;
	}
	private VoterDAO() {}
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	// insert
	public void insertVoter(VoterVO vo) {
		try {
			logger.info("insertVoter called");
			
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.INSERT_VOTER);
			psmt.setString(1, vo.getName());
			psmt.setString(2, vo.getBirth());
			psmt.setInt(3, vo.getFname() == null? 0 : 1);
			psmt.setString(4, vo.getHp());
			psmt.setString(5, vo.getEmail());
			psmt.setInt(6, vo.getIs_admin());
			psmt.setString(7, vo.getId());
			psmt.setString(8, vo.getPassword());
			psmt.executeUpdate();
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
	}
	
	public void insertFile(int regNo, String newName, String fname) {
		try {
			logger.info("insertFile called");
			
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.INSERT_FILE);
			psmt.setInt(1, regNo);
			psmt.setString(2, newName);
			psmt.setString(3, fname);
			psmt.executeUpdate();
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
	}
	
	// select
	public VoterVO selectVoter(String id, String password) {
		VoterVO vo = null;
		
		try {
			logger.info("selectVoter called");
			
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.SELECT_VOTER);
			psmt.setString(1, id);
			psmt.setString(2, password);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				vo = new VoterVO();
				vo.setRegNo(rs.getInt(1));
				vo.setName(rs.getString(2));
				vo.setBirth(rs.getString(3));
				vo.setFile(rs.getInt(4));
				vo.setHp(rs.getString(5));
				vo.setRdate(rs.getString(6));
				vo.setEmail(rs.getString(7));
				vo.setIs_admin(rs.getInt(8));
				vo.setId(rs.getString(9));
				vo.setPassword(rs.getString(10));
			}
			
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("vo: " + vo);
		return vo;
	}
	
	public int selectVoter(String id) {
		int result = 0;
		
		try {
			logger.info("selectVoter called");
			
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.SELECT_VOTER_W_ID);
			psmt.setString(1, id);
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
	
	public void selectVoters() {}
	
	public int selectRegNo(String id) {
		int regNo = 0;
		try {
			logger.info("selectRegNo called");
			
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.SELECT_REGNO);
			psmt.setString(1, id);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				regNo = rs.getInt(1);
			}
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("regNo " + regNo);
		return regNo;
	}
	
	public VoterVO selectAdmin(String id, String password) {
		VoterVO vo = null;
		
		try {
			logger.info("selectVoter called");
			
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.SELECT_ADMIN);
			psmt.setString(1, id);
			psmt.setString(2, password);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				vo = new VoterVO();
				vo.setRegNo(rs.getInt(1));
				vo.setName(rs.getString(2));
				vo.setBirth(rs.getString(3));
				vo.setFile(rs.getInt(4));
				vo.setHp(rs.getString(5));
				vo.setRdate(rs.getString(6));
				vo.setEmail(rs.getString(7));
				vo.setIs_admin(rs.getInt(8));
				vo.setId(rs.getString(9));
				vo.setPassword(rs.getString(10));
			}
			
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("vo: " + vo);
		return vo;
	}
	
	public VoterVO selectVoterBySessId(String sessId) {
		VoterVO vo = null;
		
		try {
			logger.info("selectVoterBySessId called");
			
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.SELECT_VOTER_BY_SESSID);
			psmt.setString(1, sessId);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				vo = new VoterVO();
				vo.setRegNo(rs.getInt(1));
				vo.setName(rs.getString(2));
				vo.setBirth(rs.getString(3));
				vo.setFile(rs.getInt(4));
				vo.setHp(rs.getString(5));
				vo.setRdate(rs.getString(6));
				vo.setEmail(rs.getString(7));
				vo.setIs_admin(rs.getInt(8));
				vo.setId(rs.getString(9));
				vo.setPassword(rs.getString(10));
			}
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("vo " + vo);
		return vo;
	}
	
	// update
	public void updateVoter() {}
	
	public void updateVoterForSession(String id, String sessId) {
		try {
			logger.info("updateVoterForSession called");
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.UPDATE_VOTER_FOR_SESSION);
			psmt.setString(1, sessId);
			psmt.setString(2, id);
			psmt.executeUpdate();
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
	}
	
	public void updateVoterForSessionOut(String id) {
		try {
			logger.info("updateVoterForSessionOut called");
			
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.UPDATE_VOTER_FOR_SESSION_OUT);
			psmt.setString(1, id);
			psmt.executeUpdate();
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
	}
	
	// delete
	public void deleteVoter() {}
}
