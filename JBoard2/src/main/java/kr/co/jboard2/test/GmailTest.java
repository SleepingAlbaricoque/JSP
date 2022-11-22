package kr.co.jboard2.test;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class GmailTest {
	public static void main(String[] args) {
		// 기본 정보
		String sender = "tnqls0421@gmail.com";
		String password = "semzvrikbtdgzxfm"; // 2단계 인증 설정 후 앱 비밀번호 입력하기
		
		String receiver = "tnqls0421@naver.com";
		String title = "test mail";
		String content = "테스트 완료";
		
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
		
		try {
			System.out.println("발송 시작");
			
			message.setFrom(new InternetAddress(sender, "관리자", "UTF-8"));
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(receiver));
			message.setSubject(title);
			message.setContent(content, "text/html;charset=utf-8");
			Transport.send(message);
			System.out.println("메일 전송 성공");
			
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("메일 전송 실패");
		}
		
	}
}
