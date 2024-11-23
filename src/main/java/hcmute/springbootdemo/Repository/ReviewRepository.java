package hcmute.springbootdemo.Repository;

import hcmute.springbootdemo.Entity.Review;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface ReviewRepository extends JpaRepository<Review, Integer> {

    List<Review> findReviewByProductId(int id);

//    @Query(value = "SELECT MAX(id) FROM review", nativeQuery = true)
//    Integer getMaxId();

    @Query("SELECT COALESCE(MAX(r.id), 0) FROM Review r")
    Integer getMaxId();

    int countReviewByProductId(int id);

    // find top 10 newest review
    @Query(value = "SELECT * FROM review ORDER BY id DESC LIMIT 10", nativeQuery = true)
    List<Review> findTop10NewestReview();
}
