package kr.co.onlinevote.controller.admin;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.onlinevote.dao.VoterDAO;
import kr.co.onlinevote.vo.VoterVO;

@WebServlet("/admin/adminLogin.do")
public class AdminLoginController extends HttpServlet{
	private static final long serialVersionUID = 1L;

	@Override
	public void init() throws ServletException {}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		VoterVO sessUser = (VoterVO) session.getAttribute("sessUser");
		
		if(sessUser != null) {
			resp.sendRedirect("/OnlineVote/admin/menu.do");
		}else {
			RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/admin/adminLogin.jsp");
			dispatcher.forward(req, resp);
		}
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String id = req.getParameter("id");
		String pass = req.getParameter("pass");
		
		VoterVO vo = VoterDAO.getInstance().selectVoter(id, pass);
		
		if(vo != null) {
			HttpSession session = req.getSession();
			session.setAttribute("sessUser", vo);
			
			resp.sendRedirect("/OnlineVote/voter/menu.do");
		}else {
			resp.sendRedirect("/OnlineVote/login.do");
		}
	}
}
