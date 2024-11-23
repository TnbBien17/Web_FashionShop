package hcmute.springbootdemo.Service;

import hcmute.springbootdemo.Entity.Image;
import java.util.List;
import java.util.Optional;
import org.springframework.data.domain.Example;

public interface IImageService {

	void delete(Image entity);

	void deleteById(Integer id);

	long count();

	<S extends Image> boolean exists(Example<S> example);

	boolean existsById(Integer id);

	Optional<Image> findById(Integer id);

	<S extends Image> S save(S entity);

	public List<Image> findAll();

    List<Image> findImagesByProductId(int productId);
}
