package hcmute.springbootdemo.Controller.User;


import hcmute.springbootdemo.Entity.*;
import hcmute.springbootdemo.Repository.*;
import hcmute.springbootdemo.Service.impl.*;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping(path="/product")
public class ProductUserController {


    @Autowired
    Cart_ProductRepository cart_productRepository;

    @Autowired
    ProductServiceImpl productService;

    @Autowired
    BrandServiceImpl brandService;

    @Autowired
    UserRepository userRepository;

    @Autowired
    UserServiceImpl userService;

    @Autowired
    ReviewServiceImpl reviewService;

    @Autowired
    CategoryServiceImpl categoryService;

    @Autowired
    CartServiceImpl cartService;

    @GetMapping(value="/{id}")
    public String productUser(ModelMap modelMap, @PathVariable("id") int id, 
                            HttpSession session,HttpServletRequest request, HttpServletResponse response){

        Product product = productService.findById(id).get();

        //view history
        List<Integer> listId = saveToCookie(product.getId(),request, response);
        List<Product> listProductViewHistory = productService.findAllById(listId);
        System.out.println(listProductViewHistory);
        modelMap.addAttribute("viewHistory", listProductViewHistory);
        // same category product
        List<Product> listProductSameCategory = product.getCategory().getProducts();
        modelMap.addAttribute("sameCategory", listProductSameCategory);
//        Date date_end_discount = product.getDiscountEnd();
//        Date now = new Date();
//
//        if(date_end_discount.after(now)){
//            product.setDiscountPercent(0.0f);
//            productService.save(product);
//        }

        if(product.getAvailable()){
            modelMap.addAttribute("available", "Còn hàng");
        }
        else{
            modelMap.addAttribute("available", "Hết hàng");
        }

        Object userID = session.getAttribute("user_id");

        int user_id = 0;
        if(userID == null){
            modelMap.addAttribute("user_id", 0);
        }
        else{
            user_id = (int) session.getAttribute("user_id");
            modelMap.addAttribute("user_id", user_id);
        }

        List<Cart> listCart = cartService.findCartByUserId(user_id);

        if(listCart !=null ){
            modelMap.addAttribute("listCart", listCart);
        }
        else{
            modelMap.addAttribute("listCart", "không có giỏ hàng");
        }

        float price=0;

        if(product.getDiscountPercent()!=0){
            price= product.getPrice()-(product.getDiscountPercent()* product.getPrice());
        }
        else{
            price= product.getPrice();
        }

        session.setAttribute("CountProduct",cart_productRepository.count());

        int brandID = product.getBrand().getId();
        List<Product> listProductBrand =productService.findProductsByBrandId(brandID);




        modelMap.addAttribute("listProductBrand", listProductBrand);

        modelMap.addAttribute("product", product);


        modelMap.addAttribute("product_discounted", price);


        modelMap.addAttribute("cart_product", new Cart_Product());
        modelMap.addAttribute("post_review",new Review());

        double avg_rating = reviewService.avgRating(id);
//        System.out.println("avg_rating"+avg_rating);
        modelMap.addAttribute("avg_rating", avg_rating);
        int count_review = reviewService.countReviewByProductId(id);
        modelMap.addAttribute("count_review", count_review);


        return "user/product";
    }
    private List<Integer> saveToCookie(int id,HttpServletRequest request, HttpServletResponse response) {
        int MAX_VIEW_HISTORY = 5;
        int MAX_AGE = 60*60*24*30; // 30 days
        List<Integer> list = getViewHistoryFromCookie(request);
        if(list == null){
            list = new ArrayList<>();
        }
        if(list.contains(id)){
            list.remove(Integer.valueOf(id));
        }
        list.add(id);
        if(list.size() > MAX_VIEW_HISTORY){
            list.remove(0);
        }

        // Cookie cookie = new Cookie("view_history", list.toString());
        // comma not allowed in cookie value
        Cookie cookie = new Cookie("view_history", list.toString().replace(", ", "_"));
        cookie.setMaxAge(MAX_AGE);
        response.addCookie(cookie);
        return list;
    }


    private List<Integer> getViewHistoryFromCookie(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        if(cookies != null){
            for(Cookie cookie : cookies){
                if(cookie.getName().equals("view_history")){
                    String value = cookie.getValue();
                    String[] ids = value.substring(1, value.length()-1).split("_");
                    List<Integer> list = new ArrayList<>();
                    for(String id : ids){
                        list.add(Integer.parseInt(id));
                    }
                    return list;
                }
            }
        }
        return null;
    }


    @PostMapping(value="/{id}/product_to_cart")
    public String insertProductToCart(HttpSession session,
                                      @ModelAttribute("cart_product") Cart_Product cartproduct,
                                      @PathVariable("id") int id,
                                      ModelMap modelMap,
                                      RedirectAttributes redirectAttributes){


        Product product = productService.findById(id).get();

        cartproduct.setProduct(product);

        Cart cart =cartproduct.getCart();
        int cart_id = cart.getId();
        session.setAttribute("quantity",cartproduct.getQuantity());
        // tổng tiền của sản phẩm đó sau khi thêm vào giỏ hàng
        float total = cartproduct.getQuantity() * product.getPrice() - (cartproduct.getQuantity() * product.getPrice() * product.getDiscountPercent());
        cartproduct.setTotalPrice(total);

//       kiểm tra xem sản phẩm đã có trong giỏ hàng chưa
        List<Cart_Product> listCartProduct = cart_productRepository.findCart_ProductsByCartId(cart_id);
        for(Cart_Product cart_product:listCartProduct){
            if(cart_product.getProduct().getId() == id){
                cart_product.setQuantity(cartproduct.getQuantity());
                cart_product.setTotalPrice(cartproduct.getTotalPrice());
                cart_product.setId(cart_product.getId());
                System.out.println("cart gio hàng"+cart_product.getId());
                cart_productRepository.save(cart_product);
                session.setAttribute("CountProduct",cart_productRepository.count());
                redirectAttributes.addFlashAttribute("message", "Thêm vào giỏ hàng thành công");
                return "redirect:/product/{id}";
            }
        }

        // cartproduct.setId(cart_productRepository.getMaximumId()+1);
        cart_productRepository.save(cartproduct);

        session.setAttribute("CountProduct",cart_productRepository.count());

        redirectAttributes.addFlashAttribute("message", "Thêm vào giỏ hàng thành công");

        return "redirect:/product/{id}";
    }

    @PostMapping(value="/seach")
    public String seachProduct(@RequestParam("keyword") String name, ModelMap modelMap, HttpSession session){
        List<Product> listProduct = productService.findProductsByName(name);
        session.setAttribute("list_product_category", listProduct);

        // Kiểm tra xem danh sách sản phẩm có rỗng không
        if (listProduct.isEmpty()) {
            modelMap.addAttribute("message", "Không tìm thấy kết quả");
        }


        return "user/category";
    }

}
