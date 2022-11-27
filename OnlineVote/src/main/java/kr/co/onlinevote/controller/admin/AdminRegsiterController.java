package kr.co.onlinevote.controller.admin;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.onlinevote.service.VoterService;
import kr.co.onlinevote.vo.VoterVO;

@WebServlet("/admin/adminRegister.do")
public class AdminRegsiterController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	private VoterService service = VoterService.INSTANCE;
	
	@Override
	public void init() throws ServletException {}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/admin/adminRegister.jsp");
		dispatcher.forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String name = req.getParameter("name");
		String hp = req.getParameter("hp");
		String id = req.getParameter("id");
		String password = req.getParameter("password");
		
		VoterVO admin = new VoterVO();
		admin.setName(name);
		admin.setBirth("2022-11-27");
		admin.setFile(0);
		admin.setHp(hp);
		admin.setEmail("admin@voteAdm.com");
		admin.setIs_admin(1);
		admin.setId(id);
		admin.setPassword(password);
		
		service.insertVoter(admin);
		
		resp.sendRedirect("/OnlineVote/admin/adminLogin.do");
	}
}
