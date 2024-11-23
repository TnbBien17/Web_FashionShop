package hcmute.springbootdemo.Service.impl;

import hcmute.springbootdemo.Entity.Cart_Product;
import hcmute.springbootdemo.Repository.Cart_ProductRepository;
import hcmute.springbootdemo.Service.ICart_Product;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class Cart_ProductServiceImpl implements ICart_Product {

    @Autowired
    Cart_ProductRepository cart_ProductRepository;

	@Override
	public <S extends Cart_Product> S save(S entity) {
		return cart_ProductRepository.save(entity);
	}

	@Override
	public int countCart_ProductsByCartId(int cart_id) {
		return cart_ProductRepository.countCart_ProductsByCartId(cart_id);
	}

	@Override
	public int sumTotalProductByCartID(int cart_id) {

		if(cart_ProductRepository.findCart_ProductsByCartId(cart_id).isEmpty())
			return 0;
		else{
			return cart_ProductRepository.sumTotal(cart_id);
		}
	}

	@Override
	public int sumTotalQuantityByCartID(int cartId) {
		// Gọi repository để tính tổng số lượng (quantity) của tất cả sản phẩm trong cart
		Integer totalQuantity = cart_ProductRepository.sumTotalQuantityByCartID(cartId);

		// Nếu không có sản phẩm nào trong giỏ hàng, trả về 0 thay vì null
		return (totalQuantity != null) ? totalQuantity : 0;
	}


	@Override
	public List<Cart_Product> findCart_ProductsByCartId(int cart_id) {
		return cart_ProductRepository.findCart_ProductsByCartId(cart_id);
	}


	@Override
	public List<Cart_Product> findAll() {
		return cart_ProductRepository.findAll();
	}

	@Override
	public Optional<Cart_Product> findById(Integer id) {
		return cart_ProductRepository.findById(id);
	}

	@Override
	public boolean existsById(Integer id) {
		return cart_ProductRepository.existsById(id);
	}

	@Override
	public long count() {
		return cart_ProductRepository.count();
	}

	@Override
	public void deleteById(Integer id) {
		cart_ProductRepository.deleteById(id);
	}

	@Override
	public void delete(Cart_Product entity) {
		cart_ProductRepository.delete(entity);
	}
    
    
	@Override
	public int getMaximumId(){
		return cart_ProductRepository.getMaximumId();
	}

	@Override
	public void deleteAllByProductId(int productId) {
		// Lấy tất cả các Cart_Product liên quan đến productId
		List<Cart_Product> cartProducts = cart_ProductRepository.findByProductId(productId);
		// Xóa từng Cart_Product
		for (Cart_Product cartProduct : cartProducts) {
			cart_ProductRepository.deleteById(cartProduct.getId());
		}
	}


}
