package com.chrisom.sisinv.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

import com.chrisom.sisinv.entity.Producto;

public class ProductoDAO implements DAOInterface<Producto> {

	@Override
	public String insert(Producto element) {
		Session session = SessionFactoryDB.getSessionFactory().openSession();
		String id = null;
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
	public void update(Producto element) {
		Session session = SessionFactoryDB.getSessionFactory().openSession();
		try {
			
			session.beginTransaction();
			session.saveOrUpdate(element);
			session.getTransaction().commit();
		} catch (Exception ex) {
			session.getTransaction().rollback();
		} 
		
	}

	@Override
	public Long countIds(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteByField(String field) {
		Session session = SessionFactoryDB.getSessionFactory().openSession();
		try {
			
			session.beginTransaction();
			Query query = session.createQuery("delete Producto where id = :id");
			query.setParameter("id", field);
			query.executeUpdate();
			session.getTransaction().commit();
		} catch (Exception ex) {
			session.getTransaction().rollback();
		} finally {
			//SessionFactoryDB.shutdown();
		}
	}
	
	public void logicDeleteById(String field) {
		Session session = SessionFactoryDB.getSessionFactory().openSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery("UPDATE Producto set habilitado = 0 WHERE id = :id");
			query.setParameter("id", field);
			query.executeUpdate();
			session.getTransaction().commit();
		} catch (Exception ex) {
			System.out.println(ex.getStackTrace().toString());
			session.getTransaction().rollback();
		} 
	}
	
	@SuppressWarnings("unchecked")
	public List<Producto> findProductoByNombre(String nombre){
		List<Producto> productos = new ArrayList<Producto>();
		Session session = SessionFactoryDB.getSessionFactory().openSession();
		Query query = session.createQuery("from Producto where habilitado = 1 and nombre like :nombre");
		
		query.setParameter("nombre", "%" + nombre + "%");
		
		productos = query.list();
		return productos;
	}
	
	public Producto findProductoByCode(String id){
		Producto producto = new Producto();
		Session session = SessionFactoryDB.getSessionFactory().openSession();
		Query query = session.createQuery("from Producto where habilitado = 1 and id like :id");
		
		query.setParameter("id", id);
		
		producto = (Producto) query.uniqueResult();
		return producto;
	}
	
	@SuppressWarnings("unchecked")
	public List<Producto> findProductoByParameters(String id) {
		List<Producto> productos = new ArrayList<Producto>();
		Session session = SessionFactoryDB.getSessionFactory().openSession();
		StringBuffer querySb = new StringBuffer("FROM Producto prod "); //RIGHT JOIN Oferta ofer ON prod.oferta.id = ofer.id ");
		querySb.append("where prod.habilitado = 1 ");
		
		if(id != null && !id.isEmpty()) {
			querySb.append("and (prod.id like '%" + id + "%' or prod.nombre like '%" + id + "%')");
		}
		
		Query query = session.createQuery(querySb.toString());
		
		productos = query.list();
		return productos;
	}
	
	public Integer getMaxIdToInsert() {
		String id = null;
		Session session = SessionFactoryDB.getSessionFactory().openSession();
		Query query = session.createQuery("select id from Producto where id < 100000 order by id desc");
		query.setMaxResults(1);
		id = (String) query.uniqueResult();
		return Integer.valueOf(id);
	}
	
	public void setOferta(String id, Integer idOferta) {
		Session session = SessionFactoryDB.getSessionFactory().openSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery("UPDATE Producto set oferta.id = :idOferta WHERE id = :id");
			query.setParameter("id", id);
			query.setParameter("idOferta", idOferta);
			query.executeUpdate();
			session.getTransaction().commit();
		} catch (Exception ex) {
			System.out.println(ex.getStackTrace().toString());
			session.getTransaction().rollback();
		} 
	}

}
