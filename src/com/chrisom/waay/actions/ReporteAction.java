package com.chrisom.actions;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chrisom.sisinv.entity.ItemPedido;
import com.chrisom.sisinv.entity.NotaRemision;
import com.chrisom.sisinv.entity.NotaRemisionDetalle;
import com.chrisom.sisinv.entity.Producto;
import com.chrisom.sisinv.entity.Vendedor;
import com.chrisom.sisinv.model.PedidoModel;
import com.chrisom.sisinv.model.ProductoModel;
import com.chrisom.sisinv.model.VendedorModel;
import com.chrisom.sisinv.utils.ProductoUtils;
import com.chrisom.sisinv.utils.SISINVConstants;

/**
 * Servlet implementation class ReporteAction
 */
@WebServlet("/ReporteAction")
public class ReporteAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReporteAction() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String task = request.getParameter("task");
		String tipo = request.getParameter("tipo");
		SimpleDateFormat sdf = new SimpleDateFormat();
		String fi = null;
		String ff = null;
		
		if(SISINVConstants.TASKS.TASK_BUSCAR.equalsIgnoreCase(task)) {
			
			if(SISINVConstants.REPORT_TYPES.COMISIONES.equalsIgnoreCase(tipo)) {
				String idVend = request.getParameter("idVendedor");
				String fechaInicio = request.getParameter("fechaInicio");
				String fechaFinal = request.getParameter("fechaFinal");
				String nombre = request.getParameter("searchVend");
				PedidoModel model = new PedidoModel();
				VendedorModel vModel = new VendedorModel();
				try {
					if(fechaInicio != null && !fechaInicio.isEmpty()) {
						sdf.applyPattern("dd/MM/yyyy");
						Date d;
						d = sdf.parse(fechaInicio);
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
				List<NotaRemision> pedidos = model.findPedidosByVendedor(idVend, fi, ff);
				Vendedor vendedor = vModel.findVendedorById(idVend);
				List<ItemPedido> items = convertToItems(pedidos);
				if(items != null && !items.isEmpty()) {
					Double sum = (items.stream().mapToDouble(item -> (item.getPagoComision() == null && item.getComision() != null?item.getImporte() * ((double)item.getComision() / 100) :0.0)).sum()) ;
					request.setAttribute("comision", ProductoUtils.round(sum, 2));
				}
				request.setAttribute("items", items);
				request.setAttribute("idVendedor", idVend);
				request.setAttribute("fechaInicio", fechaInicio);
				request.setAttribute("fechaFinal", fechaFinal);
				request.setAttribute("searchVend", nombre);
				request.getRequestDispatcher("/comisiones.jsp").forward(request, response);
			} 
		} else if(SISINVConstants.REPORT_TYPES.PAGAR_COMISION.equalsIgnoreCase(task)) {
			String comisiones = request.getParameter("comision-pedido");
			PedidoModel model = new PedidoModel();
			try {
				for(String id : comisiones.split(",")){
					model.registerComision(id);
				}
				request.setAttribute("mensaje", "Se ha registrado la comision");
				
			} catch(Exception ex) {
				request.setAttribute("error", "Ocurrió un error al registrar la comision");
			}
			request.getRequestDispatcher("/home.jsp").forward(request, response);
			
		}
	}
	
	private List<ItemPedido> convertToItems(List<NotaRemision> pedidos) {
		ProductoModel model = new ProductoModel();
		List<ItemPedido> items = new ArrayList<ItemPedido>();
		for(NotaRemision pedido : pedidos) {
			for(NotaRemisionDetalle nrd : pedido.getNotaRemisionDetalles()) {
				Producto prod = model.findProductoByCode(nrd.getProductoId());
				ItemPedido item = new ItemPedido(nrd.getCantidad(), nrd.getProductoId(), prod.getNombre(),
						nrd.getPrecio(), nrd.getPrecio() * nrd.getCantidad(), pedido.getId(), prod.getComision());
				item.setPagoComision(nrd.getFechaPagoComision());
				items.add(item);
			}
			
		}
		return items;
	}

}
