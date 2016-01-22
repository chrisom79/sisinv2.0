package com.chrisom.actions;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chrisom.sisinv.entity.Producto;
import com.chrisom.sisinv.entity.Vendedor;
import com.chrisom.sisinv.model.VendedorModel;
import com.chrisom.sisinv.utils.Algorithms;
import com.chrisom.sisinv.utils.SISINVConstants;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

/**
 * Servlet implementation class VendedorAction
 */
@WebServlet("/VendedorAction")
public class VendedorAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public VendedorAction() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String task = request.getParameter("task");
		VendedorModel model = new VendedorModel();
		
		if(SISINVConstants.TASK_QSEARCH.equalsIgnoreCase(task)) {
			Gson gson = new GsonBuilder().excludeFieldsWithoutExposeAnnotation().create();
			response.setContentType("application/json");
			String term = request.getParameter("term");
			List<Vendedor> vends = model.findVendedoresByParameters(term);
			String searchList = gson.toJson(vends);
			response.getWriter().write(searchList);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String task = request.getParameter("task");
		VendedorModel model = new VendedorModel();
		
		if(SISINVConstants.TASK_CREAR.equalsIgnoreCase(task))  {
			String nombre = request.getParameter("txtNombre");
			String direccion = request.getParameter("txtDireccion");
			String email = request.getParameter("txtEmail");
			String telefono = request.getParameter("txtTelefono");
			String usuario = request.getParameter("txtUsuario");
			
			if(!model.existsUsername(usuario)) {
				String defPass = Algorithms.encryptMD5("password");
				String id = model.createId(nombre);
				
				Vendedor vendedor = new Vendedor(id, nombre, telefono, usuario, defPass);
				vendedor.setDireccion(direccion);
				vendedor.setEmail(email);
				
				model.insertVendedor(vendedor);
				
				if(id != null) {
					request.setAttribute("mensaje", "El vendedor ha sido guardado");
				}
				
			} else {
				request.setAttribute("error", "El nombre de usuario ya existe");
			}
			request.getRequestDispatcher("/home.jsp").forward(request, response);
		} else if(SISINVConstants.TASK_BUSCAR.equalsIgnoreCase(task)) {
			String texto = request.getParameter("txtBuscar");
			List<Vendedor> vends = model.findVendedoresByParameters(texto);
			request.setAttribute("vends", vends);
			request.getRequestDispatcher("/buscar-vend.jsp").forward(request, response);
		}
	}

}
