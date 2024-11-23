package hcmute.springbootdemo.Controller.Admin;

import hcmute.springbootdemo.Entity.Order;
import hcmute.springbootdemo.Service.IOrderService;
import hcmute.springbootdemo.Service.IReviewService;
import hcmute.springbootdemo.Service.IUserService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/admin")
public class DashboardController {
	@Autowired
	IOrderService orderService;

	@Autowired
	IUserService userService;

	@Autowired
	IReviewService reviewService;

	@RequestMapping(value = "")
	public String index(ModelMap model)
	{
		model.addAttribute("active", "home");
		List<Order> listOrder = orderService.findAll();
		// paid order only
		listOrder.removeIf(order -> order.getPaid() == false);

		model.addAttribute("orderCount", listOrder.size());
		model.addAttribute("revenue", getRevenue(listOrder));	
		model.addAttribute("userCount", userService.count());
		model.addAttribute("reviewCount", reviewService.count());
		model.addAttribute("newOrder", orderService.findTop10NewestOrder());
		model.addAttribute("newReview", reviewService.findTop10NewestReview());
		return "admin/index";
	}
	float getRevenue(List<Order> listOrder)
	{
		float revenue = 0;
		for (Order order : listOrder)
		{
			revenue += order.getTotal();
		}
		return revenue;
	}
}
