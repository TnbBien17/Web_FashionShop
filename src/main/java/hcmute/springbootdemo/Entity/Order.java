package hcmute.springbootdemo.Entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.*;

@Entity

@Table(name = "Orders")

@NamedQuery(name = "Order.findAll", query = "SELECT c FROM Order c")

public class Order implements Serializable{

	private static final long serialVersionUID = 1L;
	
	@Id
	
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id ;
	
	@Column
	private Boolean paid;

	@Column
	private float subTotal;
	
	@Column
	private float totalDiscount;
	
	@Column
	private float shippingFee;
	
	@Column
	private float total;
	
	@Column(columnDefinition = "varchar(255)")
	private String address;
	
	@Column
	private Date orderDate;

	@Column
	private Date arriveDate;
	
	@ManyToOne
	@JoinColumn(name = "cartId")
	private Cart cart ;
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Boolean getPaid() {
		return paid;
	}

	public void setPaid(Boolean paid) {
		this.paid = paid;
	}

	public float getSubTotal() {
		return subTotal;
	}

	public void setSubTotal(float subTotal) {
		this.subTotal = subTotal;
	}

	public float getTotalDiscount() {
		return totalDiscount;
	}

	public void setTotalDiscount(float totalDiscount) {
		this.totalDiscount = totalDiscount;
	}

	public float getShippingFee() {
		return shippingFee;
	}

	public void setShippingFee(float shippingFee) {
		this.shippingFee = shippingFee;
	}

	public float getTotal() {
		return total;
	}

	public void setTotal(float total) {
		this.total = total;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	public Date getArriveDate() {
		return arriveDate;
	}

	public void setArriveDate(Date arriveDate) {
		this.arriveDate = arriveDate;
	}

	public Cart getCart() {
		return cart;
	}

	public void setCart(Cart cart) {
		this.cart = cart;
	}
	
}
