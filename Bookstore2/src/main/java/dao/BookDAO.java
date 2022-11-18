package dao;

import java.util.ArrayList;
import java.util.List;

import db.DBHelper;
import vo.BookVO;

public class BookDAO extends DBHelper{
	private static BookDAO instance = new BookDAO();
	public static BookDAO getInstance() {
		return instance;
	}
	private BookDAO() {}
	
	public void insertBook(BookVO book) {
		try {
			conn = getConnection();
			psmt = conn.prepareStatement("insert into `book` values (?,?,?,?)");
			psmt.setInt(1, book.getBookID());
			psmt.setString(2, book.getBookName());
			psmt.setString(3, book.getPublisher());
			psmt.setInt(4, book.getPrice());
			psmt.executeUpdate();
			close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public BookVO selectBook(String bookID) {
		BookVO book = null;
		
		try {
			conn = getConnection();
			psmt = conn.prepareStatement("select * from `book` where `bookID`=?");
			psmt.setString(1, bookID);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				book = new BookVO();
				book.setBookID(rs.getInt(1));
				book.setBookName(rs.getString(2));
				book.setPublisher(rs.getString(3));
				book.setPrice(rs.getInt(4));
			}
			close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return book;
	}
	
	public List<BookVO> selectBooks() {
		List<BookVO> books = new ArrayList<>();
		
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select * from `book`");
			
			while(rs.next()) {
				BookVO book = new BookVO();
				book.setBookID(rs.getInt(1));
				book.setBookName(rs.getString(2));
				book.setPublisher(rs.getString(3));
				book.setPrice(rs.getInt(4));
				books.add(book);
			}
			close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return books;
	}
	
	public void updateBook(BookVO book) {
		try {
			conn = getConnection();
			psmt = conn.prepareStatement("update `book` set `bookName`=?, `publisher`=?, `price`=? where `bookID`=?");
			psmt.setString(1, book.getBookName());
			psmt.setString(2, book.getPublisher());
			psmt.setInt(3, book.getPrice());
			psmt.setInt(4, book.getBookID());
			psmt.executeUpdate();
			close();
		
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void deleteBook(String bookID) {
		try {
			conn = getConnection();
			psmt = conn.prepareStatement("delete from `book` where `bookID`=?");
			psmt.setString(1, bookID);
			psmt.executeUpdate();
			close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
