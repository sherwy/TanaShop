package com.tana.entities;

import javax.persistence.*;

@SuppressWarnings("serial")
@Embeddable
public class OrderLineId implements java.io.Serializable{
	private Orders orders;
	private Product product;
	
	public OrderLineId(){}
	
	public OrderLineId(Orders orders, Product product) {
		super();
		this.orders = orders;
		this.product = product;
	}

	@ManyToOne
	public Orders getOrders() {
		return orders;
	}

	public void setOrders(Orders orders) {
		this.orders = orders;
	}

	@ManyToOne
	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}
	
	public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        OrderLineId that = (OrderLineId) o;

        if (orders != null ? !orders.equals(that.orders) : that.orders != null) return false;
        if (product != null ? !product.equals(that.product) : that.product != null)
            return false;

        return true;
    }

    public int hashCode() {
        int result;
        result = (orders != null ? orders.hashCode() : 0);
        result = 31 * result + (product != null ? product.hashCode() : 0);
        return result;
    }
}
