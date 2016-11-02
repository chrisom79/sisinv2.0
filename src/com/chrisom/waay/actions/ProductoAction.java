package com.chrisom.waay.actions;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chrisom.sisinv.entity.Producto;
import com.chrisom.sisinv.model.PedidoModel;
import com.chrisom.sisinv.model.ProductoModel;
import com.chrisom.sisinv.utils.SISINVConstants;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

/**
 * Servlet implementation class ProductosAction
 */
@WebServlet("/ProductoAction")
public class ProductoAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductoAction() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String task = request.getParameter("task");
		ProductoModel prModel = new ProductoModel();
		PedidoModel peModel = new PedidoModel();
		
		if(SISINVConstants.TASKS.TASK_INIT.equalsIgnoreCase(task)) {
			Gson gson = new GsonBuilder().excludeFieldsWithoutExposeAnnotation().create();
			response.setContentType("application/json");
			Long id = peModel.getNewId();
			String searchElement = gson.toJson(id);
			response.getWriter().write(searchElement);
			
		} else if(SISINVConstants.TASKS.TASK_QSEARCH.equalsIgnoreCase(task)) {
			Gson gson = new GsonBuilder().excludeFieldsWithoutExposeAnnotation().create();
			response.setContentType("application/json");
			String term = request.getParameter("term");
			List<Producto> prods = prModel.findProductoByParameters(term);
			for(Producto prod : prods)
				if(prod.getOferta() != null && prod.getOferta().getId() != 0)
					System.out.println(prod.getOferta().getOfertaCompleta());
			String searchList = gson.toJson(prods);
			response.getWriter().write(searchList);
		} else if(SISINVConstants.TASKS.TASK_EDITAR.equalsIgnoreCase(task)) {
			Gson gson = new GsonBuilder().excludeFieldsWithoutExposeAnnotation().create();
			String codigo = request.getParameter("txtCodigo");
			String nombre = request.getParameter("txtNombre");
			Integer piezas = Integer.valueOf(request.getParameter("txtPiezas"));
			Double precio = Double.valueOf(request.getParameter("txtPrecioComp"));
			Integer ganancia = Integer.valueOf(request.getParameter("txtGanancia"));
			Boolean iva = Boolean.valueOf(request.getParameter("txtIVA"));
			String oldCodigo = request.getParameter("prevId");
			String comision = request.getParameter("txtComision");
			
			Producto producto = new Producto(codigo, nombre, precio, ganancia, iva);
			producto.setPiezas(piezas);
			if(comision != null)
				producto.setComision(Integer.valueOf(comision));
			
			if(!codigo.equals(oldCodigo)) {
				prModel.deleteById(oldCodigo);
			}
			prModel.updateProducto(producto);
			String prod = gson.toJson(producto);
			response.getWriter().write(prod);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String task = request.getParameter("task");
		ProductoModel model = new ProductoModel();
		
		if(SISINVConstants.TASKS.TASK_BUSCAR.equalsIgnoreCase(task)) {
			String texto = request.getParameter("txtBuscar");
			List<Producto> prods = model.findProductoByParameters(texto);
			
			for(Producto prod : prods) {
				if(prod.getOferta() != null && prod.getOferta().getId() != 0)
					System.out.println(prod.getOferta().getOfertaCompleta());
			}
			request.setAttribute("productos", prods);
			request.setAttribute("txtBuscar", texto);
			request.getRequestDispatcher("/buscar-prods.jsp").forward(request, response);
		} else if(SISINVConstants.TASKS.TASK_CREAR.equalsIgnoreCase(task)) {
			String codigo = request.getParameter("txtCodigo");
			String nombre = request.getParameter("txtNombre");
			Integer piezas = Integer.valueOf(request.getParameter("txtPiezas"));
			Double precio = Double.valueOf(request.getParameter("txtPrecioComp"));
			Integer ganancia = Integer.valueOf(request.getParameter("txtGanancia"));
			Boolean iva = Boolean.valueOf(request.getParameter("txtIVA"));
			String comision = request.getParameter("txtComision");
			
			Producto producto = new Producto(codigo, nombre, precio, ganancia, iva);
			producto.setPiezas(piezas);
			producto.setComision(Integer.valueOf(comision));
			
			String id = model.insertProducto(producto);
			if(id != null) {
				request.setAttribute("mensaje", "El producto ha sido guardado");
			}
			request.getRequestDispatcher("/home.jsp").forward(request, response);
		} else if(SISINVConstants.TASKS.GET_ITEM.equalsIgnoreCase(task)) {
			String productoId = request.getParameter("productoId");
			Producto prod = model.findProductoByCode(productoId);
			request.setAttribute("prod", prod);
			request.getRequestDispatcher("/editar-prods.jsp").forward(request, response);
		}  else if(SISINVConstants.TASKS.TASK_EDITAR.equalsIgnoreCase(task)) {
			String codigo = request.getParameter("txtCodigo");
			String nombre = request.getParameter("txtNombre");
			Integer piezas = Integer.valueOf(request.getParameter("txtPiezas"));
			Double precio = Double.valueOf(request.getParameter("txtPrecioComp"));
			Integer ganancia = Integer.valueOf(request.getParameter("txtGanancia"));
			Boolean iva = Boolean.valueOf(request.getParameter("txtIVA"));
			String oldCodigo = request.getParameter("prevId");
			String comision = request.getParameter("txtComision");
			
			Producto producto = new Producto(codigo, nombre, precio, ganancia, iva);
			producto.setPiezas(piezas);
			if(comision != null)
				producto.setComision(Integer.valueOf(comision));
			
			if(!codigo.equals(oldCodigo)) {
				model.deleteById(oldCodigo);
			}
			model.updateProducto(producto);
			request.setAttribute("mensaje", "El producto ha sido actualizado");
			request.getRequestDispatcher("/home.jsp").forward(request, response);
		} else if(SISINVConstants.TASKS.TASK_BORRAR.equalsIgnoreCase(task)) {
			String productoId = request.getParameter("productoId");
			model.deleteById(productoId);
			String texto = request.getParameter("txtBuscar");
			List<Producto> prods = model.findProductoByParameters(texto);
			request.setAttribute("txtBuscar", texto);
			request.setAttribute("productos", prods);
			request.getRequestDispatcher("/buscar-prods.jsp").forward(request, response);
		}
		
		
	}

}
