package com.chrisom.sisinv.utils;

import java.util.HashMap;
import java.util.Map;

import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Workbook;

public class POIUtils {
	private static POIUtils util;
	public static String TITLE = "title";
	public static String HEADER = "header";
	public static String CELL = "cell";
	public static String MONEY = "input_$";
	public static String PERCENT = "input_%";
	public static String INTEGER = "input_i";
	public static String DATE = "input_d";
	
	
	private POIUtils() {
		
	}
	public static POIUtils getInstance(){
		if(util == null){
			util = new POIUtils();
		}
		
		return util;
	}
	
	public Map<String, CellStyle> createStyles(Workbook wb){
        Map<String, CellStyle> styles = new HashMap<String, CellStyle>();
        CellStyle style;
        Font titleFont = wb.createFont();
        titleFont.setFontHeightInPoints((short)18);
        titleFont.setBoldweight(Font.BOLDWEIGHT_BOLD);
        style = wb.createCellStyle();
        style.setAlignment(CellStyle.ALIGN_CENTER);
        style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        style.setFont(titleFont);
        styles.put(TITLE, style);

        Font hFont = wb.createFont();
        hFont.setFontHeightInPoints((short)11);
        hFont.setColor(IndexedColors.WHITE.getIndex());
        hFont.setBold(true);
        style = wb.createCellStyle();
        style.setAlignment(CellStyle.ALIGN_CENTER);
        style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        style.setFillForegroundColor(IndexedColors.GREY_50_PERCENT.getIndex());
        style.setFillPattern(CellStyle.SOLID_FOREGROUND);
        style.setFont(hFont);
        style.setWrapText(true);
        styles.put(HEADER, style);
        
        Font cFont = wb.createFont();
        cFont.setFontHeightInPoints((short)11);
        cFont.setColor(IndexedColors.BLACK.getIndex());
       
        style = wb.createCellStyle();
        style.setAlignment(CellStyle.ALIGN_RIGHT);
        style.setFont(cFont);
        style.setWrapText(true);
        style.setBorderRight(CellStyle.BORDER_DOTTED);
        style.setRightBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderLeft(CellStyle.BORDER_DOTTED);
        style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderTop(CellStyle.BORDER_DOTTED);
        style.setTopBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderBottom(CellStyle.BORDER_DOTTED);
        style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
        styles.put(CELL, style);
        
        
        style = wb.createCellStyle();
        style.setAlignment(CellStyle.ALIGN_RIGHT);
        style.setFont(cFont);
        style.setBorderRight(CellStyle.BORDER_DOTTED);
        style.setRightBorderColor(IndexedColors.GREY_40_PERCENT.getIndex());
        style.setBorderBottom(CellStyle.BORDER_DOTTED);
        style.setBottomBorderColor(IndexedColors.GREY_40_PERCENT.getIndex());
        style.setBorderLeft(CellStyle.BORDER_DOTTED);
        style.setLeftBorderColor(IndexedColors.GREY_40_PERCENT.getIndex());
        style.setBorderTop(CellStyle.BORDER_DOTTED);
        style.setTopBorderColor(IndexedColors.GREY_40_PERCENT.getIndex());
        style.setDataFormat(wb.createDataFormat().getFormat("_($* #,##0.00_);_($* (#,##0.00);_($* \"-\"??_);_(@_)"));
        styles.put(MONEY, style);

        style = wb.createCellStyle();
        style.setAlignment(CellStyle.ALIGN_RIGHT);
        style.setFont(cFont);
        style.setBorderRight(CellStyle.BORDER_DOTTED);
        style.setRightBorderColor(IndexedColors.GREY_40_PERCENT.getIndex());
        style.setBorderBottom(CellStyle.BORDER_DOTTED);
        style.setBottomBorderColor(IndexedColors.GREY_40_PERCENT.getIndex());
        style.setBorderLeft(CellStyle.BORDER_DOTTED);
        style.setLeftBorderColor(IndexedColors.GREY_40_PERCENT.getIndex());
        style.setBorderTop(CellStyle.BORDER_DOTTED);
        style.setTopBorderColor(IndexedColors.GREY_40_PERCENT.getIndex());
        style.setDataFormat(wb.createDataFormat().getFormat("0.000%"));
        styles.put(PERCENT, style);

        style = wb.createCellStyle();
        style.setAlignment(CellStyle.ALIGN_RIGHT);
        style.setFont(cFont);
        style.setBorderRight(CellStyle.BORDER_DOTTED);
        style.setRightBorderColor(IndexedColors.GREY_40_PERCENT.getIndex());
        style.setBorderBottom(CellStyle.BORDER_DOTTED);
        style.setBottomBorderColor(IndexedColors.GREY_40_PERCENT.getIndex());
        style.setBorderLeft(CellStyle.BORDER_DOTTED);
        style.setLeftBorderColor(IndexedColors.GREY_40_PERCENT.getIndex());
        style.setBorderTop(CellStyle.BORDER_DOTTED);
        style.setTopBorderColor(IndexedColors.GREY_40_PERCENT.getIndex());
        style.setDataFormat(wb.createDataFormat().getFormat("0"));
        styles.put(INTEGER, style);

        style = wb.createCellStyle();
        style.setAlignment(CellStyle.ALIGN_CENTER);
        style.setFont(cFont);
        style.setDataFormat(wb.createDataFormat().getFormat("d/m/yy"));
        styles.put(DATE, style);

        return styles;
    }
}
