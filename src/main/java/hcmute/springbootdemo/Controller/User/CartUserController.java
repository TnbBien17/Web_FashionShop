package hcmute.springbootdemo.Controller.User;

import hcmute.springbootdemo.Entity.Cart;
import hcmute.springbootdemo.Entity.Cart_Product;
import hcmute.springbootdemo.Entity.User;
import hcmute.springbootdemo.Service.impl.CartServiceImpl;
import hcmute.springbootdemo.Service.impl.Cart_ProductServiceImpl;
import hcmute.springbootdemo.Service.impl.ProductServiceImpl;
import hcmute.springbootdemo.Service.impl.UserServiceImpl;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping(path="cart")
public class CartUserController {

    @Autowired
    ProductServiceImpl productService;

    @Autowired
    Cart_ProductServiceImpl cart_productService;

    @Autowired
    CartServiceImpl cartService;

    @Autowired
    UserServiceImpl userService;


    @GetMapping(value=" ")
    public String listCart(ModelMap modelMap, HttpSession session){

        int user_id = (int) session.getAttribute("user_id");
        List<Cart> listCart = cartService.findCartByUserId(user_id);

        modelMap.addAttribute("listCartUser", listCart);

        List<Integer> countProductByCartID = new ArrayList<>();
        List<Integer> totalPriceByCartID = new ArrayList<>();

        List<Integer> totalQuantityByCartID = new ArrayList<>();

        for (Cart cart : listCart){
            int productcart= cart_productService.countCart_ProductsByCartId(cart.getId());


            int total = cart_productService.sumTotalProductByCartID(cart.getId());

            // Tính tổng số lượng sản phẩm (quantity) trong Cart
            int totalQuantity = cart_productService.sumTotalQuantityByCartID(cart.getId());
            totalQuantityByCartID.add(totalQuantity);

            countProductByCartID.add(productcart);
            totalPriceByCartID.add(total);
        }
        modelMap.addAttribute("countProductByCartID", countProductByCartID);
        modelMap.addAttribute("totalPriceByCartID", totalPriceByCartID);
        modelMap.addAttribute("totalQuantityByCartID", totalQuantityByCartID);

        return "user/cart/listCart";
    }

    @GetMapping(value="/{id}")
    public String cartDetail(ModelMap modelMap,@PathVariable("id") int id,HttpSession session){
        List<Cart_Product> listCartProduct = cart_productService.findCart_ProductsByCartId(id);
        modelMap.addAttribute("listCartProduct", listCartProduct);
        float totalPrice = cart_productService.sumTotalProductByCartID(id);
        modelMap.addAttribute("totalPrice", totalPrice);
        session.setAttribute("totalPrice", totalPrice);
        session.setAttribute("cart_id", id);

        return "user/cart/cart";
    }

    @GetMapping(value="/delete_cart/{id}")
    public String deleteCart(HttpSession session, @PathVariable("id") int id) {
        // Bước 1: Tìm giỏ hàng
        Cart cart = cartService.findCartById(id);

        // Bước 2: Kiểm tra xem giỏ hàng có sản phẩm nào không
        if (cart != null) {
            // Giả sử bạn có phương thức tìm sản phẩm theo cart_id
            List<Cart_Product> cartProducts = cart_productService.findCart_ProductsByCartId(id);

            // Bước 3: Xóa tất cả các sản phẩm trong giỏ hàng
            for (Cart_Product product : cartProducts) {
                cart_productService.deleteById(product.getId());
            }
        }

        // Bước 4: Xóa giỏ hàng
        cartService.deleteById(id);

        // Cập nhật số lượng giỏ hàng cho người dùng
        int user_id = (int) session.getAttribute("user_id");
        int countCart = 0;
        List<Cart> listCart = cartService.findCartByUserId(user_id);
        for (Cart cartItem : listCart) {
            if (cartItem.getActive() == true) {
                countCart++;
            }
        }
        session.setAttribute("CountCart", countCart);

        return "redirect:/cart";
    }


    @PostMapping(value="/delete_cartProduct/{id}")
    public String deleteCartProduct(HttpSession session, @PathVariable("id") int id){
        cart_productService.deleteById(id);
        return "redirect:/cart/"+session.getAttribute("cart_id");
    }



    @PostMapping(value="/addCart")
    public String addCart(HttpSession session,
                          @RequestParam("nameNewCart") String nameNewCart){
        int user_id = (int) session.getAttribute("user_id");
        if(nameNewCart.equals("")){
            return "redirect:/cart";
        }
        User user = userService.findById(user_id).get();
        Cart newCart = new Cart();
        newCart.setUser(user);
        newCart.setName(nameNewCart);
        newCart.setActive(true);
        cartService.save(newCart);

        int countCart = 0;
        List<Cart> listCart = cartService.findCartByUserId(user.getId());
        for(Cart cart:listCart){
            if(cart.getActive() == true){
                countCart++;
            }
        }
        session.setAttribute("CountCart", countCart);

        return "redirect:/cart";
    }



    @PostMapping(value="updateCart/{id}")
    public String updateCart(HttpSession session, @PathVariable("id") int id,
                             @RequestParam("nameCart") String name){
        Cart cart1 = cartService.findById(id).get();
        if(name.equals("")){
            return "redirect:/cart";
        }
        cart1.setId(id);
        cart1.setName(name);
        cart1.setActive(true);
        User user = userService.findById((int) session.getAttribute("user_id")).get();
        cart1.setUser(user);
        cartService.save(cart1);
        return "redirect:/cart";
    }
}
