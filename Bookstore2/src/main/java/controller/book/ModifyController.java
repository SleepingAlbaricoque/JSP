package controller.book;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.BookDAO;
import vo.BookVO;

@WebServlet("/book/modify.do")
public class ModifyController extends HttpServlet{
	private static final long serialVersionUID = 1L;

	@Override
	public void init() throws ServletException {}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String bookID = req.getParameter("bookID");
		BookVO book = BookDAO.getInstance().selectBook(bookID);
		
		req.setAttribute("book", book);
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/book/modify.jsp");
		dispatcher.forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String bookID = req.getParameter("bookID");
		String bookName = req.getParameter("bookName");
		String publisher = req.getParameter("publisher");
		String price = req.getParameter("price");
		
		BookVO book = new BookVO();
		book.setBookID(Integer.parseInt(bookID));
		book.setBookName(bookName);
		book.setPublisher(publisher);
		book.setPrice(Integer.parseInt(price));
		
		BookDAO.getInstance().updateBook(book);
		
		resp.sendRedirect("/Bookstore2/book/list.do");
	}
}
