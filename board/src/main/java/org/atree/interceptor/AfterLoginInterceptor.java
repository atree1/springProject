package org.atree.interceptor;


import java.net.URLEncoder;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.atree.domain.UserVO;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import lombok.extern.log4j.Log4j;


@Log4j
public class AfterLoginInterceptor extends HandlerInterceptorAdapter{
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		Cookie[] cks=request.getCookies();
		log.info("cookie checker................................................");
		boolean check=false; 
		if(cks==null||cks.length==0) {
			response.sendRedirect("/");
			return false;
		}
		for (Cookie cookie : cks) {
			if(cookie.getName().equals("lcookie")) {
				check=true;
				
				break;
			}
		}

		log.info("Login check result: "+check);
		if(check==true) {
		response.sendRedirect("/board/list");
		return super.preHandle(request, response, handler);
		}
		
		return true;
	}
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		
		Object result=modelAndView.getModel().get("user");
		log.info("result:"+result);
		log.info(result==null);
		if(result==null) {
			return;
		}
		UserVO userVO=(UserVO)result;
		
		Cookie loginCookie=new Cookie("lcookie",URLEncoder.encode(userVO.getUserid(), "UTF-8"));
		
		log.info(loginCookie);
		loginCookie.setMaxAge(60*60);
		loginCookie.setPath("/"); 
		response.addCookie(loginCookie);
		
		log.info(userVO);
		
		
	}

	
}
