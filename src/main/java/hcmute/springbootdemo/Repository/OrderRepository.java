package hcmute.springbootdemo.Repository;

import hcmute.springbootdemo.Entity.Order;
import java.util.Date;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface OrderRepository extends JpaRepository<Order, Integer>{
    // get all orders between 2 dates based on OrderDate field and paid status
    // select * from orders where OrderDate between '2020-01-01' and '2020-01-31' and Paid = 1
    @Query(value = "select * from orders where OrderDate between ?1 and ?2 and Paid = true", nativeQuery = true)
    List<Order> findByOrderDateBetween(Date startDate, Date endDate);

    // tìm tất cả hóa đơn theo user id
    Order findOrderByCartId(int id);

    // find top 10 newest orders
    @Query(value = "select * from orders order by id desc limit 10", nativeQuery = true)
    List<Order> findTop10NewestOrder();

    @Query(value="select max(id) from orders", nativeQuery = true)
    int getMaxOrderID();
}
