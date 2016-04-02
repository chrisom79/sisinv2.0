package com.chrisom.sisinv.dao;

import org.hibernate.Session;

import com.chrisom.sisinv.entity.VendedorComision;

public class ComisionDAO implements DAOInterface<VendedorComision> {

	@Override
	public Long countIds(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteByField(String field) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public String insert(VendedorComision element) {
		Session session = SessionFactoryDB.getSessionFactory().openSession();
		String id =  null;
		try {
			
			session.beginTransaction();
			id = session.save(element).toString();
			session.getTransaction().commit();
		} catch (Exception ex) {
			session.getTransaction().rollback();
		} 
		
		return id;
	}

	@Override
	public void update(VendedorComision element) throws Exception {
		// TODO Auto-generated method stub
		
	}

}
