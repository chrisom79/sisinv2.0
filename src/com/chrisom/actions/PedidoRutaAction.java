package com.chrisom.actions;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.TimeZone;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chrisom.sisinv.entity.NotaRemision;
import com.chrisom.sisinv.entity.PedidoRuta;
import com.chrisom.sisinv.model.PedidoModel;
import com.chrisom.sisinv.model.PedidoRutaModel;
import com.chrisom.sisinv.utils.SISINVConstants;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

@WebServlet("/PedidoRutaAction")
public class PedidoRutaAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
	/**
     * @see HttpServlet#HttpServlet()
     */
    public PedidoRutaAction() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String task = request.getParameter("task");
		PedidoModel pedidoModel = new PedidoModel();
		PedidoRutaModel rutaModel = new PedidoRutaModel();
		String fi = null;
		String ff = null;
		
		if(SISINVConstants.TASKS.TASK_INIT.equalsIgnoreCase(task)) {
			Calendar cal = new GregorianCalendar();
			TimeZone timeZone = TimeZone.getTimeZone("America/Mexico_City");
			cal.setTimeZone(timeZone);
			Gson gson = new GsonBuilder().excludeFieldsWithoutExposeAnnotation().create();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
			fi = sdf.format(cal.getTime());
			ff  = sdf.format(cal.getTime());
			List<NotaRemision> pedidos = pedidoModel.findPedidosByParameters("", fi, ff, null);
			
			String searchList = gson.toJson(pedidos);
			response.getWriter().write(searchList);
		} else if(SISINVConstants.RUTA_TASKS.CREAR.equalsIgnoreCase(task)) {
			String nombre = request.getParameter("nombre");
			String[] pedidos = request.getParameter("pedidos").split(",");
			String id = rutaModel.insertPedidoRuta(new PedidoRuta(nombre));
			for(String pedido : pedidos) {
				pedidoModel.updateRuta(Integer.valueOf(pedido), Integer.valueOf(id));
			}
			
			response.getWriter().write(id);
		} else if(SISINVConstants.RUTA_TASKS.ENVIAR.equalsIgnoreCase(task)) {
			String idRuta = request.getParameter("idRuta");
			
			if(!pedidoModel.updateEnviado(Integer.valueOf(idRuta), Boolean.TRUE)) {
				idRuta = "";
			}
			
			response.getWriter().write(idRuta);
		
		}
	}
}
