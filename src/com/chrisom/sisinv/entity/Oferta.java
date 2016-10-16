package com.chrisom.sisinv.entity;

import com.chrisom.sisinv.utils.SISINVBackConstants.OFERTA_TIPO;
import com.google.gson.annotations.Expose;

public class Oferta {
	@Expose
	private int id;
	@Expose
	private String descripcion;
	@Expose
	private int tipo;
	@Expose
	private int descuento;
	@Expose
	private int compra;
	@Expose
	private int lleva;
	@Expose
	private double por;
	private double precio;
	Producto producto;
	@Expose
	private String ofertaCompleta;
	
	public Oferta() {
		super();
	}

	public Oferta(int id, String descripcion) {
		super();
		this.id = id;
		this.descripcion = descripcion;
	}

	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public String getDescripcion() {
		return descripcion;
	}
	
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	
	public int getTipo() {
		return tipo;
	}
	
	public void setTipo(int tipo) {
		this.tipo = tipo;
	}
	
	public int getDescuento() {
		return descuento;
	}
	
	public void setDescuento(int descuento) {
		this.descuento = descuento;
	}
	
	public int getCompra() {
		return compra;
	}
	
	public void setCompra(int compra) {
		this.compra = compra;
	}
	
	public int getLleva() {
		return lleva;
	}
	
	public void setLleva(int lleva) {
		this.lleva = lleva;
	}
	
	public double getPor() {
		return por;
	}
	
	public void setPor(double por) {
		this.por = por;
	}
	
	public double getPrecio() {
		return precio;
	}
	
	public void setPrecio(double precio) {
		this.precio = precio;
	}
	
	public Producto getProducto() {
		return producto;
	}

	public void setProducto(Producto producto) {
		this.producto = producto;
	}

	public String getOfertaCompleta() {
		StringBuffer completa = new StringBuffer();
		if(this.tipo == OFERTA_TIPO.DESC.getId()) {
			completa.append("Tiene un ");
			completa.append(this.descuento);
			completa.append("% de descuento");
		} else if(this.tipo == OFERTA_TIPO.COMPRA_LLEVA.getId()) {
			completa.append("Compra ");
			completa.append(this.compra);
			completa.append(" y llevate ");
			completa.append(this.lleva);
		} else if(this.tipo == OFERTA_TIPO.COMPRA_POR.getId()) {
			completa.append("Compra ");
			completa.append(this.compra);
			completa.append(" por $");
			completa.append(this.por);
		}
		
		this.ofertaCompleta = completa.toString();
		
		return completa.toString();
	}
}
