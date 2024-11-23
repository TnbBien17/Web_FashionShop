package hcmute.springbootdemo.Service;

import hcmute.springbootdemo.Entity.Order;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import org.springframework.data.domain.Example;

public interface IOrderService {
	public List<Order> findByOrderDateBetween(Date startDate, Date endDate);
	public List<Order> findTop10NewestOrder();
	void delete(Order entity);

	void deleteById(Integer id);

	long count();

	<S extends Order> boolean exists(Example<S> example);

	boolean existsById(Integer id);

	Optional<Order> findById(Integer id);

	List<Order> findAll();

	<S extends Order> S save(S entity);



	int getMaxOrderID();

	Order findOrderByCartId(int id);
}
