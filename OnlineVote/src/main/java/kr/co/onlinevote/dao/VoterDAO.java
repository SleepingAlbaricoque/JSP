package kr.co.onlinevote.dao;

import kr.co.onlinevote.db.DBHelper;

public class VoterDAO extends DBHelper{
	private VoterDAO instance = new VoterDAO();
	public VoterDAO getInstance() {
		return instance;
	}
	private VoterDAO() {}
	
	public void insertVoter() {}
	public void selectVoter() {}
	public void selectVoters() {}
	public void updateVoter() {}
	public void deleteVoter() {}
}
