package hcmute.springbootdemo.Controller.Admin;

import hcmute.springbootdemo.Entity.User;
import hcmute.springbootdemo.Service.IUserService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/customer")
public class CustomerController {
    @Autowired
    IUserService userService;

    @GetMapping(value = "")
    public String index(ModelMap model){
        model.addAttribute("active", "customer");
        List<User> users = userService.findByIsAdmin(false);
        model.addAttribute("list", users);
        return "admin/customer";
    }

    @GetMapping(value = "banOrUnban/{id}")
    public String banOrUnban(@PathVariable("id") int id, RedirectAttributes redirectAttributes){
        User user = userService.findById(id).get();
        user.setActive(!user.getActive());
        userService.save(user);
        redirectAttributes.addFlashAttribute("message", "Thao tác thành công!");

        return "redirect:/admin/customer";
    }
    
}
