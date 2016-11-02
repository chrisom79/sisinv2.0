package com.chrisom.sisinv.utils;

public interface SISINVConstants {
	public class TASKS {
		public final static String TASK_BUSCAR = "buscar";
		public final static String TASK_CREAR = "crear";
		public final static String TASK_QSEARCH = "qSearch";
		public final static String TASK_INIT = "init";
		public final static String SPECIFIC_SEARCH = "specific";
		public final static String TASK_IMPRIMIR = "imprimir";
		public final static String TASK_IMPRIMIR_FROMSEARCH = "imprimirSearch";
		
		public final static String TASK_EDITAR = "editar";
		public final static String TASK_BORRAR = "borrar";
		public final static String TASK_IMPORTAR = "importar";
		public final static String TASK_EXPORTAR = "exportar";
		public final static String TASK_CERRAR = "cerrar";
		public final static String GET_ITEM = "get";
	}
	
	public class PEDIDO_TASKS {
		public final static String LOAD_PEDIDO = "cargar";
		public final static String LOAD_PRODS = "cargar_prods";
		public final static String PRINT_PEDIDO = "imprimir_pedido";
		public final static String MOSTRAR_PEDIDO = "mostrar_pedido";
		public final static String BORRAR_PRODUCTO = "borrar_producto";
		public final static String CAMBIAR_PRODUCTO = "cambiar_producto";
	}
	
	public class REPORT_TYPES {
		public final static String COMISIONES = "comisiones";
		public final static String PAGAR_COMISION = "pagar";
	}
	
	public class RUTA_TASKS {
		public final static String CREAR = "crear";
		public final static String ENVIAR = "enviar";
	}
	
	public class SETTINGS_TASKS {
		public static final String CAMBIAR_PASSWORD = "cambiar_passwd";
	}
	
	public class PROFILE_TASKS {
		public static final String LOGOUT = "logout";
	}
}
