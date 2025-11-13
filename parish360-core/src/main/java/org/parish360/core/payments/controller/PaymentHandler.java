package org.parish360.core.payments.controller;

import com.lowagie.text.*;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;
import com.lowagie.text.pdf.draw.LineSeparator;
import jakarta.validation.Valid;
import org.parish360.core.payments.dto.PaymentInfo;
import org.parish360.core.payments.service.PaymentManager;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.ByteArrayOutputStream;
import java.time.format.DateTimeFormatter;
import java.util.List;

@RestController
@RequestMapping("/parish/{parishId}/payments")
public class PaymentHandler {
    private final PaymentManager paymentManager;

    public PaymentHandler(PaymentManager paymentManager) {
        this.paymentManager = paymentManager;
    }

    @PostMapping
    public ResponseEntity<byte[]> createPayment(@PathVariable("parishId") String parishId,
                                                @Valid @RequestBody PaymentInfo paymentInfo) {
        PaymentInfo payment = paymentManager.createPayment(parishId, paymentInfo);
        byte[] pdfBytes = createReceiptPdf(payment);

        HttpHeaders headers = new HttpHeaders();
        headers.add(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=receipt-" + payment.getId() + ".pdf");
        headers.add(HttpHeaders.CONTENT_TYPE, "application/pdf");
        return ResponseEntity.ok()
                .headers(headers)
                .contentLength(pdfBytes.length)
                .contentType(MediaType.APPLICATION_PDF)
                .body(pdfBytes);
    }

    @PatchMapping("/{paymentId}")
    public ResponseEntity<PaymentInfo> updatePayment(@PathVariable("parishId") String parishId,
                                                     @PathVariable("paymentId") String paymentId,
                                                     @Valid @RequestBody PaymentInfo paymentInfo) {
        return ResponseEntity.ok(paymentManager.updatePayment(parishId, paymentId, paymentInfo));
    }

    @GetMapping("/{paymentId}")
    public ResponseEntity<PaymentInfo> getPayment(@PathVariable("parishId") String parishId,
                                                  @PathVariable("paymentId") String paymentId) {
        return ResponseEntity.ok(paymentManager.getPaymentInfo(parishId, paymentId));
    }

    @GetMapping
    public ResponseEntity<List<PaymentInfo>> getPaymentListByParish(@PathVariable("parishId") String parishId) {
        return ResponseEntity.ok(paymentManager.getListOfPayments(parishId));
    }

    @DeleteMapping("/{paymentId}")
    public ResponseEntity<Object> deletePayment(@PathVariable("parishId") String parishId,
                                                @PathVariable("paymentId") String paymentId) {
        paymentManager.deletePaymentInfo(parishId, paymentId);
        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }

    @GetMapping("/{paymentId}/receipt")
    public ResponseEntity<byte[]> getPaymentReceipt(@PathVariable("parishId") String parishId,
                                                    @PathVariable("paymentId") String paymentId) {
        PaymentInfo paymentInfo = paymentManager.getPaymentInfo(parishId, paymentId);
        byte[] pdfBytes = createReceiptPdf(paymentInfo);

        HttpHeaders headers = new HttpHeaders();
        headers.add(HttpHeaders.CONTENT_DISPOSITION,
                "inline; filename=receipt-" + paymentInfo.getId() + ".pdf");
        headers.add(HttpHeaders.CONTENT_TYPE, "application/pdf");
        return ResponseEntity.ok()
                .headers(headers)
                .contentLength(pdfBytes.length)
                .contentType(MediaType.APPLICATION_PDF)
                .body(pdfBytes);
    }

    private byte[] createReceiptPdf(PaymentInfo paymentInfo) {
        try (ByteArrayOutputStream baos = new ByteArrayOutputStream()) {
            Document document = new Document(PageSize.A4, 36, 36, 36, 36);
            PdfWriter.getInstance(document, baos);

            document.open();

            // Title
            Font titleFont = new Font(Font.HELVETICA, 14, Font.BOLD);
            Paragraph title = new Paragraph("Payment Receipt", titleFont);
            title.setAlignment(Element.ALIGN_CENTER);
            document.add(title);

            // Add a thin line separator below the title
            LineSeparator ls = new LineSeparator();
            document.add(new Chunk(ls));


            // Table
            PdfPTable table = new PdfPTable(3);
            table.setWidthPercentage(100);

            addCell(table, "Receipt No: " + paymentInfo.getId(), 2);
            addCell(table, "Date: " + paymentInfo
                    .getCreatedAt()
                    .format(DateTimeFormatter.ofPattern("yyyy-MM-dd")), 1);

            addCell(table, "Paid By: " + paymentInfo.getPayee(), 3);

            addCell(table, "Description: " + paymentInfo.getDescription(), 3);

            addCell(table, "Received By: " + paymentInfo.getPaidTo(), 1);
            addCell(table, "Amount: " + paymentInfo.getAmount().toString()
                    + " " + paymentInfo.getCurrency(), 1);
            addCell(table, "Payment Mode: CASH", 1);

            document.add(table);

            document.add(Chunk.NEWLINE);
            document.add(Chunk.NEWLINE);
            document.add(addSignatureSpace());
            document.add(Chunk.NEWLINE);

            // Note section
            Font noteFont = new Font(Font.HELVETICA, 8);
            document.add(new Paragraph("NOTE: This is a system generated receipt", noteFont));

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
