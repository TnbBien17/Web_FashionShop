package hcmute.springbootdemo.Config;

import java.io.IOException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.FlashMapManager;
import org.springframework.web.servlet.support.SessionFlashMapManager;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Component
public class CustomAuthenticationFailureHandler implements AuthenticationFailureHandler {

    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
            AuthenticationException exception) throws IOException, ServletException {
        String error = "";
        // bad credentials
        if (exception.getMessage().equals("Bad credentials")) {
            error = "Sai tên đăng nhập hoặc mật khẩu";
        }
        // account is disabled
        else if (exception.getMessage().equals("User is disabled")) {
            error = "Tài khoản đã bị khóa";
        }
        // use flash attribute to display error message
        FlashMap flashMap = new FlashMap();
        flashMap.put("error", error);
        FlashMapManager flashMapManager = new SessionFlashMapManager();
        flashMapManager.saveOutputFlashMap(flashMap, request, response);
        response.sendRedirect("/login");
    }
    
}
