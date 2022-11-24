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
	public void insertVoter() {}
	
	// select
	public VoterVO selectVoter(String id, String pass) {
		VoterVO vo = null;
		
		try {
			logger.info("selectVoter called");
			
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.SELECT_VOTER);
			psmt.setString(1, id);
			psmt.setString(2, pass);
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
			}
			
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("vo: " + vo);
		return vo;
	}
	
	public void selectVoters() {}
	
	// update
	public void updateVoter() {}
	
	// delete
	public void deleteVoter() {}
}
