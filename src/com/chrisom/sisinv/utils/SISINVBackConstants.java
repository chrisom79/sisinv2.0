package com.chrisom.sisinv.utils;

public interface SISINVBackConstants {
	public enum OFERTA_TIPO {
		DESC("desc", 1),
		COMPRA_LLEVA("compra-lleva", 2),
		COMPRA_POR("compra-por", 3);
		
		private final String nombre;
		private final int id;
		
		OFERTA_TIPO(String nombre, int id) {
			this.nombre = nombre;
			this.id = id;
		}

		public String getNombre() {
			return nombre;
		}

		public int getId() {
			return id;
		}
		
	}
}
