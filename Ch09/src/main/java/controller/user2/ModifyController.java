package controller.user2;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.User2Dao;
import vo.User2VO;

@WebServlet("/user2/modify.do")
public class ModifyController extends HttpServlet{
	private static final long serialVersionUID = 1L;

	@Override
	public void init() throws ServletException {
		
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uid = req.getParameter("uid");
		User2VO vo = User2Dao.getInstance().selectUser(uid);
		
		req.setAttribute("vo", vo);
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/user2/modify.jsp");
		dispatcher.forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		User2VO vo = new User2VO();
		
		String uid = req.getParameter("uid");
		String name = req.getParameter("name");
		String hp = req.getParameter("hp");
		String age = req.getParameter("age");
		
		vo.setUid(uid);
		vo.setName(name);
		vo.setHp(hp);
		vo.setAge(age);
		
		User2Dao.getInstance().updateUser(vo);
		
		resp.sendRedirect("/Ch09/user2/list.do");
	}
}
