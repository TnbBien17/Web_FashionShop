package hcmute.springbootdemo.Repository;

import hcmute.springbootdemo.Entity.User;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User, Integer>{

    Optional<User> findUserByPhone(String phoneNumber);

    Optional<User> findUserByEmail(String email);

    List<User> findByIsAdmin(boolean isAdmin);
    User findUserById(int id);

    @Query(value = "SELECT MAX(id) FROM user", nativeQuery = true)
    int getMaxId();


}
