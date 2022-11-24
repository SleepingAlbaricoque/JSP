package kr.co.onlinevote.controller.voter;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.co.onlinevote.dao.VoterDAO;
import kr.co.onlinevote.vo.VoterVO;

@WebServlet("/voter/register.do")
public class RegisterController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	@Override
	public void init() throws ServletException {}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/voter/register.jsp");
		dispatcher.forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		VoterDAO dao = VoterDAO.getInstance();
		
		// multipart 전송 데이터 수신
		ServletContext servletContext = req.getSession().getServletContext();
		String savePath = servletContext.getRealPath("/file");
		int maxSize = 1024 * 1024 * 10; // 파일 업로드 10메가까지 허용
		MultipartRequest mr = new MultipartRequest(req, savePath , maxSize , "UTF-8", new DefaultFileRenamePolicy());
		
		String name = mr.getParameter("name");
		String birth = mr.getParameter("birth");
		String fname = mr.getFilesystemName("fname");
		String hp = mr.getParameter("hp");
		String email = mr.getParameter("email");
		String id = mr.getParameter("id");
		String password = mr.getParameter("password");
		
		VoterVO voter = new VoterVO();
		voter.setName(name);
		voter.setBirth(birth);
		voter.setFname(fname);
		voter.setHp(hp);
		voter.setEmail(email);
		voter.setIs_admin(0);
		voter.setId(id);
		voter.setPassword(password);
		
		dao.insertVoter(voter);
		
		if(fname != null) {
			// 파일명 수정
			int idx = fname.lastIndexOf("."); // 확장자 바로 앞의 점을 찾는 것
			String ext = fname.substring(idx); // 파일명 중 확장자만 잘라낸 것
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss_");
			String now = sdf.format(new Date());
			String newName = now + name + ext; // ex. 20221026111425_tnqls0421.txt
			
			File oriFile = new File(savePath + "/" + fname); // 스트림; 업로드 된 파일(oriFile)을 파일 객체화
			File newFile = new File(savePath + "/" + newName);
			
			oriFile.renameTo(newFile);
			
			// voter regNo 불러오기
			int regNo = dao.selectRegNo(id);
			
			// 파일 테이블에 파일 정보 저장
			dao.insertFile(regNo, newName, fname);
		}
		
		resp.sendRedirect("/OnlineVote/login.do");
	}
}
