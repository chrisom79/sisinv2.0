package com.chrisom.actions;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.ResourceBundle;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chrisom.sisinv.entity.Producto;
import com.chrisom.sisinv.model.PedidoModel;
import com.chrisom.sisinv.model.ProductoModel;
import com.chrisom.sisinv.utils.ProductoUtils;
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
		
		if(SISINVConstants.TASK_INIT.equalsIgnoreCase(task)) {
			Gson gson = new GsonBuilder().excludeFieldsWithoutExposeAnnotation().create();
			response.setContentType("application/json");
			Long id = peModel.getNewId();
			String searchElement = gson.toJson(id);
			response.getWriter().write(searchElement);
			
		} else if(SISINVConstants.TASK_QSEARCH.equalsIgnoreCase(task)) {
			Gson gson = new GsonBuilder().excludeFieldsWithoutExposeAnnotation().create();
			response.setContentType("application/json");
			String term = request.getParameter("term");
			List<Producto> prods = prModel.findProductoByParameters(term);
			String searchList = gson.toJson(prods);
			response.getWriter().write(searchList);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String task = request.getParameter("task");
		ProductoModel model = new ProductoModel();
		
		if(SISINVConstants.TASK_BUSCAR.equalsIgnoreCase(task)) {
			String texto = request.getParameter("txtBuscar");
			List<Producto> prods = model.findProductoByParameters(texto);
			request.setAttribute("productos", prods);
			request.getRequestDispatcher("/buscar-prods.jsp").forward(request, response);
		} else if(SISINVConstants.TASK_CREAR.equalsIgnoreCase(task)) {
			String codigo = request.getParameter("txtCodigo");
			String nombre = request.getParameter("txtNombre");
			Double precio = Double.valueOf(request.getParameter("txtPrecioComp"));
			Integer ganancia = Integer.valueOf(request.getParameter("txtGanancia"));
			Boolean iva = Boolean.valueOf(request.getParameter("txtIVA"));
			
			Producto producto = new Producto(codigo, nombre, precio, ganancia, iva);
			String id = model.insertProducto(producto);
			if(id != null) {
				request.setAttribute("mensaje", "El producto ha sido guardado");
			}
			request.getRequestDispatcher("/home.jsp").forward(request, response);
		}
		
		
	}

}
