package com.chrisom.sisinv.entity;

import java.io.Serializable;
import java.util.Date;

public class VendedorComision implements Serializable {
	private int id;
	private Vendedor vendedor;
	private Date fechaInicio;
	private Date fechaFinal;
	
	public VendedorComision() {
		
	}
	
	public VendedorComision(int id, Vendedor vendedor, Date fechaInicio, Date fechaFinal) {
		super();
		this.id = id;
		this.vendedor = vendedor;
		this.fechaInicio = fechaInicio;
		this.fechaFinal = fechaFinal;
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Vendedor getVendedor() {
		return vendedor;
	}
	public void setVendedor(Vendedor vendedor) {
		this.vendedor = vendedor;
	}
	public Date getFechaInicio() {
		return fechaInicio;
	}
	public void setFechaInicio(Date fechaInicio) {
		this.fechaInicio = fechaInicio;
	}
	public Date getFechaFinal() {
		return fechaFinal;
	}
	public void setFechaFinal(Date fechaFinal) {
		this.fechaFinal = fechaFinal;
	}
	
	
	
}
