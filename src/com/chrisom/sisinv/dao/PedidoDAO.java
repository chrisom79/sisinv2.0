package com.chrisom.sisinv.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.transform.Transformers;
import org.hibernate.type.DoubleType;
import org.hibernate.type.IntegerType;
import org.hibernate.type.StringType;

import com.chrisom.sisinv.entity.ItemPedido;
import com.chrisom.sisinv.entity.NotaRemision;

public class PedidoDAO implements DAOInterface<NotaRemision> {

	@Override
	public String insert(NotaRemision element) {
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
	public void update(NotaRemision element) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Long countIds(String id) {
		Session session = SessionFactoryDB.getSessionFactory().openSession();
		Long total = null;
		try {
			Query query = session.createQuery("select count(id) from NotaRemision");
		
			total = (Long) query.uniqueResult();
		} catch (Exception ex) {
			System.out.println(ex.getStackTrace());
		}
		
		return total;
	}

	@Override
	public void deleteByField(String field) {
		// TODO Auto-generated method stub
		
	}
	
	public List<NotaRemision> findLastPedidos(Integer limit) {
		List<NotaRemision> pedidos = new ArrayList<NotaRemision>();
		Session session = SessionFactoryDB.getSessionFactory().openSession();
		Query query = session.createQuery("from NotaRemision order by fecha desc");
		query.setMaxResults(limit);
		
		pedidos = query.list();
		
		return pedidos;
	}
	
	public List<NotaRemision> findPedidosByParameters(String value, String fechaInicio, String fechaFinal) {
		List<NotaRemision> pedidos = new ArrayList<NotaRemision>();
		Session session = SessionFactoryDB.getSessionFactory().openSession();
		StringBuffer sb = new StringBuffer("from NotaRemision ");
		
		if((value != null && !value.isEmpty()) || fechaInicio != null || fechaFinal != null) {
			sb.append("where ");
			if(value != null && !value.isEmpty()){
				sb.append("nombre like '%" + value + "%' and ");
			}
			
			if(fechaInicio != null) {
				sb.append("fecha >= '" + fechaInicio + "' ");
			}
			
			if(fechaFinal != null) {
				sb.append("and fecha <= '" + fechaFinal + "' ");
			}
		}
		
		Query query = session.createQuery(sb.toString());
		
		pedidos = query.list();
		return pedidos;
	}
	
	public NotaRemision findPedidoById(Integer value) {
		NotaRemision pedido = null;
		Session session = SessionFactoryDB.getSessionFactory().openSession();
		
		if(value != null ) {
			pedido = new NotaRemision();
			Query query = session.createQuery("from NotaRemision where id = :id");
			query.setParameter("id", value);
			pedido = (NotaRemision) query.uniqueResult();
		}
		return pedido;
	}
	
	public List<ItemPedido> findItemsByPedido(Integer id) {
		List<ItemPedido> items = null;
		Session session = SessionFactoryDB.getSessionFactory().openSession();
		
		if(id != null) {
			StringBuffer sb = new StringBuffer("select nrd.cantidad, p.producto_id as id, p.nombre as articulo, nrd.precio, (nrd.precio * nrd.cantidad) as importe ");
			sb.append("from nota_remision nr ");
			sb.append("inner join nota_remision_detalle nrd on nr.notaremision_id = nrd.notaremision_id ");
			sb.append("inner join producto p on nrd.producto_id = p.producto_id where nr.notaremision_id = :id ");
			Query query = session.createSQLQuery(sb.toString())
					.addScalar("cantidad", new IntegerType())
					.addScalar("id", new StringType())
					.addScalar("articulo", new StringType())
					.addScalar("precio", new DoubleType())
					.addScalar("importe", new DoubleType())
					.setResultTransformer(Transformers.aliasToBean(ItemPedido.class));
			query.setParameter("id", id);
			items = query.list();
		}
		
		return items;
	}

}
