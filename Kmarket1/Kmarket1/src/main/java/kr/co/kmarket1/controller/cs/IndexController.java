package kr.co.kmarket1.controller.cs;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.kmarket1.service.CsService;
import kr.co.kmarket1.vo.CsArticleVO;


@WebServlet("/cs/index.do")
public class IndexController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	private CsService service = CsService.instance;

	@Override
	public void init() throws ServletException {
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		List<CsArticleVO> notices = service.selectNotices();
		List<CsArticleVO> faqs = service.selectFaq();
		List<CsArticleVO> qnas = service.selectQnas();
		
		req.setAttribute("notices", notices);
		req.setAttribute("faqs", faqs);
		req.setAttribute("qnas", qnas);
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/cs/index.jsp");
		dispatcher.forward(req, resp);
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}
	
	
}
