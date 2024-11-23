package hcmute.springbootdemo.Service;

import hcmute.springbootdemo.Entity.Category;
import java.util.List;
import java.util.Optional;

public interface ICategoryService {

	void deleteAllById(Iterable<? extends Integer> ids);

	void delete(Category entity);

	long count();

	Optional<Category> findById(Integer id);

	List<Category> findAllById(Iterable<Integer> ids);


	List<Category> findAll();

	<S extends Category> S save(S entity);

	void deleteById(Integer id);

}
