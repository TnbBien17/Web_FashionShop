package hcmute.springbootdemo.Repository;

import hcmute.springbootdemo.Entity.Product;
import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface ProductRepository extends JpaRepository<Product, Integer>{

    Product findProductById(int productId);

    List<Product> findProductByCategoryId(int categoryId);

    @Query("select p from Product p where p.category.id = ?1 and p.brand.id = ?2")
    List<Product> findProductByCategoryIdAndBrandId(int categoryId, int brandId);

    @Query("select count(*) from Product ")
    int countProduct();

    @Query("select count(*) from Product where category.id = ?1")
    int countProductsByCategoryId(int categoryId);


    Page<Product> findAll(Pageable pageable);

    List<Product> findAllById(Iterable<Integer> ids);

    // top 10 new product by created date desc, available = true
    List<Product> findTop10ByAvailableOrderByCreatedDateDesc(boolean available);

    // top 10 product by sold quantity
    List<Product> findTop10ByAvailableOrderBySoldCountDesc(boolean available);

    List<Product> findProductsByBrandId(int brandId);

    @Query("select p from Product p where p.name like %?1%")
    List<Product> findProductsByName(String name);
}
