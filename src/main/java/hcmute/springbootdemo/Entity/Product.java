package hcmute.springbootdemo.Entity;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.lang.Nullable;

import javax.persistence.*;

@Entity
@Table(name = "Product")
@EntityListeners(AuditingEntityListener.class)
public class Product implements Serializable{

	private static final long serialVersionUID = 1L;
	
	@Id

	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@Column(columnDefinition = "int")
	private int stock;
	
	@Column(columnDefinition = "int DEFAULT 0")
	private int soldCount = 0;
	
	

	@Column(columnDefinition = "float")
	private Float price;
	
	@Column(columnDefinition = "bool DEFAULT true")
	private Boolean available = true;
	
	@Column(columnDefinition = "float DEFAULT 0")
	private Float discountPercent;
	
	@Column(columnDefinition = "text")
	private String description;
	
	@Column(columnDefinition = "varchar(255)")
	private String name;
	
	@Column
	@Nullable
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date discountStart;
	
	@Column
	@Nullable
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date discountEnd;
	
	@Column
	@CreatedDate
	private Date createdDate;
	
	@ManyToOne
	@JoinColumn(name = "cateId")
	private Category category;
	
	@ManyToOne
	@JoinColumn(name = "brandId")
	private Brand brand;
	
	@OneToMany(mappedBy = "product", fetch = FetchType.EAGER)
	private List<Image> images;
	
	@OneToMany(mappedBy = "product", fetch = FetchType.LAZY)
	private List<Review> reviews;
	
	@OneToMany(mappedBy = "product")
	List<Cart_Product> cart_products;
	
	public Date getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}
	public Product() {
	}
	public int getSoldCount() {
		return soldCount;
	}
	public void setSoldCount(int soldCount) {
		this.soldCount = soldCount;
	}
	public void setPrice(Float price) {
		this.price = price;
	}
	
	public Float getPrice() {
		return price;
	}
	public void setDiscountPercent(Float discountPercent) {
		this.discountPercent = discountPercent;
	}
	public Float getDiscountPercent() {
		return discountPercent;
	}
	public List<Cart_Product> getCart_products() {
		return cart_products;
	}

	public void setCart_products(List<Cart_Product> cart_products) {
		this.cart_products = cart_products;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	
	public int getStock() {
		return stock;
	}
	public void setStock(int stock) {
		this.stock = stock;
	}
	public Boolean getAvailable() {
		return available;
	}
	public void setAvailable(Boolean available) {
		this.available = available;
	}
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Date getDiscountStart() {
		return discountStart;
	}

	public void setDiscountStart(Date discountStart) {
		this.discountStart = discountStart;
	}

	public Date getDiscountEnd() {
		return discountEnd;
	}

	public void setDiscountEnd(Date discountEnd) {
		this.discountEnd = discountEnd;
	}

	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	public Brand getBrand() {
		return brand;
	}

	public void setBrand(Brand brand) {
		this.brand = brand;
	}

	public List<Image> getImages() {
		return images;
	}

	public void setImages(List<Image> images) {
		this.images = images;
	}

	public List<Review> getReviews() {
		return reviews;
	}

	public void setReviews(List<Review> reviews) {
		this.reviews = reviews;
	}

}
