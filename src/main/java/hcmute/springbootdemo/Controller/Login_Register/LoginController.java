package hcmute.springbootdemo.Controller.Login_Register;

import hcmute.springbootdemo.Entity.User;
import hcmute.springbootdemo.Service.IUserService;
import hcmute.springbootdemo.Service.impl.CartServiceImpl;
import hcmute.springbootdemo.Service.impl.EmailServiceImpl;
import hcmute.springbootdemo.Service.impl.ProductServiceImpl;
import java.util.Optional;
import java.util.regex.Pattern;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping(path= "/login")
public class LoginController {

    @Autowired
    IUserService userService;
    @Autowired
    CartServiceImpl cartService;
    @Autowired
    ProductServiceImpl productService;
    @Autowired
    EmailServiceImpl emailService;
    @Autowired
    PasswordEncoder passwordEncoder;

    // Pattern để kiểm tra định dạng email
    private static final Pattern EMAIL_PATTERN =
            Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$");

    // Phương thức kiểm tra email có hợp lệ không
    private boolean isValidEmailFormat(String email) {
        return EMAIL_PATTERN.matcher(email).matches();
    }

    @GetMapping(value="")
    public String login (){
        return "login/login";
    }

    @GetMapping(value="/fill_email")
    public String fill_email(){
        return "login/fill_email";
    }

    @PostMapping(value="/fill_email") // forgot password
    public String fill_email(@RequestParam("email") String email,
                             RedirectAttributes redirectAttributes,
                             HttpSession session){

        // Kiểm tra định dạng email trước khi tìm kiếm
        if (!isValidEmailFormat(email)) {
            redirectAttributes.addFlashAttribute("error", "Email không hợp lệ");
            return "redirect:/login/fill_email";
        }

        Optional<User> userOpt = userService.findUserByEmail(email);
        if(userOpt.isPresent()){
            User user = userOpt.get();
            String code = emailService.generateRandomCode();
            user.setPasswordHashed(passwordEncoder.encode(code));
            userService.save(user);
            // send email
            String subjectLogin = "[Fashion Shop] Quên mật khẩu";
            String text = "Mật khẩu mới của bạn là: " + code + "\n" +
                    "Hãy đổi mật khẩu ngay khi có thể.";
            emailService.sendSimpleMessage(email,subjectLogin,text);

            return "redirect:/login";
        }
        else{
            redirectAttributes.addFlashAttribute("error","Email chưa được đăng ký");
            return "redirect:/login/fill_email";
        }
    }

    @GetMapping(value="fill_code")
    public String fill_code(){
        return "register/fill_code";
    }

}
