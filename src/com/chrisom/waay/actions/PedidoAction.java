package com.chrisom.actions;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chrisom.report.ReportGenerator;
import com.chrisom.sisinv.entity.ItemPedido;
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
		
		if(SISINVConstants.TASKS.SPECIFIC_SEARCH.equalsIgnoreCase(task)) {
			Gson gson = new GsonBuilder().excludeFieldsWithoutExposeAnnotation().create();
			response.setContentType("application/json");
			List<NotaRemision> pedidos = model.findLastPedidos(5);
			String searchList = gson.toJson(pedidos);
			response.getWriter().write(searchList);
		} else if(SISINVConstants.PEDIDO_TASKS.BORRAR_PRODUCTO.equalsIgnoreCase(task)) {
			String idPedido = request.getParameter("idPedido");
			String idProducto = request.getParameter("idProducto");
			Boolean success = model.removeProducto(Integer.valueOf(idPedido), idProducto);
			
			if(!success)
				idProducto = "";
			response.getWriter().write(idProducto);
		} else if(SISINVConstants.PEDIDO_TASKS.CAMBIAR_PRODUCTO.equalsIgnoreCase(task)) {
			String idPedido = request.getParameter("idPedido");
			String idProducto = request.getParameter("idProducto");
			String cantidad = request.getParameter("cantidad");
			
			model.updateCantidad(Integer.valueOf(idPedido), idProducto, Integer.valueOf(cantidad));
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String task = request.getParameter("task");
		PedidoModel model = new PedidoModel();
		
		String nombre = request.getParameter("txtBuscar");	
		String fechaInicio = request.getParameter("fechaInicio");
		String fechaFinal = request.getParameter("fechaFinal");
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		String fi = null;
		String ff = null;
		
		
		
		if(SISINVConstants.TASKS.TASK_CREAR.equalsIgnoreCase(task)) {
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
		} else if(SISINVConstants.TASKS.TASK_IMPRIMIR.equalsIgnoreCase(task)) {
			ReportGenerator rg = new ReportGenerator();
			NotaRemision nr = null;
			try {
				nr = createObject(request);
				String id = model.insertPedido(nr);
				String nameFile = rg.callingPedido(nr);
				
				response.setContentType("application/pdf");
		        response.setHeader("Content-Disposition", "attachment; filename="+nameFile);
				InputStream is = new FileInputStream(nameFile);
				
				int read=0;
				byte[] bytes = new byte[2048];
				OutputStream os = response.getOutputStream();
		        
		        while((read = is.read(bytes))!= -1){
					os.write(bytes, 0, read);
				}
				is.close();
				os.flush();
				os.close();		
			} catch (ParseException e) {
				e.printStackTrace();
			}
		} else if(SISINVConstants.TASKS.TASK_BUSCAR.equalsIgnoreCase(task)) {
			
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
				e.printStackTrace();
			}
			
			List<NotaRemision> pedidos = model.findPedidosByParameters(nombre, fi, ff, null);
			//request.setCharacterEncoding("UTF-8");
			request.setAttribute("pedidos", pedidos);
			request.setAttribute("nombre", nombre);
			request.setAttribute("fechaInicio", fechaInicio);
			request.setAttribute("fechaFinal", fechaFinal);
			request.getRequestDispatcher("/buscar-pedido.jsp").forward(request, response);
		} else if(SISINVConstants.PEDIDO_TASKS.LOAD_PEDIDO.equalsIgnoreCase(task)) {
			String id = request.getParameter("pedidoId");
			searchPedidosById(id, task, model, request, response);
		}  else if(SISINVConstants.PEDIDO_TASKS.MOSTRAR_PEDIDO.equalsIgnoreCase(task)) {
			String id = request.getParameter("pedidoId");
			searchPedidosById(id, task, model, request, response);
		}  else if(SISINVConstants.PEDIDO_TASKS.LOAD_PRODS.equalsIgnoreCase(task)) {
			loadProdsToPedido(request);
			
			request.getRequestDispatcher("/buscar-pedido.jsp").forward(request, response);
		} else if(SISINVConstants.PEDIDO_TASKS.PRINT_PEDIDO.equalsIgnoreCase(task)) {
			String id = request.getParameter("idPedido");
			ReportGenerator rg = new ReportGenerator();
			NotaRemision nr = model.findPedidoById(Integer.valueOf(id));
			
			String nameFile = rg.callingPedido(nr);
			
			response.setContentType("application/pdf");
	        response.setHeader("Content-Disposition", "attachment; filename="+nameFile);
			InputStream fis = new FileInputStream(nameFile);
			ServletOutputStream os       = response.getOutputStream();
			byte[] bufferData = new byte[1024];
	        int read=0;
	        while((read = fis.read(bufferData))!= -1){
	            os.write(bufferData, 0, read);
	        }
	        os.flush();
	        os.close();
	        fis.close();
			loadProdsToPedido(request);
			
			request.getRequestDispatcher("/buscar-pedido.jsp").forward(request, response);
		} else if(SISINVConstants.TASKS.TASK_IMPRIMIR_FROMSEARCH.equalsIgnoreCase(task)) {
			String id = request.getParameter("pedidoId");
			ReportGenerator rg = new ReportGenerator();
			
			NotaRemision nr = model.findPedidoById(Integer.valueOf(id));
			String nameFile = rg.callingPedido(nr);
			
			response.setContentType("application/pdf");
	        response.setHeader("Content-Disposition", "attachment; filename="+nameFile);
			InputStream fis = new FileInputStream(nameFile);
			ServletOutputStream os       = response.getOutputStream();
			byte[] bufferData = new byte[1024];
	        int read=0;
	        while((read = fis.read(bufferData))!= -1){
	            os.write(bufferData, 0, read);
	        }
	        os.flush();
	        os.close();
	        fis.close();
			
		} if(SISINVConstants.TASKS.TASK_CERRAR.equalsIgnoreCase(task)) {
			request.getRequestDispatcher("/home.jsp").forward(request, response);
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
			Double convPrecioFinal = null;
			Double importe = null;
			
			if(elements[0] != null && !elements[0].isEmpty()) {
				convCantidad = Integer.valueOf(elements[0]);
			}
			
			if(elements[1] != null && !elements[1].isEmpty()) {
				convPrecio = Double.valueOf(elements[1]);
			}
			
			if(elements[2] != null && !elements[2].isEmpty()) {
				convPrecioFinal = Double.valueOf(elements[2]);
			}
			
			if(elements[3] != null && !elements[3].isEmpty()) {
				importe = Double.valueOf(elements[3]);
			}
			
			NotaRemisionDetalle nrd = new NotaRemisionDetalle(convCantidad, convPrecio, elements[4]);
			nrd.setPrecioFinal(convPrecioFinal);
			nrd.setImporte(importe);
			nrd.setCargado(Boolean.FALSE);
			nrd.setNotaRemision(nr);
			nr.getNotaRemisionDetalles().add(nrd);
		}
		
		return nr;
	}
	
	private void loadProdsToPedido(HttpServletRequest request) {
		PedidoModel model = new PedidoModel();
		String id = request.getParameter("idPedido");
		String prods = request.getParameter("prods");
		
		NotaRemision nr = new NotaRemision();
		nr.setId(Integer.valueOf(id));
		
		List<String> prodToLoad = Arrays.asList(prods.split(","));
		
		model.loadProductosToPedido(prodToLoad, nr);
	}
	
	private void searchPedidosById(String id, String task, PedidoModel model, HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		String fecha = null;
		sdf = new SimpleDateFormat("dd/MM/yyyy");
		
		NotaRemision pedido = model.findPedidoById(Integer.valueOf(id));
		List<ItemPedido> items = model.findItemsByPedido(Integer.valueOf(id));
		if(pedido.getFecha() != null) {
			fecha = sdf.format(pedido.getFecha());
		}
		
		request.setAttribute("fecha", fecha);
		request.setAttribute("pedido", pedido);
		request.setAttribute("items", items);
		request.setAttribute("task", task);
		
		request.getRequestDispatcher("/cargar-pedido.jsp").forward(request, response);
	}

}
