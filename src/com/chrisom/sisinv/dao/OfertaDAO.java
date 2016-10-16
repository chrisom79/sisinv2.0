package com.chrisom.sisinv.dao;

import java.io.Serializable;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.transform.Transformers;
import org.hibernate.type.*;

import com.chrisom.sisinv.entity.ItemOferta;
import com.chrisom.sisinv.entity.Oferta;

public class OfertaDAO implements DAOInterface<Oferta> {

	@Override
	public String insert(Oferta element) {
		Session session = SessionFactoryDB.getSessionFactory().openSession();
		String id = null;
		try {
			session.beginTransaction();
			Serializable serie = session.save(element);
			
			session.getTransaction().commit();
		} catch (Exception ex) {
			session.getTransaction().rollback();
		} 
		
		return id;
	}

	@Override
	public void update(Oferta element) throws Exception {
		Session session = SessionFactoryDB.getSessionFactory().openSession();
		try {	
			session.beginTransaction();
			session.saveOrUpdate(element);
			session.getTransaction().commit();
		} catch (Exception ex) {
			session.getTransaction().rollback();
			throw new Exception(ex);
		}
	}

	@Override
	public Long countIds(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteByField(String field) throws Exception {
		Session session = SessionFactoryDB.getSessionFactory().openSession();
		try {	
			session.beginTransaction();
			Query query = session.createQuery("DELETE FROM Oferta WHERE oferta_id = :id");
			query.setParameter("id", Integer.valueOf(field));
			query.executeUpdate();
			session.getTransaction().commit();
		} catch (Exception ex) {
			session.getTransaction().rollback();
			throw new Exception(ex);
		}
	}
	
	public Integer getMaxIdToInsert() {
		Integer id = null;
		Session session = SessionFactoryDB.getSessionFactory().openSession();
		Query query = session.createQuery("select id from Oferta order by id desc");
		query.setMaxResults(1);
		id = (Integer) query.uniqueResult();
		return Integer.valueOf(id);
	}
	
	public List<ItemOferta> findOfertaByParameters(String name, Integer tipo, String idProducto) {
		List<ItemOferta> ofertas = null;
		Session session = SessionFactoryDB.getSessionFactory().openSession();
		StringBuffer sb = new StringBuffer("SELECT ofer.oferta_id as id, ofer.descripcion, ofer.tipo, "); 
		sb.append("CASE WHEN ofer.tipo = 1 THEN 'Descuento' ");
		sb.append("WHEN ofer.tipo = 2 THEN 'Compra-Llevate' ");
		sb.append("WHEN ofer.tipo = 3 THEN 'Compra-Por' ");
		sb.append("ELSE 'No existe' END as nombreTipo, ");
		sb.append("prod.producto_id as codigo, prod.nombre ");
		sb.append("FROM oferta ofer ");
		sb.append("INNER JOIN producto prod ON ofer.oferta_id = prod.oferta_id ");
		
		if((name != null && !name.trim().isEmpty()) || tipo != null || (idProducto != null && !idProducto.trim().isEmpty())) {
			sb.append("WHERE ");
			if(name != null && !name.trim().isEmpty()) {
				sb.append("ofer.descripcion like '%" + name + "%' ");
			}
			
			if(tipo != null) {
				if(name != null && !name.isEmpty()) {
					sb.append("and ");
				}
				sb.append("ofer.tipo = " + tipo + " ");
			}
			
			if(idProducto != null && !idProducto.trim().isEmpty()) {
				if((name != null && !name.isEmpty()) || tipo != null) {
					sb.append("and ");
				}
				sb.append("prod.producto_id = " + idProducto  + " ");
			}
		}
		
		Query query = session.createSQLQuery(sb.toString())
				.addScalar("id", new IntegerType())
				.addScalar("descripcion", new StringType())
				.addScalar("tipo", new IntegerType())
				.addScalar("nombreTipo", new StringType())
				.addScalar("codigo", new StringType())
				.addScalar("nombre", new StringType())
				.setResultTransformer(Transformers.aliasToBean(ItemOferta.class));
		
		ofertas = query.list();
		
		return ofertas;
	}
	
	public Oferta findOfertaById(Integer id) {
		Oferta oferta = null;
		Session session = SessionFactoryDB.getSessionFactory().openSession();
		Query query = session.createQuery("from Oferta where oferta_id = :id");
		
		query.setParameter("id", id);
		
		
		oferta = (Oferta) query.uniqueResult();
		
		return oferta;
	}
}
