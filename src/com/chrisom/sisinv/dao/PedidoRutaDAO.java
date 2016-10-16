package com.chrisom.sisinv.dao;

import org.hibernate.Session;

import com.chrisom.sisinv.entity.PedidoRuta;

public class PedidoRutaDAO implements DAOInterface<PedidoRuta> {

	@Override
	public String insert(PedidoRuta element) {
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
	public void update(PedidoRuta element) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Long countIds(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteByField(String field) {
		// TODO Auto-generated method stub
		
	}

	

}
