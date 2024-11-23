package hcmute.springbootdemo.Service.impl;

import hcmute.springbootdemo.Entity.Review;
import hcmute.springbootdemo.Repository.ReviewRepository;
import hcmute.springbootdemo.Service.IReviewService;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.stereotype.Service;

@Service
public class ReviewServiceImpl implements IReviewService {

    @Autowired
    ReviewRepository reviewRepository;

	@Override
	public List<Review> findTop10NewestReview() {
		return reviewRepository.findTop10NewestReview();
	}

	@Override
	public <S extends Review> S save(S entity) {
		return reviewRepository.save(entity);
	}

//	@Override
//	public int getMaxId() {
//		return reviewRepository.getMaxId();
//	}

	public Integer getMaxId() {
		Integer maxId = reviewRepository.getMaxId();
		return (maxId != null) ? maxId : 0; // Trả về 0 nếu maxId là null
	}

	@Override
	public double avgRating(int productId) {
		List<Review> review = reviewRepository.findReviewByProductId(productId);
		int sum = 0;
		for (Review r : review) {
			sum += r.getRating();
		}
		if (review.size() == 0) {
			return 0;
		}
		else{
			double avg = (double)sum / review.size();
			avg=rounding(avg);
			return avg;
		}

	}

	@Override
	public int countReviewByProductId(int id) {
		return reviewRepository.countReviewByProductId(id);
	}

	@Override
	public void deleteAllReviewsByProductId(int productId) {
		// Lấy danh sách tất cả các review liên quan đến productId
		List<Review> reviews = reviewRepository.findReviewByProductId(productId);

		// Xóa từng review
		for (Review review : reviews) {
			reviewRepository.deleteById(review.getId());
		}
	}


	@Override
	public List<Review> findAll() {
		return reviewRepository.findAll();
	}

	@Override
	public Optional<Review> findById(Integer id) {
		return reviewRepository.findById(id);
	}

	@Override
	public boolean existsById(Integer id) {
		return reviewRepository.existsById(id);
	}

	@Override
	public <S extends Review> boolean exists(Example<S> example) {
		return reviewRepository.exists(example);
	}

	@Override
	public long count() {
		return reviewRepository.count();
	}

	@Override
	public void deleteById(Integer id) {
		reviewRepository.deleteById(id);
	}

	@Override
	public void delete(Review entity) {
		reviewRepository.delete(entity);
	}

	public static double rounding(double a){
		double temp = a - (int)a;
		if(temp >0 && temp<0.25){
			return Math.ceil(a)-1;
		}
		else if(temp>=0.25 && temp<0.75){
			return Math.ceil(a)-0.5;
		}
		else if(temp>=0.75 && temp<1){
			return Math.ceil(a);
		}
		else{
			return a;
		}
	}

}
