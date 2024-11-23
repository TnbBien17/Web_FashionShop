package hcmute.springbootdemo.Service;

import hcmute.springbootdemo.Entity.Cart_Product;
import java.util.List;
import java.util.Optional;

public interface ICart_Product {

	void delete(Cart_Product entity);

	void deleteById(Integer id);

	long count();

	boolean existsById(Integer id);

	Optional<Cart_Product> findById(Integer id);

	List<Cart_Product> findAll();


	<S extends Cart_Product> S save(S entity);

	int countCart_ProductsByCartId(int cart_id);

	int sumTotalProductByCartID(int cart_id);

	int sumTotalQuantityByCartID(int cartId);

	List<Cart_Product> findCart_ProductsByCartId(int cart_id);

	int getMaximumId();

	void deleteAllByProductId(int productId);

}
