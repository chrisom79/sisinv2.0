package com.chrisom.report;

import java.awt.Desktop;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.chrisom.sisinv.entity.ItemPedido;
import com.chrisom.sisinv.entity.NotaRemision;
import com.chrisom.sisinv.model.PedidoModel;

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
	 public void callingPedido(NotaRemision nr) {
	     try {
	    	 Map<String, Object> parameters = new HashMap<String, Object> ();
	    	 SimpleDateFormat dt = new SimpleDateFormat("dd/MMM/yyyy"); 
	    	 PedidoModel pm = new PedidoModel();
	    	 List<ItemPedido> items = pm.findItemsByPedido(nr.getId());
	    	 JRBeanCollectionDataSource ds = new JRBeanCollectionDataSource(items, true);
	    
	    	/* parameters.put("FECHA", dt.format(new Date()));
	    	 parameters.put("CLIENTE_NOMBRE", nr.getNombre());
	    	 parameters.put("NUMERO", nr.getId());
	    	 parameters.put("VENDEDOR_NOMBRE", nr.getVendedor().getNombre());*/
	    	 parameters.put("DataFile", "CustomDataSource.java");
	    	 
	    	 InputStream input = getClass().getResourceAsStream("printed_pedido.jrxml");
	    	 JasperDesign jasperDesign = JRXmlLoader.load(input);
			 JasperReport report = JasperCompileManager.compileReport(jasperDesign);
			 JasperPrint print = JasperFillManager.fillReport(report, parameters, ds);
			 JasperExportManager.exportReportToPdfFile(print, "pedido.pdf");
		     
			 if (Desktop.isDesktopSupported()) {
		        File myFile = new File("pedido.pdf");
		        Desktop.getDesktop().open(myFile);
			}
	     } catch (JRException ex) {
	         ex.printStackTrace();
	     }  catch (IOException ex) {
		     ex.printStackTrace();
		 }
	 }
}
