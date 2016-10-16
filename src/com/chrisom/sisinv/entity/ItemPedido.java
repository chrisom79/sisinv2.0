package com.chrisom.sisinv.entity;

import java.util.Date;

import com.chrisom.sisinv.utils.Algorithms;

public class ItemPedido {
	private Integer cantidad;
	private String id;
	private String articulo;
	private Double precio;
	private Double precioFinal;
	private Double importe;
	private Boolean cargado;
	private Integer pedidoNo;
	private Integer comision;
	private Date pagoComision;
	
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
		return Algorithms.round(importe,2);
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
	public Integer getPedidoNo() {
		return pedidoNo;
	}
	public void setPedidoNo(Integer pedidoNo) {
		this.pedidoNo = pedidoNo;
	}
	
	public Integer getComision() {
		return comision;
	}
	
	public void setComision(Integer comision) {
		this.comision = comision;
	}
	
	public Date getPagoComision() {
		return pagoComision;
	}
	
	public void setPagoComision(Date pagoComision) {
		this.pagoComision = pagoComision;
	}
	
	public Double getPrecioFinal() {
		return precioFinal;
	}
	public void setPrecioFinal(Double precioFinal) {
		this.precioFinal = precioFinal;
	}
	
	public ItemPedido(Integer cantidad, String id, String articulo, Double precio, Double importe, 
			Integer pedidoNo, Integer comision) {
		super();
		this.cantidad = cantidad;
		this.id = id;
		this.articulo = articulo;
		this.precio = precio;
		this.importe = importe;
		this.pedidoNo = pedidoNo;
		this.comision = comision;
	}
	
	public ItemPedido(){
		super();
	}
	
}
