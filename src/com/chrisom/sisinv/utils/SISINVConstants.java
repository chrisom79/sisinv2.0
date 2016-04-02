package com.chrisom.sisinv.utils;

public interface SISINVConstants {
	public class TASKS {
		public final static String TASK_BUSCAR = "buscar";
		public final static String TASK_CREAR = "crear";
		public final static String TASK_QSEARCH = "qSearch";
		public final static String TASK_INIT = "init";
		public final static String SPECIFIC_SEARCH = "specific";
		public final static String TASK_IMPRIMIR = "imprimir";
		
		public final static String TASK_EDITAR = "editar";
		public final static String TASK_BORRAR = "borrar";
		public final static String TASK_IMPORTAR = "importar";
		public final static String TASK_EXPORTAR = "exportar";
	}
	
	public class PROD_TASKS {
		public final static String GET_PROD = "get";
	}
	
	public class VEND_TASKS {
		public final static String GET_VEND = "get";
	}
	
	public class PEDIDO_TASKS {
		public final static String LOAD_PEDIDO = "cargar";
		public final static String LOAD_PRODS = "cargar_prods";
		public final static String PRINT_PEDIDO = "imprimirPedido";
	}
	
	public class REPORT_TYPES {
		public final static String COMISIONES = "comisiones";
		public final static String PAGAR_COMISION = "pagar";
	}
}
