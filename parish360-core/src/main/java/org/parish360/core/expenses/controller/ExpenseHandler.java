package org.parish360.core.expenses.controller;

import com.lowagie.text.*;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;
import com.lowagie.text.pdf.draw.LineSeparator;
import jakarta.validation.Valid;
import org.parish360.core.expenses.dto.ExpenseInfo;
import org.parish360.core.expenses.service.ExpenseManager;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.ByteArrayOutputStream;
import java.time.format.DateTimeFormatter;
import java.util.List;

@RestController
@RequestMapping("/parish/{parishId}/expenses")
public class ExpenseHandler {
    private final ExpenseManager expenseManager;

    public ExpenseHandler(ExpenseManager expenseManager) {
        this.expenseManager = expenseManager;
    }

    @PostMapping
    public ResponseEntity<byte[]> createExpenseInfo(@PathVariable("parishId") String parishId,
                                                    @Valid @RequestBody ExpenseInfo expenseInfo) {
        ExpenseInfo expense = expenseManager.createExpense(parishId, expenseInfo);
        byte[] pdfBytes = createVoucherPdf(expense);

        HttpHeaders headers = new HttpHeaders();
        headers.add(HttpHeaders.CONTENT_DISPOSITION,
                "inline; filename=voucher-" + expenseInfo.getId() + ".pdf");
        headers.add(HttpHeaders.CONTENT_TYPE, "application/pdf");
        return ResponseEntity.ok()
                .headers(headers)
                .contentLength(pdfBytes.length)
                .contentType(MediaType.APPLICATION_PDF)
                .body(pdfBytes);
    }

    @PatchMapping("/{expenseId}")
    public ResponseEntity<ExpenseInfo> updateExpenseInfo(@PathVariable("parishId") String parishId,
                                                         @PathVariable("expenseId") String expenseId,
                                                         @Valid @RequestBody ExpenseInfo expenseInfo) {
        return ResponseEntity.ok(expenseManager.updateExpense(parishId, expenseId, expenseInfo));
    }

    @GetMapping("/{expenseId}")
    public ResponseEntity<ExpenseInfo> getExpenseInfo(@PathVariable("parishId") String parishId,
                                                      @PathVariable("expenseId") String expenseId) {
        return ResponseEntity.ok(expenseManager.getExpenseInfo(parishId, expenseId));
    }

    @GetMapping
    public ResponseEntity<List<ExpenseInfo>> getListOfExpenses(@PathVariable("parishId") String parishId) {
        return ResponseEntity.ok(expenseManager.getListOfExpenses(parishId));
    }

    @DeleteMapping("/{expenseId}")
    public ResponseEntity<ExpenseInfo> deleteExpenseInfo(@PathVariable("parishId") String parishId,
                                                         @PathVariable("expenseId") String expenseId) {
        expenseManager.deleteExpenseInfo(parishId, expenseId);
        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }

    @GetMapping("/{expenseId}/voucher")
    public ResponseEntity<byte[]> getPaymentReceipt(@PathVariable("parishId") String parishId,
                                                    @PathVariable("expenseId") String expenseId) {
        ExpenseInfo expenseInfo = expenseManager.getExpenseInfo(parishId, expenseId);
        byte[] pdfBytes = createVoucherPdf(expenseInfo);

        HttpHeaders headers = new HttpHeaders();
        headers.add(HttpHeaders.CONTENT_DISPOSITION,
                "inline; filename=voucher-" + expenseInfo.getId() + ".pdf");
        headers.add(HttpHeaders.CONTENT_TYPE, "application/pdf");
        return ResponseEntity.ok()
                .headers(headers)
                .contentLength(pdfBytes.length)
                .contentType(MediaType.APPLICATION_PDF)
                .body(pdfBytes);
    }

    private byte[] createVoucherPdf(ExpenseInfo expenseInfo) {
        try (ByteArrayOutputStream baos = new ByteArrayOutputStream()) {
            Document document = new Document(PageSize.A4, 36, 36, 36, 36);
            PdfWriter.getInstance(document, baos);

            document.open();

            // Title
            Font titleFont = new Font(Font.HELVETICA, 14, Font.BOLD);
            Paragraph title = new Paragraph("Expense Voucher", titleFont);
            title.setAlignment(Element.ALIGN_CENTER);
            document.add(title);

            // Add a thin line separator below the title
            LineSeparator ls = new LineSeparator();
            document.add(new Chunk(ls));


            // Table
            PdfPTable table = new PdfPTable(3);
            table.setWidthPercentage(100);

            addCell(table, "Voucher No: " + expenseInfo.getId(), 2);
            addCell(table, "Date: " + expenseInfo
                    .getDate()
                    .format(DateTimeFormatter.ofPattern("yyyy-MM-dd")), 1);

            addCell(table, "Paid To: " + expenseInfo.getPaidTo(), 3);

            addCell(table, "Description: " + expenseInfo.getDescription(), 3);

            addCell(table, "Paid By: " + expenseInfo.getPaidBy(), 1);
            addCell(table, "Amount: " + expenseInfo.getAmount().toString()
                    + " " + expenseInfo.getCurrency(), 1);
            addCell(table, "Payment Mode: CASH", 1);

            document.add(table);

            document.add(Chunk.NEWLINE);
            document.add(Chunk.NEWLINE);
            document.add(addSignatureSpace());
            document.add(Chunk.NEWLINE);

            // Note section
            Font noteFont = new Font(Font.HELVETICA, 8);
            document.add(new Paragraph("NOTE: This is a system generated voucher", noteFont));

            document.close();
            return baos.toByteArray();

        } catch (Exception e) {
            throw new RuntimeException("Error creating PDF", e);
        }
    }

    private void addCell(PdfPTable table, String text, int colSpan) {
        Font tableFont = new Font(Font.TIMES_ROMAN, 11);
        PdfPCell cell = new PdfPCell(new Phrase(text != null ? text : "", tableFont));
        cell.setPadding(10);
        cell.setColspan(colSpan);
        table.addCell(cell);
    }

    private PdfPTable addSignatureSpace() {
        // Create a 2-column table for "Approved By" and "Received By"
        PdfPTable signTable = new PdfPTable(2);
        signTable.setWidthPercentage(100);
        signTable.getDefaultCell().setBorder(Rectangle.NO_BORDER);

        // Left cell (Approved By)
        PdfPCell leftCell = new PdfPCell();
        leftCell.setBorder(Rectangle.NO_BORDER);
        leftCell.setHorizontalAlignment(Element.ALIGN_CENTER);

        // Add signature line (underline effect)
        Paragraph approved = new Paragraph("__________________________\n Parish Priest");
        approved.setAlignment(Element.ALIGN_LEFT);
        leftCell.addElement(approved);

        // Right cell (Received By)
        PdfPCell rightCell = new PdfPCell();
        rightCell.setBorder(Rectangle.NO_BORDER);
        rightCell.setHorizontalAlignment(Element.ALIGN_CENTER);

        Paragraph received = new Paragraph("__________________________\n Received By");
        received.setAlignment(Element.ALIGN_RIGHT);
        rightCell.addElement(received);

        // Add both cells
        signTable.addCell(leftCell);
        signTable.addCell(rightCell);

        // Add the signature table to the document
        return signTable;
    }
}
