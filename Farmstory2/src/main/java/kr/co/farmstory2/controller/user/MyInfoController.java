package kr.co.farmstory2.controller.user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;

import kr.co.farmstory2.service.UserService;
import kr.co.farmstory2.vo.UserVO;

@WebServlet("/user/myInfo.do")
public class MyInfoController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	private UserService service = UserService.INSTANCE;
	
	@Override
	public void init() throws ServletException {}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uid = req.getParameter("uid");
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/user/myInfo.jsp");
		dispatcher.forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uid = req.getParameter("uid");
		String pass = req.getParameter("pass");
		String modify = req.getParameter("modify");
		
		String name = req.getParameter("name");
		String nick = req.getParameter("nick");
		String email = req.getParameter("email");
		String hp = req.getParameter("hp");
		String zip = req.getParameter("zip");
		String addr1 = req.getParameter("addr1");
		String addr2 = req.getParameter("addr2");
		
		// 비밀번호 변경
		if(modify != null) {
			int result = service.updatePass(uid, pass);
			
			JsonObject json = new JsonObject();
			json.addProperty("result", result);
			
			PrintWriter writer = resp.getWriter();
			writer.print(json.toString());
		}
		// 회원정보 변경
		UserVO user = new UserVO();
		user.setUid(uid);
		user.setName(name);
		user.setNick(nick);
		user.setEmail(email);
		user.setHp(hp);
		user.setZip(zip);
		user.setAddr1(addr1);
		user.setAddr2(addr2);
		
		int result2 = service.updateUser(user);
		if(result2 > 0) {
			resp.sendRedirect("/Farmstory2/user/myInfo.do?uid=" + uid);
		}
	}
}
