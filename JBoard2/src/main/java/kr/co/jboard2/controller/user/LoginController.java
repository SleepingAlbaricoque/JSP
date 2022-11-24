package kr.co.jboard2.controller.user;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.jboard2.dao.UserDAO;
import kr.co.jboard2.vo.UserVO;

@WebServlet("/user/login.do")
public class LoginController extends HttpServlet{
	private static final long serialVersionUID = 1L;

	@Override
	public void init() throws ServletException {}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 로그인 여부에 따라 페이지 이동
		HttpSession sess = req.getSession();
		UserVO sessUser = (UserVO) sess.getAttribute("sessUser");
		
		if(sessUser != null) {
			resp.sendRedirect("/JBoard2/user/login.do");
		}else {	
			RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/user/login.jsp");
			dispatcher.forward(req, resp);
		}
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 데이터 수신
		String uid = req.getParameter("uid");
		String pass = req.getParameter("pass");
		String auto = req.getParameter("auto"); // login.jsp 아이디 기억하기 부분
		
		// db 처리
		UserDAO dao = UserDAO.getInstance();
		UserVO vo = dao.selectUser(uid, pass);
		
		// 로그인 처리
		if(vo != null) {
			// 회원 맞음
			HttpSession session = req.getSession(); // 클라이언트(req)의 세션 구함
			session.setAttribute("sessUser", vo);
			
			// 자동로그인 확인
			if(auto != null) { // 유저가 자동 로그인 체크한 것
				String sessId = session.getId();
				
				// 쿠키 생성
				Cookie cookie = new Cookie("SESSID", sessId);
				cookie.setPath("/"); // 요청에 대한 전체 경로; 경로를 루트로 해놔야 모든 요청 처리 가능
				cookie.setMaxAge(60*60*24*3); // 분 * 시간 * 하루 * 삼 일
				resp.addCookie(cookie);
				
				// 세션 정보 데이터베이스 저장
				dao.updateUserForSession(uid, sessId);
			}
			
			resp.sendRedirect("/JBoard2/list.do");
			
		}else {
			// 회원 아님
			resp.sendRedirect("/JBoard2/user/login.do?success=100");
		}
	}
}
