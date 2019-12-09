package com.sp.common;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.view.document.AbstractXlsView;

@Service
public class MyExcelView extends AbstractXlsView {

	@SuppressWarnings("unchecked")
	@Override
	protected void buildExcelDocument(Map<String, Object> model, Workbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String filename = (String) model.get("filename");
		String sheetName = (String) model.get("sheetName");

		List<String> columnLabels = (List<String>) model.get("columnLabels");
		List<Object[]> columnValues = (List<Object[]>) model.get("columnValues");

		response.setContentType("application/ms-excel");
		response.setHeader("Content-disposition", "attachment; filename=" + filename);

		Sheet sheet = createSheet(workbook, 0, sheetName);
		createColumnLabel(sheet, columnLabels);
		createColumnValue(sheet, columnValues);

	}

	// sheet 만들기
	protected Sheet createSheet(Workbook book, int sheetIdx, String sheetName) {
		Sheet sheet = book.createSheet();
		book.setSheetName(sheetIdx, sheetName);
		return sheet;
	}

	// 제목줄 만들기
	protected void createColumnLabel(Sheet sheet, List<String> columnLabels) {
		Row row = sheet.createRow(0);

		Cell cell;
		for (int idx = 0; idx < columnLabels.size(); idx++) {
			sheet.setColumnWidth(idx, 256 * 15); // 컬럼 폭

			cell = row.createCell(idx);
			cell.setCellValue(columnLabels.get(idx));
		}
	}

	// 내용
	protected void createColumnValue(Sheet sheet, List<Object[]> columnValues) {
		Row row;
		Cell cell;
		for (int idx = 0; idx < columnValues.size(); idx++) {
			row = sheet.createRow(idx + 1);

			Object[] values = columnValues.get(idx);
			for (int col = 0; col < values.length; col++) {
				cell = row.createCell(col);
				if (values[col] instanceof Short) {
					cell.setCellValue((Short) values[col]);
				} else if (values[col] instanceof Integer) {
					cell.setCellValue((Integer) values[col]);
				} else if (values[col] instanceof Long) {
					cell.setCellValue((Long) values[col]);
				} else if (values[col] instanceof Float) {
					cell.setCellValue((Float) values[col]);
				} else if (values[col] instanceof Double) {
					cell.setCellValue((Double) values[col]);
				} else if (values[col] instanceof String) {
					cell.setCellValue((String) values[col]);
				} else {
					cell.setCellValue(values[col].toString());
				}

			}
		}

	}
}
