package kr.co.college.db;

public class SQL {
	public static final String SELECT_LECTURES = "select * from `lecture`";
	public static final String SELECT_INFO = "select a.*, b.lecName, c.stdName from `register` as a "
										+ "join `lecture` as b on a.regLecNo = b.lecNo "
										+ "join `student` as c on a.regStdNo = c.stdNo "
										+ "where `regStdNo` = ?";
	public static final String SELECT_STUDENT ="select * from `student`";
	
	public static final String INSERT_LECTURE = "insert into `lecture` values (?,?,?,?,?)";
	public static final String INSERT_STUDENT = "insert into `student` values (?,?,?,?,?)";
}
