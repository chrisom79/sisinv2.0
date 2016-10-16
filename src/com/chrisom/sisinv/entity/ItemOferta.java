package com.chrisom.sisinv.entity;

public class ItemOferta {
	private Integer id;
	private String descripcion;
	private Integer tipo;
	private String nombreTipo;
	private String codigo;
	private String nombre;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String nombre) {
		this.descripcion = nombre;
	}
	public Integer getTipo() {
		return tipo;
	}
	public void setTipo(Integer idTipo) {
		this.tipo = idTipo;
	}
	
	public String getNombreTipo() {
		return nombreTipo;
	}
	
	public void setNombreTipo(String nombreTipo) {
		this.nombreTipo = nombreTipo;
	}
	
	public String getCodigo() {
		return codigo;
	}
	
	public void setCodigo(String idProducto) {
		this.codigo = idProducto;
	}
	
	public String getNombre() {
		return nombre;
	}
	
	public void setNombre(String nombreProducto) {
		this.nombre = nombreProducto;
	}
	
	
	
}
