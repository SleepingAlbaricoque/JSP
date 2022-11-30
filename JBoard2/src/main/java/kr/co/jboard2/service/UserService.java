package kr.co.jboard2.service;

import kr.co.jboard2.dao.UserDAO;
import kr.co.jboard2.vo.UserVO;

public enum UserService {
	INSTANCE;
	private UserDAO dao = UserDAO.getInstance();
	
	// insert
	
	// select
	public int selectUserByPass(String pass) {
		return dao.selectUserByPass(pass);
	}
	
	public UserVO selectUser(String uid, String pass) {
		return dao.selectUser(uid, pass);
	}
	// update
	public int updateUserPass(String uid, String pass) {
		return dao.updateUserPass(uid, pass);
	}
	
	public void updateUser(UserVO user) {
		dao.updateUser(user);
	}
	
	// delete
	public void deleteUser(String uid) {
		dao.deleteUser(uid);
	}
}
