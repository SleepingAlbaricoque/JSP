package kr.co.farmstory2.service;

import java.util.List;

import kr.co.farmstory2.dao.ArticleDAO;
import kr.co.farmstory2.dao.UserDAO;
import kr.co.farmstory2.vo.UserVO;

public enum UserService {
	INSTANCE;
	private UserDAO dao = UserDAO.getInstance();
	
	// insert
	public void insertUser(UserVO vo) {
		dao.insertUser(vo);
	}
	
	// select
	public List<String> selectTerms(){
		return dao.selectTerms();
	}
	
	public int selectCountUid(String uid) {
		return dao.selectCountUid(uid);
	}
	
	public int selectCountNick(String nick) {
		return dao.selectCountNick(nick);
	}
	
	public UserVO selectUser(String uid, String pass) {
		return dao.selectUser(uid, pass);
	}
	public UserVO selectUserBySessId(String sessId) {
		return dao.selectUserBySessId(sessId);
	}
	
	public UserVO selectUserForFindId(String name, String email) {
		return dao.selectUserForFindId(name, email);
	}
	
	public int selectUserForFindPw(String uid, String email) {
		return dao.selectUserForFindPw(uid, email);
	}
	
	// update
	public void updateUserForSession(String uid, String sessId) {
		dao.updateUserForSession(uid, sessId);
	}
	
	public void updateUserForSessionOut(String uid) {
		dao.updateUserForSessionOut(uid);
	}
	
	public int updatePass(String uid, String pass) {
		return dao.updatePass(uid, pass);
	}
	
	public int updateUser(UserVO user) {
		return dao.updateUser(user);
	}
	
	// delete
	public int deleteUser(String uid) {
		return dao.deleteUser(uid);
	}
}
