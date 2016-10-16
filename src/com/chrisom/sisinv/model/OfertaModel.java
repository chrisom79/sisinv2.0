package com.chrisom.sisinv.model;

import java.util.List;

import com.chrisom.sisinv.dao.OfertaDAO;
import com.chrisom.sisinv.dao.ProductoDAO;
import com.chrisom.sisinv.entity.ItemOferta;
import com.chrisom.sisinv.entity.Oferta;

public class OfertaModel {
	private OfertaDAO dao = new OfertaDAO();
	private ProductoDAO prodDAO = new ProductoDAO();
	
	public Integer insertOferta(Oferta oferta, String idProducto) {
		dao.insert(oferta);
		Integer id = dao.getMaxIdToInsert();
		prodDAO.setOferta(idProducto, id);
		return id;
	}
	
	public void updateOferta(Oferta oferta, String idProducto, String prevIdProducto) throws Exception {
		dao.update(oferta);
		if(!prevIdProducto.equals(idProducto)) {
			prodDAO.setOferta(idProducto, oferta.getId());
			prodDAO.setOferta(prevIdProducto, null);
		}
		
	}
	
	public List<ItemOferta> findOfertasByParameters(String nombre, Integer tipo, String idProducto) {
		return dao.findOfertaByParameters(nombre, tipo, idProducto);
	}
	
	public Oferta findOfertaAndProductoById(Integer id, String idProducto) {
		Oferta oferta = dao.findOfertaById(id);
		oferta.setProducto(prodDAO.findProductoByCode(idProducto));
		return oferta;
	}
	
	public void deleteOferta(String id, String idProducto)  throws Exception  {
		prodDAO.setOferta(idProducto, null);
		dao.deleteByField(id);
	}
}
