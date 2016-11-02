package com.chrisom.sisinv.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

import com.chrisom.sisinv.entity.Vendedor;
import com.chrisom.sisinv.utils.WaayException;

public class VendedorDAO implements DAOInterface<Vendedor>{
	

	@Override
	public String insert(Vendedor vendedor) {
		Session session = SessionFactoryDB.getSessionFactory().openSession();
		String id = null;
		try {
			
			session.beginTransaction();
			id = session.save(vendedor).toString();
			session.getTransaction().commit();
		} catch (Exception ex) {
			session.getTransaction().rollback();
		} 
		return id;
	}
	
	@Override
	public Long countIds(String id) {
		Session session = SessionFactoryDB.getSessionFactory().openSession();
		Long total = null;
		try {
			Query query = session.createQuery("select count(id) from Vendedor where id like :idVendedor");
			query.setParameter("idVendedor", id + "%");
		
			total = (Long) query.uniqueResult();
		} catch (Exception ex) {
			System.out.println(ex.getStackTrace());
		} finally {
			//SessionFactoryDB.shutdown();
		}
		
		return total;
	}
	
	public Vendedor findVendedorByUserAndPassword(String user, String password) {
		Session session = SessionFactoryDB.getSessionFactory().openSession();
		Vendedor vendedor = null;
		try {
			Query query = session.createQuery("from Vendedor where usuario = :user and password = :password");
			query.setParameter("user", user);
			query.setParameter("password", password);
			
			vendedor = (Vendedor) query.uniqueResult();
		
		} catch (Exception ex) {
			System.out.println(ex.getStackTrace());
		} finally {
			//SessionFactoryDB.shutdown();
		}

		return vendedor;
	}
	
	public Vendedor findVendedorByUser(String user) {
		Session session = SessionFactoryDB.getSessionFactory().openSession();
		Vendedor vendedor = null;
		try {
			Query query = session.createQuery("from Vendedor where usuario = :user");
			query.setParameter("user", user);
			
			vendedor = (Vendedor) query.uniqueResult();
		
		} catch (Exception ex) {
			System.out.println(ex.getStackTrace());
		} finally {
			//SessionFactoryDB.shutdown();
		}

		return vendedor;
	}
	public Long countUsernames(String username) {
		Session session = SessionFactoryDB.getSessionFactory().openSession();
		Long total = null;
		try {
			Query query = session.createQuery("select count(id) from Vendedor where usuario = :usuario");
			query.setParameter("usuario", username);
		
			total = (Long) query.uniqueResult();
		} catch (Exception ex) {
			System.out.println(ex.getStackTrace());
		} finally {
			//SessionFactoryDB.shutdown();
		}
		
		return total;
	}
	
	@SuppressWarnings("unchecked")
	public List<Vendedor> findVendedorByParameters(String nombre, String telefono, String usuario) {
		List<Vendedor> vendedores = new ArrayList<Vendedor>();
		Session session = SessionFactoryDB.getSessionFactory().openSession();
		
		StringBuffer querySb = new StringBuffer("from Vendedor where habilitado = 1 ");
		
		if(nombre != null && !nombre.isEmpty()) {
			querySb.append("and nombre like :name ");
		}
		
		if(telefono != null && !telefono.isEmpty()) {
			querySb.append("and telefono like :tel ");
			
		}
		
		if(usuario != null && !usuario.isEmpty()) {
			querySb.append("and usuario like :user ");
		}
		
		Query query = session.createQuery(querySb.toString());
		
		if(nombre != null && !nombre.isEmpty()) {
			query.setParameter("name", "%" + nombre + "%");
		}
		
		if(telefono != null && !telefono.isEmpty()) {
			query.setParameter("tel", "%" + telefono + "%");
		}
		
		if(usuario != null && !usuario.isEmpty()) {
			query.setParameter("user", "%" + usuario + "%");
		}
		
		vendedores.addAll(query.list());
		
		return vendedores;
	}
	
