package dao;

import java.util.ArrayList;
import java.util.List;

import db.DBHelper;
import vo.User2VO;

public class User2Dao extends DBHelper{
	private static User2Dao instance = new User2Dao();
	public static User2Dao getInstance() {
		return instance;
	}
	private User2Dao() {}
	
	public void insertUser(User2VO vo) {
		try {
		conn = getConnection();
		psmt = conn.prepareStatement("insert into `user2` values (?,?,?,?)");
		psmt.setString(1, vo.getUid());
		psmt.setString(2, vo.getName());
		psmt.setString(3, vo.getHp());
		psmt.setInt(4, vo.getAge());
		psmt.executeUpdate();
		
		close();
		
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public User2VO selectUser(String uid) {
		User2VO vo = new User2VO();
		
		try {
			conn = getConnection();
			psmt = conn.prepareStatement("select * from `user2` where `uid`=?");
			psmt.setString(1, uid);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				vo.setUid(rs.getString(1));
				vo.setName(rs.getString(2));
				vo.setHp(rs.getString(3));
				vo.setAge(rs.getString(4));
			}
			
			close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return vo;
	}
	
	public List<User2VO> selectUsers() {
		List<User2VO> users = new ArrayList<>();
		
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select * from `user2`");
			
			while(rs.next()) {
				User2VO vo = new User2VO();
				vo.setUid(rs.getString(1));		
				vo.setName(rs.getString(2));		
				vo.setHp(rs.getString(3));		
				vo.setAge(rs.getString(4));
				users.add(vo);
			}
			
			close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return users;
	}
	
	public void updateUser(User2VO vo) {
		try {
			conn = getConnection();
			psmt = conn.prepareStatement("update `user2` set `name`=?, `hp`=?, `age`=? where `uid`=?");
			psmt.setString(1, vo.getName());
			psmt.setString(2, vo.getHp());
			psmt.setInt(3, vo.getAge());
			psmt.setString(4, vo.getUid());
			psmt.executeUpdate();
			
			close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void deleteUser(String uid) {
		try {	
			conn = getConnection();
			psmt = conn.prepareStatement("delete from `user2` where `uid`=?");
			psmt.setString(1, uid);
			psmt.executeUpdate();
			close();
		
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
