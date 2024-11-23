package hcmute.springbootdemo.Controller.User;

import hcmute.springbootdemo.Service.impl.BrandServiceImpl;
import hcmute.springbootdemo.Service.impl.CategoryServiceImpl;
import hcmute.springbootdemo.Service.impl.ProductServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping(path="/brand/")
public class BrandUserController {

    @Autowired
    BrandServiceImpl brandService;

    @Autowired
    CategoryServiceImpl categoryService;

    @Autowired
    ProductServiceImpl productService;

    @GetMapping(value="{id}")
    public String productByBrand (ModelMap modelMap, @PathVariable("id") int id, HttpSession session){
        int categoryId = (int)session.getAttribute("category_id");

        if(categoryId ==0){
            session.setAttribute("list_product_category", productService.findProductsByBrandId(id));
            System.out.println("list_cart_product: " + productService.findProductsByBrandId(id));
        }
        else {
            session.setAttribute("list_product_category", productService.findProductByCategoryIdAndBrandId(categoryId, id));
            System.out.println("list_cart_product: " + productService.findProductByCategoryIdAndBrandId(categoryId, id));
        }
        session.setAttribute("list_category", categoryService.findAll());
        session.setAttribute("list_brand", brandService.findAll());
        return "user/category";
    }
}
