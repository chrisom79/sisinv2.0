package com.chrisom.sisinv.utils;

import java.util.ArrayList;
import java.util.List;

import com.chrisom.sisinv.entity.Producto;

public class ProductoUtils {
	public static Double calculatePrecioVenta(Double precioCompra, Integer ganancia){
		Double total = precioCompra + (precioCompra * (ganancia.doubleValue() / 100.0));
		
		return total;
	}
	
	public static Double sumaImportes(){
		/*Double total = new Double(0);
		//table.getItemIds();
		for(Object id : table.getItemIds()) {
			//total += (Double) table.getItem(id).getItemProperty(UIConstants.PEDIDO_IMPORTE).getValue();
		}*/
		
		return null; //round(total, 2);
	}
	
	public static double round(double value, int places) {
	    if (places < 0) throw new IllegalArgumentException();

	    long factor = (long) Math.pow(10, places);
	    value = value * factor;
	    long tmp = Math.round(value);
	    return (double) tmp / factor;
	}
	
	public static ArrayList<String> converToString(List<Producto> prods){
		ArrayList<String> list = new ArrayList<String>();
		for(Producto prod : prods){
			list.add(prod.getNombre());
		}
		
		return list;
	}
}
