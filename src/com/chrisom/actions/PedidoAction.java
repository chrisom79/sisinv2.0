package com.chrisom.actions;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chrisom.report.ReportGenerator;
import com.chrisom.sisinv.entity.NotaRemision;
import com.chrisom.sisinv.entity.NotaRemisionDetalle;
import com.chrisom.sisinv.entity.Vendedor;
import com.chrisom.sisinv.model.PedidoModel;
import com.chrisom.sisinv.model.ProductoModel;
import com.chrisom.sisinv.utils.SISINVConstants;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

/**
 * Servlet implementation class PedidoAction
 */
@WebServlet("/PedidoAction")
public class PedidoAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PedidoAction() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String task = request.getParameter("task");
		PedidoModel model = new PedidoModel();
		
		if(SISINVConstants.SPECIFIC_SEARCH.equalsIgnoreCase(task)) {
			Gson gson = new GsonBuilder().excludeFieldsWithoutExposeAnnotation().create();
			response.setContentType("application/json");
			List<NotaRemision> pedidos = model.findLastPedidos(5);
			String searchList = gson.toJson(pedidos);
			response.getWriter().write(searchList);
		} else if(SISINVConstants.TASK_IMPRIMIR.equalsIgnoreCase(task)) {
			String id = request.getParameter("id");
			ReportGenerator rg = new ReportGenerator();
			
			NotaRemision nr = model.findPedidoById(Integer.valueOf(id));
			rg.callingPedido(nr);
			response.setContentType("text/text");
			response.getWriter().write("success");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String task = request.getParameter("task");
		PedidoModel model = new PedidoModel();
		
		if(SISINVConstants.TASK_CREAR.equalsIgnoreCase(task)) {
			try {
				NotaRemision nr = createObject(request);
				
				String id = model.insertPedido(nr);
				if(id != null) {
					request.setAttribute("mensaje", "El pedido ha sido guardado");
				} else {
					request.setAttribute("error", "Ocurrió un error al guardar el pedido");
				}
				request.getRequestDispatcher("/home.jsp").forward(request, response);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		} else if(SISINVConstants.TASK_IMPRIMIR.equalsIgnoreCase(task)) {
			ReportGenerator rg = new ReportGenerator();
			NotaRemision nr = null;
			try {
				nr = createObject(request);
				rg.callingPedido(nr);
			} catch (ParseException e) {
				e.printStackTrace();
			}
			
			request.getRequestDispatcher("/crear-pedido.jsp").forward(request, response);
		} else if(SISINVConstants.TASK_BUSCAR.equalsIgnoreCase(task)) {
			String nombre = request.getParameter("txtBuscar");
			String fechaInicio = request.getParameter("fechaInicio");
			String fechaFinal = request.getParameter("fechaFinal");
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
			String fi = null;
			String ff = null;
			
			try {
				if(fechaInicio != null && !fechaInicio.isEmpty()) {
					Date d = sdf.parse(fechaInicio);
					sdf.applyPattern("yyyy/MM/dd");
					fi = sdf.format(d);
				}
				
				if(fechaFinal != null && !fechaFinal.isEmpty()) {
					sdf.applyPattern("dd/MM/yyyy");
					Date d = sdf.parse(fechaFinal);
					sdf.applyPattern("yyyy/MM/dd");
					ff = sdf.format(d);
				}
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			List<NotaRemision> pedidos = model.findPedidosByParameters(nombre, fi, ff);
			//request.setCharacterEncoding("UTF-8");
			request.setAttribute("pedidos", pedidos);
			request.setAttribute("nombre", nombre);
			request.setAttribute("fechaInicio", fechaInicio);
			request.setAttribute("fechaFinal", fechaFinal);
			request.getRequestDispatcher("/buscar-pedido.jsp").forward(request, response);
		}
	}
	
	private NotaRemision createObject(HttpServletRequest request) throws ParseException {
		String pedidoNo = request.getParameter("txtPedidoNo");
		String fecha = request.getParameter("txtFecha");
		String nombre = request.getParameter("txtNombre");
		String ciudad = request.getParameter("txtCiudad");
		String direccion = request.getParameter("txtDireccion");
		String prods = request.getParameter("prods");
		String idVend = request.getParameter("idVend");
		String nombreVend = request.getParameter("nombreVend");
		String total = request.getParameter("total");
		Date convDate = null;
		Double convTotal = null;
		Integer convId = null;
		NotaRemision nr = null;
		
		if(pedidoNo != null && !pedidoNo.isEmpty()) {
			convId = Integer.valueOf(pedidoNo);
		}
		
		if(fecha != null && !fecha.isEmpty()) {
			DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
			convDate = df.parse(fecha);
			
		}
		
		if(total != null && !total.isEmpty()) {
			convTotal = Double.valueOf(total);
		}
		
		Vendedor vend = new Vendedor();
		vend.setId(idVend);
		vend.setNombre(nombreVend);
		nr = new NotaRemision(convId, vend, convDate, convTotal);
		nr.setCiudad(ciudad);
		nr.setDireccion(direccion);
		nr.setNombre(nombre);
		
		for(String prod : prods.split(";")) {
			String[] elements = prod.split(",");
			Integer convCantidad = null;
			Double convPrecio = null;
			
			if(elements[0] != null && !elements[0].isEmpty()) {
				convCantidad = Integer.valueOf(elements[0]);
			}
			
			if(elements[1] != null && !elements[1].isEmpty()) {
				convPrecio = Double.valueOf(elements[1]);
			}
			
			NotaRemisionDetalle nrd = new NotaRemisionDetalle(convCantidad, convPrecio, elements[2]);
			nrd.setNotaRemision(nr);
			nr.getNotaRemisionDetalles().add(nrd);
		}
		
		return nr;
	}

}
