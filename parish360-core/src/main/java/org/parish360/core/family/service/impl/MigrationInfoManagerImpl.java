package org.parish360.core.family.service.impl;

import org.parish360.core.common.util.UUIDUtil;
import org.parish360.core.dao.entities.family.Member;
import org.parish360.core.dao.entities.family.Migration;
import org.parish360.core.dao.repository.family.MemberRepository;
import org.parish360.core.dao.repository.family.MigrationRepository;
import org.parish360.core.error.exception.ResourceNotFoundException;
import org.parish360.core.family.dto.MigrationInfo;
import org.parish360.core.family.service.FamilyMapper;
import org.parish360.core.family.service.MigrationInfoManager;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MigrationInfoManagerImpl implements MigrationInfoManager {
    private final FamilyMapper familyMapper;
    private final MemberRepository memberRepository;
    private final MigrationRepository migrationRepository;

    public MigrationInfoManagerImpl(FamilyMapper familyMapper, MemberRepository memberRepository, MigrationRepository migrationRepository) {
        this.familyMapper = familyMapper;
        this.memberRepository = memberRepository;
        this.migrationRepository = migrationRepository;
    }

    @Override
    public MigrationInfo createMigrationInfo(String familyId, String memberId, MigrationInfo migrationInfo) {
        // fetch member information
        Member member = memberRepository.findByIdAndFamilyId(
                        UUIDUtil.decode(memberId), UUIDUtil.decode(familyId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find member information"));

        Migration migration = familyMapper.migrationInfoToDao(migrationInfo);
        migration.setMember(member);

        return familyMapper.daoToMigrationInfo(
                migrationRepository.save(migration));
    }

    @Override
    public MigrationInfo updateMigrationInfo(String memberId, String migrationId, MigrationInfo migrationInfo) {
        // fetch current migration information
        Migration currentMigration = migrationRepository.findByIdAndMemberId(
                        UUIDUtil.decode(migrationId), UUIDUtil.decode(memberId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find migration information"));

        Migration updateMigration = familyMapper.migrationInfoToDao(migrationInfo);
        familyMapper.mergeNotNullMigrationFieldToTarget(updateMigration, currentMigration);

        return familyMapper.daoToMigrationInfo(
                migrationRepository.save(currentMigration));
    }

    @Override
    public MigrationInfo getMigrationInfo(String memberId, String migrationId) {
        return familyMapper.daoToMigrationInfo(
                migrationRepository.findByIdAndMemberId(
                                UUIDUtil.decode(migrationId), UUIDUtil.decode(memberId))
                        .orElseThrow(() -> new ResourceNotFoundException("could not find migration information")));
    }

    @Override
    public List<MigrationInfo> getMigrationInfoList(String memberId) {
        // fetch migrations List
        List<Migration> migrations = migrationRepository.findByMemberId(
                        UUIDUtil.decode(memberId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find migrations information"));

        return migrations.stream()
                .map(familyMapper::daoToMigrationInfo)
                .toList();
    }

    @Override
    public void deleteMigrationInfo(String memberId, String migrationId) {
        // fetch migration information
        Migration migration = migrationRepository.findByIdAndMemberId(
                        UUIDUtil.decode(migrationId), UUIDUtil.decode(memberId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find migration information"));

        migrationRepository.delete(migration);
    }
}
