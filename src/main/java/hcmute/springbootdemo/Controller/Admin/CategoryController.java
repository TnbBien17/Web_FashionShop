package hcmute.springbootdemo.Controller.Admin;

import hcmute.springbootdemo.Entity.Category;
import hcmute.springbootdemo.Service.ICategoryService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;

@Controller
@RequestMapping(value = "/admin/category")
public class CategoryController {
	@Autowired
	ICategoryService categoryService;
	
	@GetMapping(value = "")
	public String index(ModelMap model) {
		model.addAttribute("active", "category");
		model.addAttribute("category", new Category());
		List<Category> list = categoryService.findAll();
		model.addAttribute("list", list);
        return "admin/category";
	}

	@PostMapping("/save")
    public String saveCategory(RedirectAttributes redirectAttributes,
    		@Valid @ModelAttribute("category") Category category, BindingResult result) {
//        categoryService.save(category);
//        redirectAttributes.addFlashAttribute("message", "Thao tác thành công!");
//        return "redirect:/admin/category";

		// Kiểm tra nếu tên hoặc icon là null hoặc rỗng
		if (category.getName() == null || category.getName().trim().isEmpty() ||
				category.getIcon() == null || category.getIcon().trim().isEmpty()) {
			redirectAttributes.addFlashAttribute("error", "Vui lòng nhập đúng định dạng!");
			return "redirect:/admin/category"; // Trả về trang danh mục
		}

		try {
			categoryService.save(category);
			redirectAttributes.addFlashAttribute("message", "Thao tác thành công!");
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Thao tác thất bại: ");
		}

		return "redirect:/admin/category";
    }

	@GetMapping(value = "delete/{id}")
	public String delete(RedirectAttributes redirectAttributes, @PathVariable("id") int id) {
		try{
			categoryService.deleteById(id);
			redirectAttributes.addFlashAttribute("message", "Thao tác thành công!");
		}catch(Exception e){
			redirectAttributes.addFlashAttribute("error", "Thao tác thất bại: " );
		}
		return "redirect:/admin/category";
	}
}
