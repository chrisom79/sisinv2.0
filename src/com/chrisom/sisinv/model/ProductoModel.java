package com.chrisom.sisinv.model;

import java.util.List;

import com.chrisom.sisinv.dao.ProductoDAO;
import com.chrisom.sisinv.entity.Producto;

public class ProductoModel {
	ProductoDAO dao = new ProductoDAO();
	public String insertProducto(Producto producto) {
		producto.setHabilitado(Boolean.TRUE);
		return dao.insert(producto);
	}
	
	public void updateProducto(Producto producto) {
		producto.setHabilitado(Boolean.TRUE);
		dao.update(producto);
	}
	
	public void deleteById(String id) {
		dao.logicDeleteById(id);
	}
	
	public List<Producto> findProductoByNombre(String nombre) {
		return dao.findProductoByNombre(nombre);
	}
	
	public List<Producto> findProductoByParameters(String id) {
		return dao.findProductoByParameters(id);
	}
	
	public Producto findProductoByCode(String id) {
		return dao.findProductoByCode(id);
	}
	
	public Integer getMaxIdToInsert(){
		return dao.getMaxIdToInsert();
	}
}
