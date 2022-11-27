package kr.co.onlinevote.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.coyote.http11.upgrade.UpgradeServletOutputStream;

import kr.co.onlinevote.dao.VoterDAO;
import kr.co.onlinevote.service.VoterService;
import kr.co.onlinevote.vo.VoterVO;

@WebServlet("/login.do")
public class LoginController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	private VoterService service = VoterService.INSTANCE;

	@Override
	public void init() throws ServletException {}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		VoterVO sessUser = (VoterVO) session.getAttribute("sessUser");
		
		Cookie[] cookies = req.getCookies();
		
		if(cookies != null) {
			for(Cookie cookie : cookies) {
				if(cookie.getName().equals("SESSID")) {
					
					String sessId = cookie.getValue();
					VoterVO vo = service.selectVoterBySessId(sessId);
					
					if(vo != null) {
						session.setAttribute("sessUser", vo);
					}
				}
			}
		}
		if(sessUser != null) {
			resp.sendRedirect("/OnlineVote/voter/menu.do");
		}else {	
			RequestDispatcher dispatcher = req.getRequestDispatcher("/login.jsp");
			dispatcher.forward(req, resp);
		}
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String id = req.getParameter("id");
		String password = req.getParameter("password");
		String auto = req.getParameter("auto");
		
		VoterVO vo = service.selectVoter(id, password);
		
		if(vo != null) {
			HttpSession session = req.getSession();
			session.setAttribute("sessUser", vo);
			
			if(auto != null) {
				String sessId = session.getId();
				
				// 쿠키 생성
				Cookie cookie = new Cookie("SESSID", sessId);
				cookie.setPath("/");
				cookie.setMaxAge(60*60*24*3);
				resp.addCookie(cookie);
				
				// 세션 정보 데이터베이스 저장
				service.updateVoterForSession(id, sessId);
			}
			
			resp.sendRedirect("/OnlineVote/voter/menu.do");
		}else {
			resp.sendRedirect("/OnlineVote/login.do");
		}
	}
}
