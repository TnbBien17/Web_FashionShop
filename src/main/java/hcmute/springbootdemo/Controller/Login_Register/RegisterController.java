package hcmute.springbootdemo.Controller.Login_Register;


import hcmute.springbootdemo.Entity.Cart;
import hcmute.springbootdemo.Entity.User;
import hcmute.springbootdemo.Repository.UserRepository;
import hcmute.springbootdemo.Service.IUserService;
import hcmute.springbootdemo.Service.impl.CartServiceImpl;
import hcmute.springbootdemo.Service.impl.EmailServiceImpl;
import java.util.Random;
import java.util.regex.Pattern;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

@Controller
@RequestMapping(path="/register")
public class RegisterController {


    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    UserRepository userRepository;

    @Autowired
    IUserService userService;

    @Autowired
    private CartServiceImpl cartService;

    @Autowired
    EmailServiceImpl emailService;

    // Regular expression for validating email format
    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[A-Za-z0-9+_.-]+@(.+)$");

    @GetMapping(value="")
    public String register(ModelMap modelMap){
        modelMap.addAttribute("new_user",new User());
        return "register/register";
    }

    @PostMapping(value="/register2")
    public String register2(ModelMap modelMap,
                            @Valid @ModelAttribute("new_user")User user, HttpSession session,
                            @RequestParam("re-password") String repassword,
                            RedirectAttributes redirectAttributes){
        try{
            String email = user.getEmail();
            String password = user.getPasswordHashed();

            // Check if email or password is empty
            if (email.isEmpty() || password.isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Vui lòng nhập đầy đủ thông tin");
                return "redirect:/register/";
            }

            // Validate email format
            if (!EMAIL_PATTERN.matcher(email).matches()) {
                redirectAttributes.addFlashAttribute("error", "Email không hợp lệ");
                return "redirect:/register/";
            }

            // Check if password meets minimum length requirement
            if (password.length() < 6) {
                redirectAttributes.addFlashAttribute("error", "Mật khẩu không hợp lệ, mật khẩu hợp lệ >=6 ký tự");
                return "redirect:/register/";
            }

            // Check if email is already registered
            if (userRepository.findUserByEmail(email).isPresent()) {
                redirectAttributes.addFlashAttribute("error", "Email này đã được sử dụng");
                return "redirect:/register/";
            }

            // Check if passwords match
            if (!repassword.equals(password)) {
                redirectAttributes.addFlashAttribute("error", "Mật khẩu không khớp");
                return "redirect:/register/";
            }

            // Set default values and hash the password
            user.setActive(false);
            user.setIsAdmin(false);
            user.setFirstName("New user");
            user.setLastName("");
            user.setPasswordHashed(passwordEncoder.encode(password));

            // Generate verification code
            user.setCode(emailService.generateRandomCode());
            userRepository.save(user);

            // Save user to session
            session.setAttribute("user", user);

            // Send verification email
            String subject = "[Fashion Shop] Xác nhận đăng ký tài khoản";
            String message = "Mã xác nhận của bạn là: " + user.getCode();
            emailService.sendSimpleMessage(email, subject, message);

            return "redirect:/register/verify";
        }catch(Exception e){
            redirectAttributes.addFlashAttribute("error","Đăng ký thất bại");
            return "redirect:/register/";
        }
    }

    @GetMapping(value="/verify")
    public String verify(ModelMap modelMap){
        return "register/fill_code";
    }

    @PostMapping(value="/verify")
    public String verify(ModelMap modelMap,
                         @RequestParam("authcode") String code,
                         HttpSession session,
                         RedirectAttributes redirectAttributes){
        try{
            User user = (User) session.getAttribute("user");
            if(user.getCode().equals(code)){
                user.setActive(true);
                user.setCode("");
                userRepository.save(user);

               // Tạo giỏ hàng cho user
                Cart defaultCart = new Cart();

                defaultCart.setActive(true);
                defaultCart.setName("GioHang");
                defaultCart.setUser(user);

                cartService.save(defaultCart);  // Lưu giỏ hàng vào cơ sở dữ liệu

                session.setAttribute("user",user);
                redirectAttributes.addFlashAttribute("message","Đăng ký thành công!");
                return "redirect:/login/";
            }
            else{
                redirectAttributes.addFlashAttribute("error","Mã xác nhận không đúng");
                return "redirect:/register/verify";
            }
        }catch(Exception e){
            redirectAttributes.addFlashAttribute("error","Xác nhận thất bại");
            return "redirect:/register/verify";
        }
    }

    public static String randomString(int n) {
        String AlphaNumericString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                                    + "0123456789"
                                    + "abcdefghijklmnopqrstuvxyz";
        StringBuilder sb = new StringBuilder(n);
        Random random = new Random();
        for(int i = 0; i < n; i++) {
            int index = random.nextInt(AlphaNumericString.length());
            sb.append(AlphaNumericString.charAt(index));
        }
        return sb.toString();
    }
}
