package org.atree.interceptor;

import java.net.URLEncoder;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.atree.domain.BoardVO;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import lombok.extern.log4j.Log4j;


@Log4j
public class ViewInterceptor extends HandlerInterceptorAdapter{

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		Cookie[] cks=request.getCookies();
		log.info("cookie checker................................................");
		boolean check=false;
		
		Object result=modelAndView.getModel().get("board");
		BoardVO boardVO=(BoardVO)result;
		
		log.info(result);
		if(result==null) {
			return;
		}
		
		
		for (int i=0;i<cks.length;i++) {
			if(cks[i].getName().equals("viewCookie")) {
				check=true;
				log.info("cookievalue:"+cks[i].getValue());
				
			
				if(cks[i].getValue().equals(""+boardVO.getBno())) {
					break;
				}
				String value=(String)(cks[i].getValue())+"_"+boardVO.getBno();
				Cookie viewCookie=new Cookie("viewCookie",URLEncoder.encode(value,"UTF-8"));
				response.addCookie(viewCookie);
				log.info(cks[i].getValue());
				break;
			}
		}
		log.info("Login check result: "+check);
		if(check==false) {
		
			
			Cookie viewCookie=new Cookie("viewCookie",URLEncoder.encode(""+boardVO.getBno(), "UTF-8"));
			viewCookie.setMaxAge(60*60*3);
			response.addCookie(viewCookie);
		
		
		}
	
		
		
	}

	
}
