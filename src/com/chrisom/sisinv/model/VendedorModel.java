package com.chrisom.sisinv.model;

import java.util.List;

import org.apache.shiro.authc.credential.DefaultPasswordService;
import org.apache.shiro.crypto.RandomNumberGenerator;
import org.apache.shiro.crypto.SecureRandomNumberGenerator;
import org.apache.shiro.crypto.hash.Sha256Hash;
import org.apache.shiro.crypto.hash.SimpleHash;

import com.chrisom.sisinv.dao.VendedorDAO;
import com.chrisom.sisinv.entity.Vendedor;
import com.chrisom.sisinv.utils.Algorithms;
import com.chrisom.sisinv.utils.WaayException;

public class VendedorModel {
	VendedorDAO dao = new VendedorDAO();
	
	public void insertVendedor(Vendedor vendedor) {
		DefaultPasswordService passwordService = new DefaultPasswordService();
	    String encPass = passwordService.encryptPassword("password");
		vendedor.setPassword(encPass);	    
		dao.insert(vendedor);		
	}
	
	public void updateVendedor(Vendedor vendedor) throws Exception {
		vendedor.setPassword(dao.findVendedorById(vendedor.getId()).getPassword());
		dao.update(vendedor);
	}
	
	public void updatePassword(String id, String pass) throws WaayException {
		DefaultPasswordService passwordService = new DefaultPasswordService();
	    String encPass = passwordService.encryptPassword(pass);		
		dao.updatePassword(id, encPass);
	}
	
	public String createId(String nombre) {
		String[] splitted = nombre.trim().split("\\s");
		StringBuffer sb = new StringBuffer();
		
		for(String name : splitted){
			if(name != null && !name.trim().isEmpty())
				sb.append(name.substring(0, 1));
		}
		sb.append(dao.countIds(sb.toString()) + 1);
		return sb.toString().toLowerCase();
	}
	
	public boolean isLoginSuccess(String user, String password) {
		if(dao.findVendedorByUserAndPassword(user, Algorithms.encryptMD5(password)) != null) {
			return true;
		}
		
		return false;
	}
	
	public boolean existsUsername(String username) {
		if(dao.countUsernames(username) > 0) {
			return true;
		}
		
		return false;
	}
	
	public List<Vendedor> findVendedoresByParameters(String nombre, String telefono, String usuario) {
		return dao.findVendedorByParameters(nombre, telefono, usuario);
	}
	
	public List<Vendedor> findVendedoresByParameters(String value) {
		return dao.findVendedorByUnifiedParameters(value);
	}
	
	public Vendedor findVendedorByUsuario(String username){
		return dao.findVendedorByUsuario(username);
	}
	
	public Vendedor findVendedorById(String value) {
		return dao.findVendedorById(value);
	}
	
	public Vendedor finVendedorByEmail(String email) {
		return dao.finVendedorByEmail(email);
		
	}
	
	public void deleteById(String usuario){
		dao.logicDeleteById(usuario);
	}
}
