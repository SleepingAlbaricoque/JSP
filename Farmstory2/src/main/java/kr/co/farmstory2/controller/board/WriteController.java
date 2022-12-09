package kr.co.farmstory2.controller.board;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import kr.co.farmstory2.service.ArticleService;
import kr.co.farmstory2.vo.ArticleVO;

@WebServlet("/board/write.do")
public class WriteController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	private ArticleService service = ArticleService.INSTANCE;
	
	@Override
	public void init() throws ServletException {}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String group = req.getParameter("group");
		String cate = req.getParameter("cate");
		String no = req.getParameter("no");
		String pg = req.getParameter("pg");
	
		req.setAttribute("group", group);
		req.setAttribute("cate", cate);
		req.setAttribute("no", no);
		req.setAttribute("pg", pg);
		
		HttpSession session = req.getSession();
		if(session.getAttribute("sessUser")==null) { 
			resp.sendRedirect("/Farmstory2/user/login.do?success=101");
		}else {
			RequestDispatcher dispatcher = req.getRequestDispatcher("/board/write.jsp");
			dispatcher.forward(req, resp);
		}
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ServletContext ctx = req.getServletContext();
		String path = ctx.getRealPath("/file");
		
		MultipartRequest mr = service.uploadFile(req, path); 
		String title = mr.getParameter("title");
		String content = mr.getParameter("content");
		String fname = mr.getFilesystemName("fname");
		String uid = mr.getParameter("uid");
		String cate = mr.getParameter("cate");
		String group = mr.getParameter("group");
		String regip = req.getRemoteAddr();
		
		ArticleVO article = new ArticleVO();
		article.setTitle(title);
		article.setContent(content);
		article.setFname(fname);
		article.setUid(uid);
		article.setCate(cate);
		article.setRegip(regip);
		
		int parent = service.insertArticle(article);
		
		if(fname != null) {
			String newName = service.renameFile(article, path);
			
			service.insertFile(parent, newName, fname);
		}
		resp.sendRedirect("/Farmstory2/board/list.do?cate=" +cate + "&group=" +group);
	}
}
