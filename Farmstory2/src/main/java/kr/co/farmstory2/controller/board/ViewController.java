package kr.co.farmstory2.controller.board;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.JsonObject;

import kr.co.farmstory2.service.ArticleService;
import kr.co.farmstory2.vo.ArticleVO;

@WebServlet("/board/view.do")
public class ViewController extends HttpServlet{
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
		
		// 글 조회 수 올리기
		service.updateArticleHit(no);
		
		// 댓글 불러오기
		List<ArticleVO> comments = service.selectComments(no);
		req.setAttribute("comments", comments);	
		
		HttpSession session = req.getSession();
		if(session.getAttribute("sessUser")==null) { 
			resp.sendRedirect("/Farmstory2/user/login.do?success=101");
		}else {
			RequestDispatcher dispatcher = req.getRequestDispatcher("/board/view.jsp");
			dispatcher.forward(req, resp);
		}
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String parent = req.getParameter("parent");
		String uid = req.getParameter("uid");
		String content = req.getParameter("content");
		String regip = req.getRemoteAddr();
		String group = req.getParameter("group");
		
		req.setAttribute("group", group);
		resp.setCharacterEncoding("UTF-8");
		
		ArticleVO comment = service.insertComment(parent, uid, content, regip);
		
		// 원 글 댓글 수 올려주기
		service.updateArticleComment(parent);
		
		JsonObject json = new JsonObject();
		json.addProperty("no", comment.getNo());
		json.addProperty("parent", comment.getParent());
		json.addProperty("content", comment.getContent());
		json.addProperty("rdate", comment.getRdate());
		json.addProperty("nick", comment.getNick());
		
		PrintWriter writer = resp.getWriter();
		writer.print(json.toString());
	}
}
