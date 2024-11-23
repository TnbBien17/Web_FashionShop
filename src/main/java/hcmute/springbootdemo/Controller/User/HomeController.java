package hcmute.springbootdemo.Controller.User;

import hcmute.springbootdemo.Entity.Cart;
import hcmute.springbootdemo.Entity.Product;
import hcmute.springbootdemo.Repository.Cart_ProductRepository;
import hcmute.springbootdemo.Repository.CategoryRepository;
import hcmute.springbootdemo.Service.IProductService;
import hcmute.springbootdemo.Service.impl.CartServiceImpl;
import hcmute.springbootdemo.Service.impl.UserServiceImpl;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping(value="")
public class HomeController {

    @Autowired
    CategoryRepository categoryRepository;

    @Autowired
    Cart_ProductRepository cart_productRepository;

    @Autowired
    IProductService productService;

    @Autowired
    CartServiceImpl cartService;

    @Autowired
    UserServiceImpl userService;

    @GetMapping(value="")
    public String home (ModelMap model, HttpSession session){
        model.addAttribute("latestProduct", productService.get10Newest());    
        model.addAttribute("bestProduct", productService.get10Best());
//        session.setAttribute("CountProduct",cart_productRepository.count());

        //----------------------------
        //thực thi cac chuc nang cua user
        if(session.getAttribute("user_id") == null){
            String image= (String)session.getAttribute("image_user");
            if(image == null){
                session.setAttribute("image_user","https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png");
            }

        }
        else{
            int user_id = (int)session.getAttribute("user_id");
            int countCart = 0;
            List<Cart> listCart = cartService.findCartByUserId(user_id);
            for(Cart cart:listCart){
                if(cart.getActive() == true){
                    countCart++;
                }
            }
            session.setAttribute("CountCart", countCart);
            //----------------------------
        }
        List<Product> listProduct = productService.findAll();
        session.setAttribute("listProduct", listProduct);

        return "user/main";
    }
    
}
