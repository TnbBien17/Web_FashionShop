package hcmute.springbootdemo.Service;

import hcmute.springbootdemo.Entity.Product;
import hcmute.springbootdemo.Entity.Review;
import hcmute.springbootdemo.Entity.User;
import java.util.List;
import java.util.Optional;
import org.springframework.data.domain.Example;

public interface IUserService {

	List<User> findByIsAdmin(boolean isAdmin);

    boolean checklogin(String phoneNumber ,String password);

    List<Product> findProductByCategory(int categoryId);

    List<Review> findReviewByProduct(int productId);

    Optional<User> findUserByPhone(String phoneNumber);
    Optional<User> findUserByEmail(String email);

	User findUserById(int id);

	void delete(User entity);

	void deleteById(Integer id);

	long count();

	<S extends User> boolean exists(Example<S> example);

	boolean existsById(Integer id);

	Optional<User> findById(Integer id);

	List<User> findAll();

	<S extends User> S save(S entity);

	int getMaxId();

}
