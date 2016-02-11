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
		return dao.insert(pedido);
	}
	
	public List<NotaRemision> findLastPedidos(Integer limit) {
		return dao.findLastPedidos(limit);
	}
	
	public List<NotaRemision> findPedidosByParameters(String value, String fechaInicio, String fechaFinal) {
		return dao.findPedidosByParameters(value, fechaInicio, fechaFinal);
	}
	
	public NotaRemision findPedidoById(Integer value) {
		return dao.findPedidoById(value);
	}
	
	public List<ItemPedido> findItemsByPedido(Integer id) {
		return dao.findItemsByPedido(id);
	}
}
