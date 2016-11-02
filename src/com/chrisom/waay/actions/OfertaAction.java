package com.chrisom.waay.actions;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chrisom.sisinv.entity.ItemOferta;
import com.chrisom.sisinv.entity.Oferta;
import com.chrisom.sisinv.entity.Producto;
import com.chrisom.sisinv.model.OfertaModel;
import com.chrisom.sisinv.model.ProductoModel;
import com.chrisom.sisinv.utils.SISINVBackConstants.OFERTA_TIPO;
import com.chrisom.sisinv.utils.SISINVConstants;

/**
 * Servlet implementation class OfertaAction
 */
@WebServlet("/OfertaAction")
public class OfertaAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OfertaAction() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String task = request.getParameter("task");
		OfertaModel model = new OfertaModel();
		
		if(SISINVConstants.TASKS.TASK_CREAR.equalsIgnoreCase(task)) {
			String idProducto = request.getParameter("producto");
			Oferta oferta = createObject(request, null);
			
			Integer id = model.insertOferta(oferta, idProducto);
			if(id != null) {
				request.setAttribute("mensaje", "La oferta ha sido guardada");
			}
			request.getRequestDispatcher("/home.jsp").forward(request, response);
		} else if(SISINVConstants.TASKS.TASK_BUSCAR.equalsIgnoreCase(task)) {
			String nombre = request.getParameter("txtNombre");
			String tipo = request.getParameter("tipo");
			String prodId = request.getParameter("producto");
			Integer idTipo = null;
			if(OFERTA_TIPO.DESC.getNombre().equals(tipo)) {
				idTipo = OFERTA_TIPO.DESC.getId();
			} else if(OFERTA_TIPO.COMPRA_LLEVA.getNombre().equals(tipo)) {
				idTipo = OFERTA_TIPO.COMPRA_LLEVA.getId();
			} else if(OFERTA_TIPO.COMPRA_POR.getNombre().equals(tipo)) {
				idTipo = OFERTA_TIPO.COMPRA_POR.getId();
			}
			
			List<ItemOferta> ofertas = model.findOfertasByParameters(nombre, idTipo, prodId);
			request.setAttribute("ofertas", ofertas);
			request.getRequestDispatcher("/buscar-oferta.jsp").forward(request, response);
		} else if(SISINVConstants.TASKS.TASK_EDITAR.equalsIgnoreCase(task)) {
			ProductoModel prodModel = new ProductoModel();
			String idProducto = request.getParameter("producto");
			String prevIdProducto = request.getParameter("prevProducto");
			String idOferta = request.getParameter("idOferta");
			
			Oferta oferta = createObject(request, Integer.valueOf(idOferta));
			try {
				model.updateOferta(oferta, idProducto, prevIdProducto);
				
				request.setAttribute("mensaje", "La oferta se ha actualizado");
			} catch (Exception e) {
				request.setAttribute("error", "La oferta no se pudo actualizar");
			}
			
			request.getRequestDispatcher("/home.jsp").forward(request, response);
		} else if(SISINVConstants.TASKS.GET_ITEM.equalsIgnoreCase(task)) {
			String idOferta = request.getParameter("idOferta");
			String idProducto = request.getParameter("producto");
			
			Oferta oferta = model.findOfertaAndProductoById(Integer.valueOf(idOferta), idProducto);
			
			request.setAttribute("oferta", oferta);
			request.getRequestDispatcher("/editar-oferta.jsp").forward(request, response);
		} else if(SISINVConstants.TASKS.TASK_BORRAR.equalsIgnoreCase(task)) {
			String idOferta = request.getParameter("idOferta");
			String idProducto = request.getParameter("producto");
			
			try {
				model.deleteOferta(idOferta, idProducto);
				request.setAttribute("mensaje", "La oferta se ha borrado");
			} catch (Exception e) {
				request.setAttribute("error", "La oferta no se pudo borrar");
			}
			request.getRequestDispatcher("/home.jsp").forward(request, response);
		}
	}
	
	private Oferta createObject(HttpServletRequest request, Integer id) {
		Oferta oferta = null;
		String nombre = request.getParameter("txtNombre");
		String tipo = request.getParameter("tipo");
		
		if(request != null) {
			if(id != null)
				oferta = new Oferta(id, nombre);
			else {
				oferta = new Oferta();
				oferta.setDescripcion(nombre);
			}
			
			if(tipo.equalsIgnoreCase(OFERTA_TIPO.DESC.getNombre())) {
				String descuento = request.getParameter("txtDescuento");
				oferta.setTipo(OFERTA_TIPO.DESC.getId());
				oferta.setDescuento(Integer.parseInt(descuento));
			} else if (tipo.equalsIgnoreCase(OFERTA_TIPO.COMPRA_LLEVA.getNombre())) {
				String compra = request.getParameter("txtCompra");
				String llevate = request.getParameter("txtLlevate");
				oferta.setTipo(OFERTA_TIPO.COMPRA_LLEVA.getId());
				oferta.setCompra(Integer.parseInt(compra));
				oferta.setLleva(Integer.parseInt(llevate));
			} else if (tipo.equalsIgnoreCase(OFERTA_TIPO.COMPRA_POR.getNombre())) {
				String compra = request.getParameter("txtCompra2");
				String por = request.getParameter("txtPor");
				oferta.setTipo(OFERTA_TIPO.COMPRA_POR.getId());
				oferta.setCompra(Integer.parseInt(compra));
				oferta.setPor(Double.parseDouble(por));
			}
		}
		return oferta;
	}

}
