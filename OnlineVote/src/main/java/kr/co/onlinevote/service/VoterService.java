package kr.co.onlinevote.service;

import ch.qos.logback.classic.Logger;
import kr.co.onlinevote.dao.VoterDAO;
import kr.co.onlinevote.vo.VoterVO;

public enum VoterService {
	INSTANCE;
	private VoterDAO dao = VoterDAO.getInstance();
	
	// insert
	public void insertVoter(VoterVO vo) {
		dao.insertVoter(vo);
	}
	
	// select
	public VoterVO selectVoter(String id, String password) {
		return dao.selectVoter(id, password);
	}
	public int selectVoter(String id) {
		return dao.selectVoter(id);
	}
	
	public void selectVoters() {
		
	}
	
	public int selectRegNo(String id) {
		return dao.selectRegNo(id);
	}
	
	public VoterVO selectAdmin(String id, String password) {
		return dao.selectAdmin(id, password);
	}
	
	public VoterVO selectVoterBySessId(String sessId) {
		return dao.selectVoterBySessId(sessId);
	}
	
	// update
	public void updateVoterForSession(String id, String sessId) {
		dao.updateVoterForSession(id, sessId);
	}
	
	public void updateVoterForSessionOut(String id) {
		dao.updateVoterForSessionOut(id);
	}
	
	// delete
	
	
	// file
	public void insertFile(int regNo, String newName, String fname) {
		dao.insertFile(regNo, newName, fname);
	}
	
}
