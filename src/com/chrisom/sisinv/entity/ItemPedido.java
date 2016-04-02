package com.chrisom.sisinv.entity;

import com.chrisom.sisinv.utils.Algorithms;

public class ItemPedido {
	private Integer cantidad;
	private String id;
	private String articulo;
	private Double precio;
	private Double importe;
	private Boolean cargado;
	
	public Integer getCantidad() {
		return cantidad;
	}
	public void setCantidad(Integer cantidad) {
		this.cantidad = cantidad;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getArticulo() {
		return articulo;
	}
	public void setArticulo(String articulo) {
		this.articulo = articulo;
	}
	public Double getPrecio() {
		return precio;
	}
	public void setPrecio(Double precio) {
		this.precio = precio;
	}
	public Double getImporte() {
		return Algorithms.round(precio * Double.valueOf(cantidad),2);
	}
	public void setImporte(Double importe) {
		this.importe = importe;
	}
	public Boolean getCargado() {
		return cargado;
	}
	public void setCargado(Boolean cargado) {
		this.cargado = cargado;
	}
	
	
}
