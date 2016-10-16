package com.chrisom.sisinv.model;

import java.util.Date;
import java.util.List;

import com.chrisom.sisinv.dao.PedidoDAO;
import com.chrisom.sisinv.entity.ItemPedido;
import com.chrisom.sisinv.entity.NotaRemision;

public class PedidoModel {
	PedidoDAO dao = new PedidoDAO();
	
	public Long getNewId() {
		Long id = null;
		
		id = dao.countIds(null);
		if(id == null) {
			id = new Long(0);
		}
		
		return id + 1;
	}
	
	public String insertPedido(NotaRemision pedido) {
		pedido.setEnviado(Boolean.FALSE);
		return dao.insert(pedido);
	}
	
	public List<NotaRemision> findLastPedidos(Integer limit) {
		return dao.findLastPedidos(limit);
	}
	
	public List<NotaRemision> findPedidosByParameters(String value, String fechaInicio, String fechaFinal, Boolean enviado) {
		return dao.findPedidosByParameters(value, fechaInicio, fechaFinal, enviado);
	}
	
	public NotaRemision findPedidoById(Integer value) {
		return dao.findPedidoById(value);
	}
	
	public List<ItemPedido> findItemsByPedido(Integer id) {
		return dao.findItemsByPedido(id);
	}
	
	public List<NotaRemision> findPedidosByVendedor(String idVend, String fechaInicio, String fechaFinal) {
		return dao.findPedidosByVendedor(idVend, fechaInicio, fechaFinal);
	}
	
	public void loadProductosToPedido(List<String> items, NotaRemision pedido) {
		dao.loadProductosToPedido(items, pedido);
	}
	
	public void registerComision(String id) throws Exception {
		dao.registerComision(id);
	}
	
	public Boolean removeProducto(Integer idPedido, String idProducto)  {
		return dao.removeRow(idPedido, idProducto);
	}
	
	public Boolean updateCantidad(Integer idPedido, String idProducto, Integer cantidad) {
		return dao.updateCantidad(idPedido, idProducto, cantidad);
	}
	
	public Boolean updateEnviado(Integer idRuta, Boolean enviado) {
		return dao.updateEnviado(idRuta, enviado);
	}
	
	public Boolean updateRuta(Integer idPedido, Integer idRuta) {
		return dao.updateRuta(idPedido, idRuta);
	}
}
