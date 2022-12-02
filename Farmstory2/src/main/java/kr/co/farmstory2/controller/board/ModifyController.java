package kr.co.farmstory2.controller.board;

import java.io.File;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import kr.co.farmstory2.service.ArticleService;
import kr.co.farmstory2.vo.ArticleVO;

@WebServlet("/board/modify.do")
public class ModifyController extends HttpServlet{
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
		
		ArticleVO article = service.selectArticle(no);
		req.setAttribute("article", article);
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/board/modify.jsp");
		dispatcher.forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ServletContext ctx = req.getServletContext();
		String path = ctx.getRealPath("/file");
		MultipartRequest mr =service.uploadFile(req, path);
		
		String cate = mr.getParameter("cate");
		String group = mr.getParameter("group");
		String no = mr.getParameter("no");
		String title = mr.getParameter("title");
		String content = mr.getParameter("content");
		String fname = mr.getFilesystemName("fname");
		String uid = mr.getParameter("uid");
		
		ArticleVO article = new ArticleVO();
		article.setFname(fname);
		article.setUid(uid);
		
		if(fname != null) {
			String newName = service.renameFile(article, path);
			service.updateFile(no, newName, fname);
			service.updateArticle(title, content, no);
			service.updateArticleFile(no);
		}else {
			service.updateArticle(title, content, no);
		}
		resp.sendRedirect("/Farmstory2/board/view.do?cate=" + cate + "&group=" + group + "&no=" + no);
	}
}
