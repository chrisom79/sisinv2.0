package com.chrisom.sisinv.entity;

import com.google.gson.annotations.Expose;

public class PedidoRuta {
	@Expose
	private int id;
	@Expose
	private String nombre;
	
	public PedidoRuta() {
		super();
	}
	
	public PedidoRuta(String nombre) {
		super();
		this.nombre = nombre;
	}
	
	public PedidoRuta(int id, String nombre) {
		super();
		this.id = id;
		this.nombre = nombre;
	}
	
	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public String getNombre() {
		return nombre;
	}
	
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	
	
}
