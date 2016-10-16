package com.chrisom.sisinv.model;

import com.chrisom.sisinv.dao.PedidoRutaDAO;
import com.chrisom.sisinv.entity.PedidoRuta;

public class PedidoRutaModel {
	private PedidoRutaDAO dao = new PedidoRutaDAO();
	
	public String insertPedidoRuta(PedidoRuta pr) {
		return dao.insert(pr);
	}
}
