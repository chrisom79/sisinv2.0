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
	    	 SimpleDateFormat dt = new SimpleDateFormat("dd/MMM/yy hh:mm:ss"); 
	    	 SimpleDateFormat dtNameFile = new SimpleDateFormat("ddMMyymm"); 
	    	 PedidoModel pm = new PedidoModel();
	    	 List<ItemPedido> items = pm.findItemsByPedido(nr.getId());
	    	 JRBeanCollectionDataSource ds = new JRBeanCollectionDataSource(items, true);
	    	 
	    	 StringBuffer nameFile = new StringBuffer("pedido_");
	    	 nameFile.append(dtNameFile.format(nr.getFecha()));
	    	 nameFile.append(".pdf");
	    	 
	    	 Double sum = items.stream().mapToDouble(item -> item.getImporte()).sum();
	    	 parameters.put("DataFile", "CustomDataSource.java");
	    	 parameters.put("TOTAL", sum);
	    	 parameters.put("NUM_ARTICULOS", items.size());
	    	 parameters.put("FECHA_ACTUAL", dt.format(new Date()));
	    	 
	    	 InputStream input = getClass().getResourceAsStream("printed_pedido.jrxml");
	    	 JasperDesign jasperDesign = JRXmlLoader.load(input);
			 JasperReport report = JasperCompileManager.compileReport(jasperDesign);
			 JasperPrint print = JasperFillManager.fillReport(report, parameters, ds);
			 JasperExportManager.exportReportToPdfFile(print, nameFile.toString());
		     
			 if (Desktop.isDesktopSupported()) {
		        File myFile = new File(nameFile.toString());
		        Desktop.getDesktop().open(myFile);
			}
	     } catch (JRException ex) {
	         ex.printStackTrace();
	     }  catch (IOException ex) {
		     ex.printStackTrace();
		 }
	 }
}
