package com.tana.entities;

import javax.persistence.*;
@SuppressWarnings("serial")
@Entity
@Table(name = "orderline", catalog = "tana_shopping")
@AssociationOverrides({ @AssociationOverride(name = "pk.orders", joinColumns = @JoinColumn(name = "order_id")),
		@AssociationOverride(name = "pk.product", joinColumns = @JoinColumn(name = "product_id")) })
public class OrderLine implements java.io.Serializable {

	private OrderLineId pk = new OrderLineId();
	private int amount;

	public OrderLine() {
	}
	
	public OrderLine(OrderLineId pk, int amount) {
		super();
		this.pk = pk;
		this.amount = amount;
	}

	@EmbeddedId
	public OrderLineId getPk() {
		return pk;
	}

	public void setPk(OrderLineId pk) {
		this.pk = pk;
	}

	@Column(name = "amount", nullable = false)
	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}



}
