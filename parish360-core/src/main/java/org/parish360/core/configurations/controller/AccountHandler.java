package org.parish360.core.configurations.controller;

import jakarta.validation.Valid;
import org.parish360.core.configurations.dto.AccountInfo;
import org.parish360.core.configurations.service.AccountManager;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/parish/{parishId}/configurations/accounts")
public class AccountHandler {
    private final AccountManager accountManager;

    public AccountHandler(AccountManager accountManager) {
        this.accountManager = accountManager;
    }

    @PostMapping
    public ResponseEntity<AccountInfo> createAccountInfo(@PathVariable("parishId") String parishId,
                                                         @Valid @RequestBody AccountInfo accountInfo) {
        return ResponseEntity.ok(accountManager.createAccountInfo(parishId, accountInfo));
    }

    @PatchMapping("/{accountId}")
    public ResponseEntity<AccountInfo> updateAccountInfo(@PathVariable("parishId") String parishId,
                                                         @PathVariable("accountId") String accountId,
                                                         @Valid @RequestBody AccountInfo accountInfo) {
        return ResponseEntity.ok(accountManager.updateAccountInfo(parishId, accountId, accountInfo));
    }

    @GetMapping("/{accountId}")
    public ResponseEntity<AccountInfo> getAccountInfo(@PathVariable("parishId") String parishId,
                                                      @PathVariable("accountId") String accountId) {
        return ResponseEntity.ok(accountManager.getAccountInfo(parishId, accountId));
    }

    @GetMapping
    public ResponseEntity<List<AccountInfo>> getListOfAccounts(@PathVariable("parishId") String parishId) {
        return ResponseEntity.ok(accountManager.getListOfAccounts(parishId));
    }

    @DeleteMapping("/{accountId}")
    public ResponseEntity<Object> deleteAccountInfo(@PathVariable("parishId") String parishId,
                                                    @PathVariable("accountId") String accountId) {
        accountManager.deleteAccountInfo(parishId, accountId);
        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }

}
