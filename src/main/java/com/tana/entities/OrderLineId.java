package com.tana.entities;

import javax.persistence.*;
@SuppressWarnings("serial")
@Embeddable
public class OrderLineId implements java.io.Serializable{
	private Order order;
	private Product product;
	
	public OrderLineId(){}
	
	public OrderLineId(Order order, Product product) {
		super();
		this.order = order;
		this.product = product;
	}



	@ManyToOne
	public Order getOrder() {
		return order;
	}

	public void setOrder(Order order) {
		this.order = order;
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

        if (order != null ? !order.equals(that.order) : that.order != null) return false;
        if (product != null ? !product.equals(that.product) : that.product != null)
            return false;

        return true;
    }

    public int hashCode() {
        int result;
        result = (order != null ? order.hashCode() : 0);
        result = 31 * result + (product != null ? product.hashCode() : 0);
        return result;
    }
}
