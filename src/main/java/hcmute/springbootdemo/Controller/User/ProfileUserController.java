package hcmute.springbootdemo.Controller.User;

import hcmute.springbootdemo.Entity.User;
import hcmute.springbootdemo.Service.IStorageService;
import hcmute.springbootdemo.Service.impl.UserServiceImpl;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.UUID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping(value="/profile_user")
public class ProfileUserController {

    @Autowired
    UserServiceImpl userService;
    @Autowired
    PasswordEncoder passwordEncoder;
    @Autowired
    IStorageService storageService;
    @GetMapping(value="")
    public String profile_user(ModelMap modelMap, HttpSession session){
        int user_id = (int) session.getAttribute("user_id");
        User user = userService.findById(user_id).get();
        modelMap.addAttribute("user", user);
        Date date = user.getDob();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        if(date == null){
            date = new Date();
        }
        String dob = dateFormat.format(date);

        modelMap.addAttribute("dob", dob);


        return "user/profile_user/profile_user";
    }

    @PostMapping(value="update_user")
    public String update( HttpSession session,
                         @RequestParam("firstName") String firstName,
                          @RequestParam("lastName") String lastName,
                         @RequestParam("phoneNumber") String phoneNumber,
                         @RequestParam("image_user") MultipartFile image_user,
                         @RequestParam("dob_user") String dob,
                         @RequestParam("option_gender") String gender,
                         RedirectAttributes redirectAttributes){

        int user_id = (int) session.getAttribute("user_id");
        User user = userService.findById(user_id).get();
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setPhone(phoneNumber);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate date = LocalDate.parse(dob, formatter);
        Date date1 = java.sql.Date.valueOf(date);
        user.setDob(date1);

        try{
            if(image_user.isEmpty()){
                redirectAttributes.addFlashAttribute("message", "Please select a file to upload");
            }else{
                UUID uuid = UUID.randomUUID();
                String uuidAsString = uuid.toString();
                user.setAvatarLink("user/"+ storageService.getSorageFilename(image_user, uuidAsString));
                storageService.store(image_user, user.getAvatarLink());
                redirectAttributes.addFlashAttribute("message", "You successfully uploaded '" + image_user.getOriginalFilename() + "'");
            }
        }catch (Exception e){
            redirectAttributes.addFlashAttribute("error", "Fail to upload '" + image_user.getOriginalFilename() + "'");
        }

        String password = userService.findById(user_id).get().getPasswordHashed();
        user.setPasswordHashed(password);
        user.setId(user_id);


        if(gender.equals("male")){
            user.setGender(true);
        }else{
            if(gender.equals("female")){
                user.setGender(false);
            }
        }


        userService.save(user);
        session.setAttribute("image_user", user.getAvatarLink());
        session.setAttribute("FirstName", user.getFirstName());
        session.setAttribute("LastName", user.getLastName());


        return "redirect:/profile_user/";
    }

    @GetMapping(value="/change_password")
    public String change_password(ModelMap modelMap, HttpSession session){
        return "user/profile_user/change_password";
    }

    @PostMapping(value="/change_password")
    public String change_password(@RequestParam("old_password") String old_password,
                                  @RequestParam("new_password") String new_password,
                                  @RequestParam("renew_password") String confirm_password,
                                  HttpSession session,
                                  RedirectAttributes redirectAttributes){
        int user_id = (int) session.getAttribute("user_id");
        User user = userService.findById(user_id).get();
        if(passwordEncoder.matches(old_password, user.getPasswordHashed())){

            if (new_password.equals(confirm_password) && new_password.length() >= 6) {
                user.setPasswordHashed(passwordEncoder.encode(new_password));
                userService.save(user);
                redirectAttributes.addFlashAttribute("message", "Đổi mật khẩu thành công. Vui lòng đăng nhập lại.");
                return "redirect:/checkout";
            }else{
                if (new_password.length() < 6 || confirm_password.length() < 6) {
                    redirectAttributes.addFlashAttribute("error", "Mật khẩu mới không hợp lệ.");
                    return "redirect:/profile_user/change_password";
                }
                else {
                    redirectAttributes.addFlashAttribute("error", "Mật khẩu mới không khớp.");
                    return "redirect:/profile_user/change_password";
                }
            }

        }else{
            redirectAttributes.addFlashAttribute("error", "Mật khẩu cũ không đúng.");
            return "redirect:/profile_user/change_password";
        }

    }
}
