package org.parish360.core.dao.repository.family;

import org.parish360.core.dao.entities.family.Member;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface MemberRepository extends JpaRepository<Member, UUID> {
    Optional<Member> findByIdAndFamilyId(UUID memberId, UUID familyId);

    Optional<List<Member>> findByFamilyId(UUID familyId);

    Optional<List<Member>> findByParishId(UUID parishId);
}
