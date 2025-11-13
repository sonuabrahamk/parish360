package org.parish360.core.expenses.controller;

import com.lowagie.text.*;
import com.lowagie.text.pdf.PdfWriter;
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
            Font titleFont = new Font(Font.HELVETICA, 18, Font.BOLD);
            Paragraph title = new Paragraph("Expense Voucher", titleFont);
            title.setAlignment(Element.ALIGN_CENTER);
            document.add(title);
            document.add(Chunk.NEWLINE);

            // Customer and details
            Font textFont = new Font(Font.HELVETICA, 12);
            document.add(new Paragraph("Voucher ID: " + expenseInfo.getId(), textFont));
            document.add(new Paragraph("Payment To: " + expenseInfo.getPaidTo(), textFont));
            document.add(new Paragraph("Date: " +
                    expenseInfo.getDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")), textFont));
            document.add(Chunk.NEWLINE);
            document.add(Chunk.NEWLINE);
            document.add(new Paragraph("Thank you for your service!", textFont));

            document.close();
            return baos.toByteArray();

        } catch (Exception e) {
            throw new RuntimeException("Error creating PDF", e);
        }
    }
}
