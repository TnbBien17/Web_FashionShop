package hcmute.springbootdemo.Config;

import hcmute.springbootdemo.Entity.User;
import java.io.IOException;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Component
public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
            Authentication authentication) throws IOException, ServletException {
        User user = (User) authentication.getPrincipal();
        HttpSession session = request.getSession();
        session.setAttribute("user", user);
        session.setAttribute("user_id", user.getId());
        session.setAttribute("image_user",user.getAvatarLink());
        session.setAttribute("FirstName",user.getFirstName());
        session.setAttribute("LastName",user.getLastName());
        boolean isAdmin = user.getIsAdmin();
        if (isAdmin) {
            response.sendRedirect("/admin");
        } else {
            response.sendRedirect("/");
        }
    }
    
}
