package kr.co.farmstory2.controller.user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.JsonObject;

import kr.co.farmstory2.service.ArticleService;
import kr.co.farmstory2.service.UserService;
import kr.co.farmstory2.vo.UserVO;

@WebServlet("/user/login.do")
public class LoginController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	private UserService service = UserService.INSTANCE;
	
	@Override
	public void init() throws ServletException {}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String success = req.getParameter("success");
		req.setAttribute("success", success);
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/user/login.jsp");
		dispatcher.forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uid = req.getParameter("uid");
		String pass = req.getParameter("pass");
		String auto = req.getParameter("auto");
		
		UserVO user = service.selectUser(uid, pass);
			
		if(user !=null && user.getWdate() == null) {
			HttpSession session = req.getSession();
			session.setAttribute("sessUser", user);
			
			// 자동로그인 확인
			if(auto != null) {
				String sessId = session.getId();
				
				Cookie cookie = new Cookie("SESSID", sessId);
				cookie.setPath("/");
				cookie.setMaxAge(60*60*24*3);
				resp.addCookie(cookie);
				
				service.updateUserForSession(uid, sessId);
			}
			
			resp.sendRedirect("/Farmstory2/index.do"); // list.do로 가게 해야 함
		}else if(user !=null && user.getWdate() != null){ // 탈퇴한 회원 막기; 이런 식으로 if-else if문 작성해야 success 111값은 보내지만 sessUser는 생성되는 일 막을 수 있음
			resp.sendRedirect("/Farmstory2/user/login.do?success=111");
		}else {
			resp.sendRedirect("/Farmstory2/user/login.do?success=100");
		}
		
	}
}
