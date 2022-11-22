package kr.co.jboard2.controller.user;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;
import java.util.concurrent.ThreadLocalRandom;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;

@WebServlet("/user/emailAuth.do")
public class EmailAuthController extends HttpServlet{
	private static final long serialVersionUID = 1L;

	@Override
	public void init() throws ServletException {}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String receiverEmail = req.getParameter("email"); // 인증코드를 수신 받을 이메일
		
		// 인증코드 생성
		int code = ThreadLocalRandom.current().nextInt(100000, 1000000);
		
		// 기본 정보
		String sender = "tnqls0421@gmail.com";
		String password = "semzvrikbtdgzxfm"; // 2단계 인증 설정 후 앱 비밀번호 입력하기
		
		String title = "JBoard2 인증코드 입니다.";
		String content = "인증코드 6자리는 " + code + " 입니다.";
		
		// Gmail SMTP 정보 설정
		Properties props = new Properties(); // key-value chain
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "465");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.ssl.enable", "true");
		props.put("mail.smtp.trust", "smtp.gmail.com");
		
		// 미리 등록한 사용자 정보를 가지고 Gmail 서버 인증(session은 인증 객체)
		Session session = Session.getInstance(props, new Authenticator() { // java.mail의 클래스, 익명 클래스
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(sender, password);
			}
		});
		
		// 이메일 발송
		Message message = new MimeMessage(session);
		
		int status = 0; // 1은 성공, 0은 실패
		
		try {
			System.out.println("발송 시작");
			
			message.setFrom(new InternetAddress(sender, "관리자", "UTF-8"));
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(receiverEmail));
			message.setSubject(title);
			message.setContent(content, "text/html;charset=utf-8");
			Transport.send(message);
			System.out.println("메일 전송 성공");
			status = 1;
			
		}catch(Exception e) {
			e.printStackTrace();
			status = 0;
			System.out.println("메일 전송 실패");
		}
		
		//json 출력
		JsonObject json = new JsonObject();
		json.addProperty("status", status);
		json.addProperty("code", code);
		
		PrintWriter writer = resp.getWriter();
		writer.print(json.toString());
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {}
}
