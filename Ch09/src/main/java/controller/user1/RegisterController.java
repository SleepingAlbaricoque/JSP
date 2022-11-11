package controller.user1;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.User1Dao;
import vo.User1VO;

@WebServlet("/user1/register.do")
public class RegisterController extends HttpServlet{
	private static final long serialVersionUID = 1L;

	@Override
	public void init() throws ServletException {
		
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// forward to view
		RequestDispatcher dispatcher = req.getRequestDispatcher("/user1/register.jsp");
		dispatcher.forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 인코딩 필터 web.xml에 넣었으므로 여기서 setCharacter 메서드 쓸 필요 x
		String uid = req.getParameter("uid");
		String name = req.getParameter("name");
		String hp = req.getParameter("hp");
		String age = req.getParameter("age");
		
		User1VO vo = new User1VO();
		vo.setUid(uid);
		vo.setName(name);
		vo.setHp(hp);
		vo.setAge(age);
		
		User1Dao.getInstance().insertUser(vo);
		
		// redirect(서버가 클라이언트에 응답)
		resp.sendRedirect("/Ch09/user1/list.do");
	}
}
