package hcmute.springbootdemo.Controller.Admin;

import hcmute.springbootdemo.Entity.Brand;
import hcmute.springbootdemo.Service.IBrandService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping(value = "/admin/brand")
public class BrandController {
	@Autowired
	IBrandService brandService;
	
	@RequestMapping(value = "")
	public String index(ModelMap model)
	{
		model.addAttribute("active", "brand");
		List<Brand> listBrands = brandService.findAll();
		model.addAttribute("listBrands", listBrands);
		return "admin/brand";
	}
	@PostMapping(value = "save")
	public String saveBrand(RedirectAttributes redirectAttributes,
			@RequestParam(name="id", required=false) Integer id, @RequestParam("name") String name)
	{

		// Kiểm tra nếu name là null hoặc rỗng
		if (name == null || name.trim().isEmpty()) {
			redirectAttributes.addFlashAttribute("error", "vui lòng nhập đúng định dạng!");
			return "redirect:/admin/brand";
		}

		try {
			Brand brand = new Brand();
			if (id != null) {
				brand.setId(id);
			}
			brand.setName(name);
			brandService.save(brand);
			redirectAttributes.addFlashAttribute("message", "Thao tác thành công!");
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Thao tác thất bại: ");
		}
		return "redirect:/admin/brand";

	}
	@GetMapping(value = "delete/{id}")
	public String deleteBrand(RedirectAttributes redirectAttributes, @PathVariable("id") int id) {
		try {
		brandService.deleteById(id);
		redirectAttributes.addFlashAttribute("message", "Thao tác thành công!");
	} catch (Exception e) {
		redirectAttributes.addFlashAttribute("error", "Thao tác thất bại: ");
	}
		return "redirect:/admin/brand";
	}
}
