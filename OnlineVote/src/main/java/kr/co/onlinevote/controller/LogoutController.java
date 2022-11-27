package kr.co.onlinevote.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.onlinevote.service.VoterService;

@WebServlet("/logout.do")
public class LogoutController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	private VoterService service = VoterService.INSTANCE;
	
	@Override
	public void init() throws ServletException {}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String id = req.getParameter("id");
		int result = service.selectVoter(id);
		
		HttpSession session = req.getSession();
		
		// 세션 제거
		session.removeAttribute("sessUser");
		session.invalidate();
		
		// 쿠키 제거
		Cookie cookie = new Cookie("SESSID", null);
		cookie.setPath("/");
		cookie.setMaxAge(0);
		resp.addCookie(cookie);
		
		// 데이터베이스에서 세션아이디값 제거
		service.updateVoterForSessionOut(id);
		
		if(result == 0) {
			resp.sendRedirect("/OnlineVote/login.do");
		}else {
			resp.sendRedirect("/OnlineVote/admin/adminLogin.do");
		}
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {}
}
