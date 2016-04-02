package com.chrisom.sisinv.model;

import com.chrisom.sisinv.dao.ComisionDAO;
import com.chrisom.sisinv.entity.VendedorComision;

public class ComisionModel {
	ComisionDAO dao = new ComisionDAO();
	
	public String insertComision(VendedorComision com) {
		return dao.insert(com);
	}
}
