package hcmute.springbootdemo.Entity;

import java.io.Serializable;
import java.util.List;

import javax.persistence.*;
@Entity

@Table(name = "Cart")

@NamedQuery(name = "Cart.findAll", query = "SELECT c FROM Cart c")
public class Cart implements Serializable{

	private static final long serialVersionUID = 1L;
	
	@Id
	
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id ;
	
	@Column(columnDefinition = "varchar(255)")
	private String name;

	@Column(columnDefinition = "bool DEFAULT true")
	private Boolean active = true; // Khởi tạo giá trị mặc định
	
	@OneToMany(mappedBy = "cart", fetch = FetchType.LAZY)
	private List<Order> orders;
	
	@ManyToOne
	@JoinColumn(name = "userId")
	private User user;
	
	@OneToMany(mappedBy = "cart")
	List<Cart_Product> cart_products;

	public Cart() {
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	public boolean getActive() {
		return active;
	}

	public void setActive(boolean active) {
		this.active = active;
	}

	public List<Order> getOrders() {
		return orders;
	}

	public void setOrders(List<Order> orders) {
		this.orders = orders;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
}