	@SuppressWarnings("unchecked")
	public List<Vendedor> findVendedorByUnifiedParameters(String value) {
		List<Vendedor> vendedores = new ArrayList<Vendedor>();
		Session session = SessionFactoryDB.getSessionFactory().openSession();
		
		StringBuffer querySb = new StringBuffer("from Vendedor where (nombre like :value or usuario like :value) and habilitado = 1");
		Query query = session.createQuery(querySb.toString());
		
		query.setParameter("value", "%" + value + "%");
		
		vendedores.addAll(query.list());
		return vendedores;
	}
	
	public Vendedor findVendedorByUsuario(String username) {
		Session session = SessionFactoryDB.getSessionFactory().openSession();
		Vendedor vendedor = null;
		try {
			Query query = session.createQuery("from Vendedor where usuario = :usuario and habilitado = 1");
			query.setParameter("usuario", username);
		
			vendedor = (Vendedor) query.uniqueResult();
		} catch (Exception ex) {
			System.out.println(ex.getStackTrace());
		} finally {
			//SessionFactoryDB.shutdown();
		}
		
		return vendedor;
	}
	
	public Vendedor findVendedorById(String value) {
		Session session = SessionFactoryDB.getSessionFactory().openSession();
		Vendedor vendedor = null;
		try {
			Query query = session.createQuery("from Vendedor where id like :id");
			query.setParameter("id", value);
		
			vendedor = (Vendedor) query.uniqueResult();
		} catch (Exception ex) {
			System.out.println(ex.getStackTrace());
		} 
		
		return vendedor;
	}
	
	public Vendedor finVendedorByEmail(String email) {		
		Session session = SessionFactoryDB.getSessionFactory().openSession();
		Vendedor vendedor = null;
		try {
			Query query = session.createQuery("from Vendedor where email = :email");
			query.setParameter("email", email);
		
			vendedor = (Vendedor) query.uniqueResult();
		} catch (Exception ex) {
			System.out.println(ex.getStackTrace());
		} 
		
		return vendedor;
	}

	@Override
	public void update(Vendedor element) throws Exception {
		Session session = SessionFactoryDB.getSessionFactory().openSession();
		try {
			
			session.beginTransaction();
			session.update(element);
			session.getTransaction().commit();
		} catch (Exception ex) {
			System.out.println(ex.getStackTrace().toString());
			session.getTransaction().rollback();
			throw new Exception();
			
		} 
		
	}
	
	public void updatePassword(String id, String pass) throws WaayException {
		Session session = SessionFactoryDB.getSessionFactory().openSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery("UPDATE Vendedor set password = :pass WHERE usuario = :id");
			query.setParameter("pass", pass);
			query.setParameter("id", id);
			query.executeUpdate();
			session.getTransaction().commit();
		} catch (Exception ex) {
			System.out.println(ex.getStackTrace().toString());
			session.getTransaction().rollback();
			throw new WaayException("Password no actualizado: " + ex);
		} 
	}

	public void logicDeleteById(String field) {
		Session session = SessionFactoryDB.getSessionFactory().openSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery("UPDATE Vendedor set habilitado = 0 WHERE id = :id");
			query.setParameter("id", field);
			query.executeUpdate();
			session.getTransaction().commit();
		} catch (Exception ex) {
			System.out.println(ex.getStackTrace().toString());
			session.getTransaction().rollback();
		} 
	}
	
	@Override
	public void deleteByField(String field) {
		Session session = SessionFactoryDB.getSessionFactory().openSession();
		try {
			
			session.beginTransaction();
			Query query = session.createQuery("delete Vendedor where id = :id");
			query.setParameter("id", field);
			query.executeUpdate();
			session.getTransaction().commit();
		} catch (Exception ex) {
			session.getTransaction().rollback();
		} finally {
			//SessionFactoryDB.shutdown();
		}
		
	}
	
	
}
