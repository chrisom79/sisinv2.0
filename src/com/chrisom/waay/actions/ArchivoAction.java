package com.chrisom.waay.actions;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.chrisom.sisinv.entity.Producto;
import com.chrisom.sisinv.model.ProductoModel;
import com.chrisom.sisinv.utils.POIUtils;
import com.chrisom.sisinv.utils.ProductoUtils;
import com.chrisom.sisinv.utils.SISINVConstants;


/**
 * Servlet implementation class ArchivoAction
 */
@WebServlet("/ArchivoAction")
@MultipartConfig
public class ArchivoAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
	/**
     * @see HttpServlet#HttpServlet()
     */
    public ArchivoAction() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String task = request.getParameter("task");
        
		if(SISINVConstants.TASKS.TASK_IMPORTAR.equalsIgnoreCase(task)) {
			Part filePart = request.getPart("file");
	        List<Producto> prods = readXLSFile(filePart);
	        if(insertProds(prods)) {
	        	request.setAttribute("mensaje", "El archivo fue importado satisfactoriamente");
	        } else {
	        	request.setAttribute("error", "El archivo no fue importado");
	        }
	        
	        request.getRequestDispatcher("/home.jsp").forward(request, response);
		} else if(SISINVConstants.TASKS.TASK_EXPORTAR.equalsIgnoreCase(task)) {
			String nombre = request.getParameter("txtNombre");
			response.setContentType("application/vnd.ms-excel");
	        response.setHeader("Content-Disposition", "attachment; filename="+nombre+".xlsx");
			String out = writeXLSFile(nombre);
			InputStream is = new FileInputStream(out);
				
			int read=0;
			byte[] bytes = new byte[2048];
			OutputStream os = response.getOutputStream();
				
			while((read = is.read(bytes))!= -1){
				os.write(bytes, 0, read);
			}
			is.close();
			os.flush();
			os.close();		
		}
	}
	
	@SuppressWarnings("resource")
	private List<Producto> readXLSFile(Part filePart) throws IOException {
		List<Producto> prods = new ArrayList<Producto>();
		/*Integer id = prodModel.getMaxIdToInsert();
		id = (id != null? id + 1 : 0);*/
		InputStream file = filePart.getInputStream();
		
		XSSFWorkbook workbook = new XSSFWorkbook(file);
		XSSFSheet sheet = workbook.getSheetAt(0);
		Iterator<Row> rowIterator = sheet.iterator();
		rowIterator.next(); //Evitando el header
	    while(rowIterator.hasNext()) {
	        Row row = rowIterator.next();
	        Producto prod = new Producto();
	        //For each row, iterate through each columns
	        Iterator<Cell> cellIterator = row.cellIterator();
	        
	        Double id = (Double) getValueFromCell(cellIterator.next());
	        if(id != null) {
		        String nombre = (String) getValueFromCell(cellIterator.next());
		        Double piezas = (Double) getValueFromCell(cellIterator.next());
		        Double precio = (Double) getValueFromCell(cellIterator.next());
		        Boolean iva = ((String) getValueFromCell(cellIterator.next())).equalsIgnoreCase("Si") ? Boolean.TRUE : Boolean.FALSE;
		        Integer ganancia = (int) (((Double)getValueFromCell(cellIterator.next())) * 100);
		        
		        System.out.println("id: " + id);
		        System.out.println("nombre: " + nombre);
		        System.out.println("piezas: " + piezas);
		        System.out.println("precio: " + precio);
		        System.out.println("ganancia: " + ganancia);
		        System.out.println("iva: " + iva);
		        
		        prod.setId(String.valueOf((int)id.doubleValue()));
		        prod.setNombre(nombre);
		        prod.setPiezas(piezas.intValue());
		        prod.setPrecioCompra(ProductoUtils.round(precio, 2));
		        prod.setPorcentaje(ganancia);
		        prod.setIva(iva);
		        prod.setComision(0);
		        prods.add(prod);
	        }
	    }
	    file.close();
	    return prods;
	}
	
	private String writeXLSFile(String nombre) {
		File f = null;
		nombre = nombre + "_temp.xlsx";
		XSSFWorkbook workbook = new XSSFWorkbook();
		Map<String, CellStyle> styles = POIUtils.getInstance().createStyles(workbook);
		XSSFSheet sheet = workbook.createSheet("Productos");
		ProductoModel model = new ProductoModel();
		Integer index = 0;
		List<Producto> prods = model.findProductoByParameters(null);
		Map<Integer, Object[]> data = new HashMap<Integer, Object[]>();
		data.put(++index, new Object[] {"Codigo", "Nombre", "Piezas", "Precio compra", "IVA", "Ganancia", "Precio venta"});
		sheet.setColumnWidth(0, 20*256);
		sheet.setColumnWidth(1, 55*256);
		sheet.setColumnWidth(2, 6*256);
		sheet.setColumnWidth(3, 10*256);
		sheet.setColumnWidth(4, 4*256);
		sheet.setColumnWidth(5, 8*256);
		sheet.setColumnWidth(6, 10*256);
		
		
		for(Producto prod : prods) {
			data.put(++index, new Object[]{prod.getId(), prod.getNombre(), prod.getPiezas(), prod.getPrecioCompra(), prod.getIva()?"Si":"No", prod.getPorcentaje() + "%",
					prod.getPrecioCompra() + (prod.getPrecioCompra() * (Double.valueOf(prod.getPorcentaje())/100))});
		}
		 
		Set<Integer> keyset = data.keySet();
		int rownum = 0;
		for (Integer key : keyset) {
		    Row row = sheet.createRow(rownum++);
		    Object [] objArr = data.get(key);
		    int cellnum = 0;
		    for (Object obj : objArr) {
		        Cell cell = row.createCell(cellnum++);
		        if(rownum == 1) {
		        	cell.setCellStyle(styles.get(POIUtils.HEADER));
		        } else {
		        	if(cellnum == 1 || cellnum == 2 || cellnum == 5) {
		        		cell.setCellStyle(styles.get(POIUtils.CELL));
		        	} else if(cellnum == 3 || cellnum == 4) {
		        		cell.setCellStyle(styles.get(POIUtils.MONEY));
		        	} 
		        }
		        
		        if(obj instanceof Date) 
		            cell.setCellValue((Date)obj);
		        else if(obj instanceof Boolean)
		            cell.setCellValue((Boolean)obj);
		        else if(obj instanceof String)
		            cell.setCellValue((String)obj);
		        else if(obj instanceof Double)
		            cell.setCellValue((Double)obj);
		        else if(obj instanceof Integer)
		            cell.setCellValue((Integer)obj);
		    }
		}
		 
		try {
			f = new File(nombre); 
			FileOutputStream out = new FileOutputStream(f);
		    workbook.write(out);
		    System.out.println(f.getAbsolutePath());
		    out.close();
		} catch (FileNotFoundException e) {
		    e.printStackTrace();
		} catch (IOException e) {
		    e.printStackTrace();
		}
		
		return f.getAbsolutePath();
	}
	
	private Object getValueFromCell(Cell cell) {
		Object obj = null;
		switch(cell.getCellType()) {
	        case Cell.CELL_TYPE_BOOLEAN:
	            obj = cell.getBooleanCellValue();
	            break;
	        case Cell.CELL_TYPE_NUMERIC:
	            obj = cell.getNumericCellValue();
	            break;
	        case Cell.CELL_TYPE_STRING:
	            obj = cell.getStringCellValue();
	            break;
	    }
		
		return obj;
	}
	
	private Boolean insertProds(List<Producto> prods) {
		try {
			ProductoModel prodModel = new ProductoModel();
			for(Producto prod : prods) {
				if(prodModel.findProductoByCode(prod.getId()) == null)
					prodModel.insertProducto(prod);
				else
					prodModel.updateProducto(prod);
			}
		} catch(Exception e) {
			return Boolean.FALSE;
		}
		
		return Boolean.TRUE;
	}
}
