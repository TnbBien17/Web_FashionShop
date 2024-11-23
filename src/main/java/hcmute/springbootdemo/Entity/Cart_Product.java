package hcmute.springbootdemo.Entity;

import java.io.Serializable;

import javax.persistence.*;

@Entity

@Table(name = "Cart_Product")
public class Cart_Product implements Serializable{

	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@Column(columnDefinition = "int")
	private int quantity;

    @ManyToOne
    @JoinColumn(name = "cartId")
    Cart cart;

    @ManyToOne
    @JoinColumn(name = "productId")
    Product product;

	@Column(columnDefinition = "float")
	private float totalPrice;

	public Cart_Product() {
	}

	public Cart_Product(int id, int quantity, Cart cart, Product product, float totalPrice) {

		this.id = id;
		this.quantity = quantity;
		this.cart = cart;
		this.product = product;
		this.totalPrice = totalPrice;
	}

	public float getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(float totalPrice) {
		this.totalPrice = totalPrice;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public Cart getCart() {
		return cart;
	}

	public void setCart(Cart cart) {
		this.cart = cart;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

    
}
