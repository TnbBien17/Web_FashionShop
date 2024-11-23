package hcmute.springbootdemo.Service;

import hcmute.springbootdemo.Entity.Product;
import java.util.List;
import java.util.Optional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface IProductService {
	public List<Product> findAllById(Iterable<Integer> ids);
    List<Product> findAll();

    Product findProductById(int id);

    int countProduct();

	int countProductsByCategoryId(int categoryId);

	List<Product> findProductByCategory(int categoryId);

	List<Product> findProductByCategoryIdAndBrandId(int categoryId, int brandId);

	void delete(Product entity);

	void deleteById(Integer id);

	long count();

	Optional<Product> findById(Integer id);

	<S extends Product> S save(S entity);

	public List<Product> get10Newest();

	public List<Product> get10Best();


	Page<Product> findAll(Pageable pageable);

	List<Product> findProductsByBrandId(int brandId);

	List<Product> findProductsByName(String name);

	void deleteProductWithImages(int productId) throws Exception;
}
