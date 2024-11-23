package hcmute.springbootdemo.Service.impl;

import hcmute.springbootdemo.Entity.Product;
import hcmute.springbootdemo.Entity.Review;
import hcmute.springbootdemo.Entity.User;
import hcmute.springbootdemo.Repository.*;
import hcmute.springbootdemo.Service.IUserService;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements IUserService{

    @Autowired
    UserRepository userRepository;
    
	@Override
	public List<User> findByIsAdmin(boolean isAdmin) {
		return userRepository.findByIsAdmin(isAdmin);
	}

    @Autowired
    ProductRepository productRepository;

    @Autowired
    ReviewRepository reviewRepository;

    @Autowired
    Cart_ProductRepository cart_productRepository;

    @Autowired
    PasswordEncoder passwordEncoder;

    @Override
    public boolean checklogin(String email, String password) {
        Optional<User> user = userRepository.findUserByEmail(email);
        if(user.isPresent() && passwordEncoder.matches(password,user.get().getPasswordHashed())){
            return true;
        }
        return false;
    }

    @Override
    public List<Product> findProductByCategory(int categoryId) {
        List<Product> list_product = productRepository.findAll();
        List<Product> list_product_category = new ArrayList<Product>();
        for(Product product : list_product){
            if(product.getCategory().getId() == categoryId){
                list_product_category.add(product);
            }
        }
        return list_product_category;
    }

    @Override
    public List<Review> findReviewByProduct(int productId) {
        List<Review> list_review = productRepository.findProductById(productId).getReviews();
        return list_review;
    }

    @Override
    public Optional<User> findUserByPhone(String phoneNumber) {
        return userRepository.findUserByPhone(phoneNumber);
    }

    @Override
    public Optional<User> findUserByEmail(String email) {
        return userRepository.findUserByEmail(email);
    }

    @Override
    public User findUserById(int id) {
        return userRepository.findUserById(id);
    }

    @Override
	public <S extends User> S save(S entity) {
		return userRepository.save(entity);
	}

    @Override
    public int getMaxId() {
        return userRepository.getMaxId();
    }


    @Override
	public List<User> findAll() {
		return userRepository.findAll();
	}

	@Override
	public Optional<User> findById(Integer id) {
		return userRepository.findById(id);
	}

	@Override
	public boolean existsById(Integer id) {
		return userRepository.existsById(id);
	}

	@Override
	public <S extends User> boolean exists(Example<S> example) {
		return userRepository.exists(example);
	}

	@Override
	public long count() {
		return userRepository.count();
	}

	@Override
	public void deleteById(Integer id) {
		userRepository.deleteById(id);
	}

	@Override
	public void delete(User entity) {
		userRepository.delete(entity);
	}
    
}
