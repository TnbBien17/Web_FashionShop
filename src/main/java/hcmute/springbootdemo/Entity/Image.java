package hcmute.springbootdemo.Entity;

import java.io.Serializable;

import javax.persistence.*;

@Entity

@Table(name = "Image")

@NamedQuery(name = "Image.findAll", query = "SELECT i FROM Image i")

public class Image implements Serializable{

	private static final long serialVersionUID = 1L;

	@Id
	
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id ;
	
	@Column(columnDefinition = "varchar(255)")
	private String imageLink;
	
	@ManyToOne
	@JoinColumn(name = "productId")
	private Product product;

	public Image() {
	}
	public Image(int id, String imageLink, Product product) {
		this.id = id;
		this.imageLink = imageLink;
		this.product = product;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getImageLink() {
		return imageLink;
	}

	public void setImageLink(String imageLink) {
		this.imageLink = imageLink;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}
	
}
