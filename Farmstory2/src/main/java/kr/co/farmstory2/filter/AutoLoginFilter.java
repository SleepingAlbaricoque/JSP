package kr.co.farmstory2.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.farmstory2.service.UserService;
import kr.co.farmstory2.vo.UserVO;


@WebFilter("/*")
public class AutoLoginFilter implements Filter{
	private UserService service = UserService.INSTANCE;
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		logger.info("autoLoginFilter Called");
		
		HttpServletRequest req = (HttpServletRequest) request;
		HttpSession sess = req.getSession();
		
		Cookie[] cookies = req.getCookies();
		
		if(cookies != null) {
			for(Cookie cookie : cookies) {
				if(cookie.getName().equals("SESSID")) {
					String sessId = cookie.getValue();
					UserVO user = service.selectUserBySessId(sessId);
					
					if(user != null) {
						sess.setAttribute("sessUser", user);
					}
				}
			}
		}
		chain.doFilter(request, response);
	}
}
