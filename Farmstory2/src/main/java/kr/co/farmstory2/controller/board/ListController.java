package kr.co.farmstory2.controller.board;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.farmstory2.service.ArticleService;
import kr.co.farmstory2.vo.ArticleVO;

@WebServlet("/board/list.do")
public class ListController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	private ArticleService service = ArticleService.INSTANCE;
	
	@Override
	public void init() throws ServletException {}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String group = req.getParameter("group");
		String cate = req.getParameter("cate");
		String pg = req.getParameter("pg");
		String search = req.getParameter("search");
		String searchOption = req.getParameter("searchOption");
		int currentPage = 1;
		int start;
		int total = 0;
		int lastPageNum;
		int currentPageGroup;
		int pageGroupStart;
		int pageGroupEnd;
		int pageStartNum;
		
		if(pg != null) {
			currentPage = Integer.parseInt(pg);
		}
		start = (currentPage - 1)*10;
		
		// 전체 게시물 갯수
		total = service.selectCountTotal(cate);
		
		// 마지막 페이지 번호
		lastPageNum = service.getLastPageNum(total);
		
		// 페이지 그룹 스타트, 엔드
		int[] result = service.getPageGroupNum(currentPage, lastPageNum);
		currentPageGroup = result[0];
		pageGroupStart = result[1];
		pageGroupEnd = result[2];
		
		pageStartNum = total - start +1;
		
		req.setAttribute("start", start);
		req.setAttribute("total", total);
		req.setAttribute("lastPageNum", lastPageNum);
		req.setAttribute("currentPage", currentPage);
		req.setAttribute("currentPageGroup", currentPageGroup);
		req.setAttribute("pageGroupStart", pageGroupStart);
		req.setAttribute("pageGroupEnd", pageGroupEnd);
		req.setAttribute("pageStartNum", pageStartNum);
		
		req.setAttribute("group", group);
		req.setAttribute("cate", cate);
		
		List<ArticleVO> articles = null;
		if(search == null) {
			articles = service.selectArticles(start, cate);
		}else {
			articles = service.selectArticlesByKeyword(cate, searchOption, search, start);
		}
		req.setAttribute("articles", articles);
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/board/list.jsp");
		dispatcher.forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}
}
