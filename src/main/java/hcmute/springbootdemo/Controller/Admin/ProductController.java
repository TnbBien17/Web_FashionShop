package hcmute.springbootdemo.Controller.Admin;

import hcmute.springbootdemo.Entity.Brand;
import hcmute.springbootdemo.Entity.Category;
import hcmute.springbootdemo.Entity.Image;
import hcmute.springbootdemo.Entity.Product;
import hcmute.springbootdemo.Service.*;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;

@Controller
@RequestMapping(value = "/admin/product")
public class ProductController {
	@Autowired
	IProductService productService;

	@Autowired
	IBrandService brandService;

	@Autowired
	ICategoryService categoryService;

	@Autowired
	IImageService imageService;

	@Autowired
	IStorageService storageService;

	@RequestMapping(value = "")
	public String index(ModelMap model) {
		model.addAttribute("active", "product");
		List<Product> list = productService.findAll();
		model.addAttribute("list", list);
		model.addAttribute("product", new Product());
		List<Brand> brands = brandService.findAll();
		model.addAttribute("brands", brands);
		List<Category> categories = categoryService.findAll();
		model.addAttribute("categories", categories);
		return "admin/product";
	}

	@PostMapping("/save")
	public String save(RedirectAttributes redirectAttributes,
			@Valid @ModelAttribute("product") Product product, BindingResult result) {

		String validationError = validateProduct(product);
		if (validationError != null) {
			redirectAttributes.addFlashAttribute("error", validationError);
			return "redirect:/admin/product"; // Trả về trang danh mục
		}


		try{
			if (product.getDiscountPercent() == null)
				product.setDiscountPercent(0f);
			productService.save(product);
			redirectAttributes.addFlashAttribute("message", "Thao tác thành công!");
		}catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Thao tác thất bại ");
		}

		return "redirect:/admin/product";
	}

	private String validateProduct(Product product) {
		if (product.getName() == null || product.getName().trim().isEmpty()) {
			return "Vui lòng nhập đúng định dạng!" + "Tên sản phẩm không được để trống!";
		}
		if (product.getDescription() == null || product.getDescription().trim().isEmpty()) {
			return "Vui lòng nhập đúng định dạng!" +"Mô tả sản phẩm không được để trống!";
		}
		if (product.getPrice() == null || product.getPrice() <= 0) {
			return "Vui lòng nhập đúng định dạng!" +"Giá sản phẩm phải lớn hơn 0!";
		}
		if (product.getBrand() == null) {
			return "Vui lòng nhập đúng định dạng!" + "Nhãn hiệu không được để trống!";
		}
		if (product.getCategory() == null) {
			return "Vui lòng nhập đúng định dạng!" + "Loại hàng không được để trống!";
		}
		if (product.getDiscountPercent() == null){
			return "Vui lòng nhập đúng định dạng!" + "phần trăm giảm không được trống";
		}
		if (product.getDiscountPercent() < 0 || product.getDiscountPercent() > 100) {
			return "Vui lòng nhập đúng định dạng!" +"Phần trăm giảm giá phải trong khoảng 0 đến 100!";
		}
		if (product.getSoldCount() < 0) {
			return "Vui lòng nhập đúng định dạng!"+"Số lượng bán không được âm!";
		}

		return null; // Không có lỗi
	}

//	@GetMapping("/delete/{id}")
//	public String delete(RedirectAttributes redirectAttributes, @ModelAttribute("id") int id) {
//		try{
//			productService.deleteById(id);
//			redirectAttributes.addFlashAttribute("message", "Thao tác thành công!");
//		}catch (Exception e){
//			redirectAttributes.addFlashAttribute("error", "Thao tác thất bại ");
//		}
//
//		return "redirect:/admin/product";
//	}

	@GetMapping("/delete/{id}")
	public String deleteProduct(RedirectAttributes redirectAttributes, @PathVariable("id") int id) {
		try {
			productService.deleteProductWithImages(id);
			productService.deleteById(id);
			redirectAttributes.addFlashAttribute("message", "Thao tác thành công!");
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Thao tác thất bại " + e.getMessage());
		}
		return "redirect:/admin/product";
	}


	@GetMapping("/images/{id}")
	public String getImages(ModelMap model, @PathVariable("id") int id) {

		model.addAttribute("active", "product");

		Optional<Product> optionalProduct = productService.findById(id);
		if (optionalProduct.isPresent()) {
			model.addAttribute("product", optionalProduct.get());
			return "admin/product_images";
		} else {
			// Thêm thông báo lỗi vào model nếu không tìm thấy sản phẩm
			model.addAttribute("error", "Không tìm thấy ảnh sản phẩm");
			return "admin/product_images";
		}
	}

	@PostMapping("/images/{id}")
	public String saveImages(RedirectAttributes redirectAttributes,
			@RequestParam("image") MultipartFile img, @PathVariable("id") int id) {
		try {
			if (img.isEmpty()) {
				redirectAttributes.addFlashAttribute("error", "Thao tác thất bại!");
			} else {
				UUID uuid = UUID.randomUUID();
				String uuString = uuid.toString();
				Image image = new Image();
				image.setProduct(productService.findById(id).get());
				image.setImageLink("product/" + storageService.getSorageFilename(img, uuString));
				storageService.store(img, image.getImageLink());
				imageService.save(image);
				redirectAttributes.addFlashAttribute("message", "Thao tác thành công!");
			}

		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", e.getMessage());
		}
		return "redirect:/admin/product/images/" + id;
	}

	@GetMapping("/image-delete/{id}")
	public String deleteImages(RedirectAttributes redirectAttributes, @PathVariable("id") int id) {
		int productId = 0;
		try {
			// System.out.println(imageService.findAll());
			Image image = imageService.findById(id).get();
			storageService.delete(image.getImageLink());
			productId = image.getProduct().getId();
			imageService.deleteById(id);
			redirectAttributes.addFlashAttribute("message", "Thao tác thành công!");
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Thao tác thất bại!");
		}
		return "redirect:/admin/product/images/" + productId;
	}
}
