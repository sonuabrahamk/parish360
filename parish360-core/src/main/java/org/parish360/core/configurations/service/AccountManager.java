package org.parish360.core.configurations.service;

import org.parish360.core.configurations.dto.AccountInfo;

import java.util.List;

public interface AccountManager {
    AccountInfo createAccountInfo(String parishId, AccountInfo accountInfo);

    AccountInfo updateAccountInfo(String parishId, String accountId, AccountInfo accountInfo);

    AccountInfo getAccountInfo(String parishId, String accountId);

    List<AccountInfo> getListOfAccounts(String parishId);

    void deleteAccountInfo(String parishId, String accountId);
}
