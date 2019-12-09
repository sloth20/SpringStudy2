package com.sp.pscore;

import java.awt.Color;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.document.AbstractPdfView;

import com.lowagie.text.Cell;
import com.lowagie.text.Document;
import com.lowagie.text.Font;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;

public class ScorePdfView extends AbstractPdfView {

	@SuppressWarnings("unchecked")
	@Override
	protected void buildPdfDocument(Map<String, Object> model, Document document, PdfWriter writer,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		String filename = (String) model.get("filename");

		List<String> columnLabels = (List<String>) model.get("columnLabels");
		List<String[]> columnValues = (List<String[]>) model.get("columnValues");

		response.setContentType("application/pdf");
		response.setHeader("Content-disposition", "attachment; filename=" + filename);

		BaseFont baseFont = BaseFont.createFont("c:\\windows\\fonts\\gulim.ttc,0", BaseFont.IDENTITY_H,
				BaseFont.EMBEDDED);
		Font font = new Font(baseFont);

		font.setSize(20);
		Paragraph p = new Paragraph("성적처리", font);
		p.setAlignment(Paragraph.ALIGN_CENTER);
		document.add(p);

		font.setSize(10);
		PdfPTable table = new PdfPTable(columnLabels.size()); // 한 행의 컬럼 수
		table.setWidths(new int[] { 50, 100, 80, 80, 80 });
		table.setSpacingBefore(10);

		PdfPCell cell;
		for (int i = 0; i < columnLabels.size(); i++) {
			cell = new PdfPCell(new Paragraph(columnLabels.get(i), font));
			cell.setBackgroundColor(new Color(211, 244, 250));
			cell.setHorizontalAlignment(Cell.ALIGN_CENTER);
			cell.setPadding(3);
			table.addCell(cell);
		}

		for (int row = 0; row < columnValues.size(); row++) {
			String[] values = columnValues.get(row);

			for (int col = 0; col < values.length; col++) {
				cell = new PdfPCell(new Paragraph(values[col], font));
				cell.setHorizontalAlignment(Cell.ALIGN_CENTER);
				cell.setPadding(3);
				table.addCell(cell);
			}
		}

		document.add(table);
	}

}
