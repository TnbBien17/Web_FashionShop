package hcmute.springbootdemo.Controller.User;

import hcmute.springbootdemo.Entity.*;
import hcmute.springbootdemo.Service.impl.*;
import java.util.Date;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping(path = "/pay")
public class PayController {

    @Autowired
    Cart_ProductServiceImpl cart_productService;

    @Autowired
    ProductServiceImpl productService;

    @Autowired
    CartServiceImpl cartService;

    @Autowired
    OrderServiceImpl orderService;

    @Autowired
    UserServiceImpl userService;

    // Xử lý phản hồi từ cổng thanh toán
    @GetMapping("/payment_info")
    public String transaction(
            @RequestParam Map<String, String> params, HttpSession session
    ) {
        String responseCode = params.get("vnp_ResponseCode"); // Lấy mã phản hồi từ tham số URL
        System.out.println(responseCode);
        if ("00".equals(responseCode)) { // Nếu mã phản hồi là "00" (thành công)

            int id= (int) session.getAttribute("cartID");

            Order order = (Order) session.getAttribute("order_pay");

            order.setCart(cartService.findCartById(id));
            order.setArriveDate(null);
            order.setOrderDate(new Date());
            order.setShippingFee(0);


            float total = 0;
            float totalDiscount = 0;
            List<Cart_Product> cart_products = cart_productService.findCart_ProductsByCartId(id);
            for(Cart_Product cart_product : cart_products){
                total += cart_product.getProduct().getPrice() * cart_product.getQuantity();
                totalDiscount += cart_product.getQuantity() * (cart_product.getProduct().getPrice() - (cart_product.getProduct().getPrice()-(cart_product.getProduct().getPrice()*cart_product.getProduct().getDiscountPercent())));

                //Cập nhật lai số lượng sản phẩm và số lượng đã bán
                Product product = productService.findById(cart_product.getProduct().getId()).get();
                product.setStock(product.getStock() - cart_product.getQuantity());
                if(product.getStock() - cart_product.getQuantity() == 0){
                    product.setAvailable(false);
                }
                product.setSoldCount(product.getSoldCount() + cart_product.getQuantity());
                productService.save(product);

            }
            order.setSubTotal(total);

            order.setTotalDiscount(totalDiscount);
            order.setTotal(total-totalDiscount);

            Cart cart = cartService.findCartById(id);
            cart.setActive(false);
            cartService.save(cart);

            order.setOrderDate(new Date());
            order.setPaid(true);
            order.setId(orderService.getMaxOrderID());
            orderService.save(order);

            int countCart= session.getAttribute("CountCart") == null ? 0 : (int) session.getAttribute("CountCart");
            session.setAttribute("CountCart", countCart - 1);

            order.setPaid(true);

            return "checkout/success_pay";
        } else {
            return "checkout/fail_pay";
        }
    }
}




