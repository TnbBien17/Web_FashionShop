package hcmute.springbootdemo.Repository;

import hcmute.springbootdemo.Entity.Image;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ImageRepository extends JpaRepository<Image, Integer>{
    List<Image> findByProductId(int productId);
}
