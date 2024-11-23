package hcmute.springbootdemo.Controller.User;

import hcmute.springbootdemo.Entity.Product;
import hcmute.springbootdemo.Entity.Review;
import hcmute.springbootdemo.Entity.User;
import hcmute.springbootdemo.Service.impl.ProductServiceImpl;
import hcmute.springbootdemo.Service.impl.ReviewServiceImpl;
import hcmute.springbootdemo.Service.impl.UserServiceImpl;
import java.util.Date;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping(path="review")
public class ReviewUserController {

    @Autowired
    ReviewServiceImpl reviewService;
    @Autowired
    ProductServiceImpl productService;
    @Autowired
    UserServiceImpl userService;

    @PostMapping(value="/add/{id}")
    public String contact(@ModelAttribute("post_review") Review review,
                          ModelMap modelMap, @PathVariable(value = "id") int id ,
                          HttpSession session,
                          RedirectAttributes redirectAttributes,
                          @RequestParam("rating") int rating){
        Product product= productService.findById(id).get();
        User user = userService.findUserById((int) session.getAttribute("user_id"));

        Date date = new Date();
        review.setCreatedAt(date);
        review.setRating(rating);
        review.setProduct(product);
        review.setUser(user);
        int maxId = reviewService.getMaxId();
        if(maxId == 0){
            review.setId(1);
        }
        else{
            review.setId(maxId + 1);
        }
//        review.setId(reviewService.getMaxId() + 1);
        reviewService.save(review);

        modelMap.addAttribute("success", "Đánh giá thành công");

        return "redirect:/product/{id}";
    }

}
