package org.parish360.core.configurations.service.impl;

import org.parish360.core.common.util.UUIDUtil;
import org.parish360.core.configurations.dto.AccountInfo;
import org.parish360.core.configurations.service.AccountManager;
import org.parish360.core.configurations.service.ConfigurationMapper;
import org.parish360.core.dao.entities.configurations.Account;
import org.parish360.core.dao.entities.dataowner.Parish;
import org.parish360.core.dao.repository.configurations.AccountRepository;
import org.parish360.core.dao.repository.dataowner.ParishRepository;
import org.parish360.core.error.exception.ResourceNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AccountManagerImpl implements AccountManager {
    private final ConfigurationMapper configurationMapper;
    private final ParishRepository parishRepository;
    private final AccountRepository accountRepository;

    public AccountManagerImpl(ConfigurationMapper configurationMapper, ParishRepository parishRepository, AccountRepository accountRepository) {
        this.configurationMapper = configurationMapper;
        this.parishRepository = parishRepository;
        this.accountRepository = accountRepository;
    }

    @Override
    public AccountInfo createAccountInfo(String parishId, AccountInfo accountInfo) {
        //find parish information
        Parish parish = parishRepository
                .findById(UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("could not parish information"));

        Account account = configurationMapper.accountInfoToDao(accountInfo);
        account.setParish(parish);

        return configurationMapper.daoToAccountInfo(accountRepository.save(account));
    }

    @Override
    public AccountInfo updateAccountInfo(String parishId, String accountId, AccountInfo accountInfo) {
        // fetch account information
        Account currentAccount = accountRepository
                .findByIdAndParishId(UUIDUtil.decode(accountId), UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find account information"));

        Account updateAccount = configurationMapper.accountInfoToDao(accountInfo);
        configurationMapper.mergeNotNullAccountInfo(updateAccount, currentAccount);

        return configurationMapper.daoToAccountInfo(accountRepository.save(currentAccount));
    }

    @Override
    public AccountInfo getAccountInfo(String parishId, String accountId) {
        return configurationMapper
                .daoToAccountInfo(accountRepository
                        .findByIdAndParishId(UUIDUtil.decode(accountId), UUIDUtil.decode(parishId))
                        .orElseThrow(() -> new ResourceNotFoundException("could not find account information")));
    }

    @Override
    public List<AccountInfo> getListOfAccounts(String parishId) {
        List<Account> accounts = accountRepository
                .findByParishId(UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find account list"));

        return accounts.stream()
                .map(configurationMapper::daoToAccountInfo)
                .toList();
    }

    @Override
    public void deleteAccountInfo(String parishId, String accountId) {
        Account account = accountRepository
                .findByIdAndParishId(UUIDUtil.decode(accountId), UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find account information"));

        accountRepository.delete(account);
    }
}
