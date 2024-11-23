package hcmute.springbootdemo.Entity;

import java.io.Serializable;
import java.util.List;

import javax.persistence.*;

@Entity

@Table(name = "Brand")

@NamedQuery(name = "Brand.findAll", query = "SELECT c FROM Brand c")
public class Brand implements Serializable{

	private static final long serialVersionUID = 1L;
	
	@Id
	
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id ;
	
	@Column(columnDefinition = "varchar(255)")
	private String name;
	
	@OneToMany(mappedBy = "brand", fetch = FetchType.EAGER)
	private List<Product> products;

	public Brand() {
	}

	public Brand(int id, String name, List<Product> products) {
		this.name = name;
		this.products = products;
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

	public List<Product> getProducts() {
		return products;
	}

	public void setProducts(List<Product> products) {
		this.products = products;
	}
	
}
