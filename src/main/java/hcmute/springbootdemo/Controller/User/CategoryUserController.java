package hcmute.springbootdemo.Controller.User;

import hcmute.springbootdemo.Entity.Category;
import hcmute.springbootdemo.Entity.Product;
import hcmute.springbootdemo.Repository.Cart_ProductRepository;
import hcmute.springbootdemo.Repository.CategoryRepository;
import hcmute.springbootdemo.Service.IBrandService;
import hcmute.springbootdemo.Service.IProductService;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping(path="/category")
public class CategoryUserController {

    @Autowired
    CategoryRepository categoryRepository;

    @Autowired
    IProductService productService;

    @Autowired
    IBrandService brandService;

    @Autowired
    Cart_ProductRepository cart_productRepository;

    @GetMapping(value="")
    public String category(ModelMap modelMap, HttpSession session){

        List<Category> listCategory = categoryRepository.findAll();
        List<Integer> listCountProduct = new ArrayList<>();
        for (Category category: listCategory) {
            int countProduct = productService.countProductsByCategoryId(category.getId());
            listCountProduct.add(countProduct);
        }
        session.setAttribute("listCountProduct", listCountProduct);

        session.setAttribute("list_category", categoryRepository.findAll());

        session.setAttribute("list_brand", brandService.findAll());

        session.setAttribute("CountProduct",cart_productRepository.count());

        session.setAttribute("category_id", 0);

        String name_brand=(String)session.getAttribute("brand_name");
        if(name_brand!=null){
            List<Product> listProduct=productService.findProductsByName(name_brand);
            session.setAttribute("list_product_category",listProduct);
            session.setAttribute("brand_name",null);
        }
        else{
            session.setAttribute("list_product_category", productService.findAll());
        }
        return "user/category";
    }

    @GetMapping(value="/{id}")
    public String productByCategory (ModelMap modelMap, @PathVariable("id") int id, HttpSession session){

        List<Category> listCategory = categoryRepository.findAll();
        List<Integer> listCountProduct = new ArrayList<>();
        for (Category category: listCategory) {
            int countProduct = productService.countProductsByCategoryId(category.getId());
            listCountProduct.add(countProduct);
        }

        modelMap.addAttribute("listCountProduct", listCountProduct);
        session.setAttribute("list_category", categoryRepository.findAll());
        session.setAttribute("list_brand", brandService.findAll());
        session.setAttribute("list_product_category", productService.findProductByCategory(id));
        session.setAttribute("category_id", id);
        return "user/category";
    }



}
