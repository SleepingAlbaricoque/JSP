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

@WebServlet("/user/info.do")
public class InfoController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	private UserService service = UserService.INSTANCE;
	
	@Override
	public void init() throws ServletException {}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RequestDispatcher dispatcher = req.getRequestDispatcher("/user/info.jsp");
		dispatcher.forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String pass = req.getParameter("pass");
		String uid = req.getParameter("uid");
		
		UserVO user = service.selectUser(uid, pass);
		
		JsonObject json = new JsonObject();
		int result = 0;
		
		if(user != null) {
			result = 1;
		}
		
		json.addProperty("result", result);
		
		PrintWriter writer = resp.getWriter();
		writer.print(json.toString());
	}
}
