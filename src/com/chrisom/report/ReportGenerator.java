package com.chrisom.report;

import java.awt.Desktop;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import com.chrisom.sisinv.entity.ItemPedido;
import com.chrisom.sisinv.entity.NotaRemision;
import com.chrisom.sisinv.model.PedidoModel;
import com.chrisom.sisinv.utils.PedidoUtils;
import com.chrisom.sisinv.utils.ProductoUtils;

import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;
import net.sf.jasperreports.view.JasperViewer;

public class ReportGenerator {
	 public String callingPedido(NotaRemision nr) {
		 StringBuffer nameFile = new StringBuffer("pedido");
	     try {
	    	 Map<String, Object> parameters = new HashMap<String, Object> ();
	    	 SimpleDateFormat dt = new SimpleDateFormat("dd/MMM/yy hh:mm:ss"); 
	    	 SimpleDateFormat dtNameFile = new SimpleDateFormat("ddMMyymmss"); 
	    	 PedidoModel pm = new PedidoModel();
	    	 List<ItemPedido> items = pm.findItemsByPedido(nr.getId());
	    	 JRBeanCollectionDataSource ds = new JRBeanCollectionDataSource(items, true);
	    	 Double sum = ProductoUtils.round(items.stream().mapToDouble(item -> item.getImporte()).sum(), 2);
	    	 PedidoUtils numero = new PedidoUtils((int)sum.doubleValue());
	 		 
	    	 StringBuffer sbLeyenda = new StringBuffer("Por este pagare debo(emos) y pagare(mos) incondicionalmente a la orden de ");
	    	 sbLeyenda.append("ABARROTERA HERMANOS CERVANTES en fecha ");
	    	 sbLeyenda.append(dt.format(new Date()));
	    	 sbLeyenda.append(" la cantidad de $");
	    	 sbLeyenda.append(sum);
	    	 sbLeyenda.append(" (" + numero.convertirLetras((int)sum.doubleValue()) + " pesos) ");
	    	 sbLeyenda.append(" en esta plaza o en cualquier otra en que se me(nos) requiera el pago producto recibido a mi(nuestra) ");
	    	 sbLeyenda.append("entera satisfaccion, en caso demora causara un interes al tipo 3% mensual durante el tiempo que permanezca ");
	    	 sbLeyenda.append("total o parcialmente insoluto y que debera pagarse junto con el adedudo principal, sin que por esto se considere ");
	    	 sbLeyenda.append("prorrogado el plazo.");
	    	 
	    	 nameFile.append(dtNameFile.format(new Date()));
	    	 nameFile.append(".pdf");
	    	 
	    	 
	    	 parameters.put("DataFile", "CustomDataSource.java");
	    	 parameters.put("TOTAL", sum);
	    	 parameters.put("NUM_ARTICULOS", items.size());
	    	 parameters.put("FECHA_ACTUAL", dt.format(new Date()));
	    	 parameters.put("LEYENDA", sbLeyenda.toString());
	    	 
	    	 InputStream input = getClass().getResourceAsStream("printed_pedido.jrxml");
	    	 JasperDesign jasperDesign = JRXmlLoader.load(input);
			 JasperReport report = JasperCompileManager.compileReport(jasperDesign);
			 JasperPrint print = JasperFillManager.fillReport(report, parameters, ds);
			 JasperExportManager.exportReportToPdfFile(print, nameFile.toString());
		     
			 
	     } catch (JRException ex) {
	         ex.printStackTrace();
	     }  
	     
	     return nameFile.toString();
	 }
}
