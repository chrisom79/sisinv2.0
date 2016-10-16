package com.chrisom.sisinv.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.transform.Transformers;
import org.hibernate.type.BooleanType;
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
	
	public void loadProductosToPedido(List<String> items, NotaRemision pedido) {
		Session session = SessionFactoryDB.getSessionFactory().openSession();
		try {
			session.beginTransaction();
			for(String item : items) {
				Query query = session.createQuery("UPDATE NotaRemisionDetalle set cargado = 1 WHERE productoId = :id and notaRemision = :nota");
				query.setParameter("id", item);
				query.setParameter("nota", pedido);
				query.executeUpdate();
			}
			session.getTransaction().commit();
		} catch (Exception ex) {
			System.out.println(ex.getStackTrace().toString());
			session.getTransaction().rollback();
		} 
	}
	
	public List<NotaRemision> findLastPedidos(Integer limit) {
		List<NotaRemision> pedidos = new ArrayList<NotaRemision>();
		Session session = SessionFactoryDB.getSessionFactory().openSession();
		Query query = session.createQuery("from NotaRemision order by fecha desc");
		query.setMaxResults(limit);
		
		pedidos = query.list();
		
		return pedidos;
	}
	
	public List<NotaRemision> findPedidosByParameters(String value, String fechaInicio, String fechaFinal, Boolean enviado) {
		List<NotaRemision> pedidos = new ArrayList<NotaRemision>();
		Session session = SessionFactoryDB.getSessionFactory().openSession();
		StringBuffer sb = new StringBuffer("from NotaRemision ");
		
		if((value != null && !value.isEmpty()) || fechaInicio != null || fechaFinal != null) {
			sb.append("where ");
			if(value != null && !value.isEmpty()){
				sb.append("(nombre like '%" + value + "%' or ");
				sb.append("vendedor.nombre like '%" + value + "%' or ");
				sb.append("vendedor.usuario like '%" + value + "%') and ");
			}
			
			if(fechaInicio != null) {
				sb.append("fecha >= '" + fechaInicio + "' ");
			}
			
			if(fechaFinal != null) {
				sb.append("and fecha <= '" + fechaFinal + "' ");
			}
			
			if(enviado != null) {
				sb.append("and enviado = " + enviado + " ");
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
	
	public List<NotaRemision>  findPedidosByVendedor(String idVend, String fechaInicio, String fechaFinal) {
		List<NotaRemision> pedidos = new ArrayList<NotaRemision>();
		Session session = SessionFactoryDB.getSessionFactory().openSession();
		StringBuffer sb = new StringBuffer("from NotaRemision where vendedor like '" + idVend + "' ");
		
		if(fechaInicio != null) {
			sb.append("and fecha >= '" + fechaInicio + "' ");
		}
		
		if(fechaFinal != null) {
			sb.append("and fecha <= '" + fechaFinal + "' ");
		}

		Query query = session.createQuery(sb.toString());
		
		pedidos = query.list();
		return pedidos;
	}
	
	public List<ItemPedido> findItemsByPedido(Integer id) {
		List<ItemPedido> items = null;
		Session session = SessionFactoryDB.getSessionFactory().openSession();
		
		if(id != null) {
			StringBuffer sb = new StringBuffer("select nrd.cantidad, p.producto_id as id, p.nombre as articulo, nrd.precio, nrd.precio_final as precioFinal, nrd.cargado, nrd.importe ");
			sb.append("from nota_remision nr ");
			sb.append("inner join nota_remision_detalle nrd on nr.notaremision_id = nrd.notaremision_id ");
			sb.append("inner join producto p on nrd.producto_id = p.producto_id where nr.notaremision_id = :id ");
			Query query = session.createSQLQuery(sb.toString())
					.addScalar("cantidad", new IntegerType())
					.addScalar("id", new StringType())
					.addScalar("articulo", new StringType())
					.addScalar("precio", new DoubleType())
					.addScalar("precioFinal", new DoubleType())
					.addScalar("importe", new DoubleType())
					.addScalar("cargado", new BooleanType())
					.setResultTransformer(Transformers.aliasToBean(ItemPedido.class));
			query.setParameter("id", id); 
			items = query.list();
		}
		
		return items;
	}
	
	public void registerComision(String field) throws Exception {
		Session session = SessionFactoryDB.getSessionFactory().openSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery("UPDATE NotaRemisionDetalle set fecha_pago_comision = CURRENT_DATE WHERE producto_id = :id");
			query.setParameter("id", field);
			query.executeUpdate();
			session.getTransaction().commit();
		} catch (Exception ex) {
			System.out.println(ex.getStackTrace().toString());
			session.getTransaction().rollback();
			throw new Exception();
		} 
	}
	
	public Boolean removeRow(Integer idPedido, String idProducto) {
		Session session = SessionFactoryDB.getSessionFactory().openSession();
		Boolean success = false;
		try {
			Transaction transaction = session.beginTransaction();
			Query query = session.createQuery("delete from NotaRemisionDetalle where notaRemision.id = :idPedido and productoId = :idProducto");
			query.setParameter("idPedido", idPedido);
			query.setParameter("idProducto", idProducto);
			int n = query.executeUpdate();
			transaction.commit();
			if(n > 0)
				success = true;
			else
				success = false;
		} catch (Exception ex) {
			session.getTransaction().rollback();
			success = false;
		} 
		
		return success;
	}
	
	public Boolean updateCantidad(Integer idPedido, String idProducto, Integer cantidad) {
		Session session = SessionFactoryDB.getSessionFactory().openSession();
		Boolean success = false;
		try {
			session.beginTransaction();
			Query query = session.createQuery("UPDATE NotaRemisionDetalle set cantidad = :cantidad where notaRemision.id = :idPedido and productoId = :idProducto");
			query.setParameter("cantidad", cantidad);
			query.setParameter("idPedido", idPedido);
			query.setParameter("idProducto", idProducto);
			int n = query.executeUpdate();
			if(n > 0)
				success = true;
			else
				success = false;
			session.getTransaction().commit();
		} catch (Exception ex) {
			System.out.println(ex.getStackTrace().toString());
			session.getTransaction().rollback();
			success = false;
		}
		
		return success;
	}
	
	public Boolean updateRuta(Integer idPedido, Integer idRuta) {
		Session session = SessionFactoryDB.getSessionFactory().openSession();
		Boolean success = false;
		try {
			session.beginTransaction();
			Query query = session.createQuery("UPDATE NotaRemision set ruta.id = :idRuta where id = :idPedido");
			query.setParameter("idRuta", idRuta);
			query.setParameter("idPedido", idPedido);
			
			int n = query.executeUpdate();
			if(n > 0)
				success = true;
			else
				success = false;
			session.getTransaction().commit();
		} catch (Exception ex) {
			System.out.println(ex.getStackTrace().toString());
			session.getTransaction().rollback();
			success = false;
		}
		
		return success;
	}
	
	public Boolean updateEnviado(Integer idRuta, Boolean enviado) {
		Session session = SessionFactoryDB.getSessionFactory().openSession();
		Boolean success = false;
		try {
			session.beginTransaction();
			Query query = session.createQuery("UPDATE NotaRemision set enviado = :enviado where ruta.id = :idRuta");
			query.setParameter("enviado", enviado);
			query.setParameter("idRuta", idRuta);
			
			int n = query.executeUpdate();
			if(n > 0)
				success = true;
			else
				success = false;
			session.getTransaction().commit();
		} catch (Exception ex) {
			System.out.println(ex.getStackTrace().toString());
			session.getTransaction().rollback();
			success = false;
		}
		
		return success;
	}

}
