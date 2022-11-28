package kr.co.jboard2.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.jboard2.dao.ArticleDAO;
import kr.co.jboard2.service.ArticleService;
import kr.co.jboard2.vo.ArticleVO;
import kr.co.jboard2.vo.PageVO;
import kr.co.jboard2.vo.UserVO;

@WebServlet("/list.do")
public class ListController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	private ArticleService service = ArticleService.INSTANCE;
	
	@Override
	public void init() throws ServletException {}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String pg = req.getParameter("pg");
		String search = req.getParameter("search");
		int currentPage =1;
		int start;
		int currentPageGroup = 0;
		int pageGroupStart = 0;
		int pageGroupEnd = 0;
		int total = 0;
		int pageStartNum = 0;
		
		if(pg != null) {
			currentPage = Integer.parseInt(pg);
		}
		
		start = (currentPage - 1)*10;
		
		
		// 전체 게시물 갯수
		if(search == null) {
			total = service.selectCountTotal();
		}else {
			total = service.selectCountTotalForSearch(search);
		}
		
		// 마지막 페이지 번호
		int lastPageNum = service.getLastPageNum(total);
		
		// 페이지 그룹 스타트, 엔드
		int[] result = service.getPageGroupNum(currentPage, lastPageNum);
		
		pageStartNum = total - start;
		
		PageVO page = new PageVO();
		page.setStart(start);
		page.setTotal(total);
		page.setLastPageNum(lastPageNum);
		page.setCurrentPage(currentPage);
		page.setCurrentPageGroup(result[0]);
		page.setPageGroupStart(result[1]);
		page.setPageGroupEnd(result[2]);
		page.setPageStartNum(pageStartNum+1); // 안그러면 리스트에 뜰 때 첫 번째 글 번호가 0으로 보임(pageStartNum = pageStartNum -1으로 대입해서)
		req.setAttribute("page", page);
		req.setAttribute("search", search);
		
		List<ArticleVO> articles = null;
		if(search == null) {
			articles = service.selectArticles(start);
		}else {
			articles = service.selectArticleByKeyword(search, start);
		}
		req.setAttribute("articles", articles);
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/list.jsp");
		dispatcher.forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}
}
