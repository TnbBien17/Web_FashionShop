package hcmute.springbootdemo.Repository;

import hcmute.springbootdemo.Entity.Cart;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CartRepository extends JpaRepository<Cart, Integer>{

    List<Cart> findCartsByUserId(int userId);

    Cart findCartById(int id);

    int countCartsByUserId(int userId);

}
